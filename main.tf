terraform {
  backend "s3"{
    bucket                 = "pin2404"
    region                 = "us-east-1"
    key                    = "terraform.tfstate"
  }
}

### module ###

module "network" {
  source            = "./modules/vpc"
  name              = "my-vpc"
  cidr_block        = "10.0.0.0/16"
  azs               = ["us-east-1a", "us-east-1b"]
  public_subnets    = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets   = ["10.0.101.0/24", "10.0.102.0/24"]
  enable_nat_gateway = true

  tags = {
    "Environment" = "dev"
    "Owner"       = "infra"
  }
}

module "remote_k8s_host" {
  source = "./modules/remote-k8s-host-control"
  ami_id = "ami-084568db4383264d4"
  instance_type = "t2.micro"
  server_name = "remote-host-control"
  owner = "leandromediza@gmail.com"
  team = "devops"
  vpc_id  = module.network.vpc_id
  public_subnet_ids = module.network.public_subnet_ids
}

module "eks_cluster" {
  source          = "./modules/eks_cluster"
  cluster_name    = "eks-mundos-e"
  vpc_id  = module.network.vpc_id
  private_subnet_ids = module.network.private_subnet_ids
}

resource "aws_iam_role" "eks_node_role" {
  name = "eks-node-group-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Effect = "Allow"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

# Este es importante para trabajar con volúmenes EBS
resource "aws_iam_role_policy_attachment" "AmazonEBSCSIDriverPolicy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

module "eks_node_group" {
  source           = "./modules/eks_node_group"
  cluster_name     = "eks-mundos-e"
  node_group_name  = "ng-mundos-e"
  node_role_arn    = aws_iam_role.eks_node_role.arn
  subnet_ids       = module.network.private_subnet_ids
  ssh_key_name     = module.remote_k8s_host.public_ssh
  instance_types   = ["t3.medium"]
  desired_size     = 2
  min_size         = 1
  max_size         = 3
  depends_on_eks_cluster = module.eks_cluster

  tags = {
    "Name"        = "eks-node-group"
    "Environment" = "dev"
  }
}

### OUTPUTS ###
output "remote_k8s_host_public_ip" {
  description = "Dirección IP publica de la instancia EC2 QA:"
  value = module.remote_k8s_host.server_public_ip
}

output "remote_k8s_host_public_dns" {
  description = "DNS Publico de la instancia EC2 QA: "
  value = module.remote_k8s_host.server_public_dns
}