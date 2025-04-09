module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "eks-mundos-e"
  cluster_version = "1.27"
  subnet_ids = module.vpc.public_subnets
  vpc_id          = module.vpc.vpc_id

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  public_access_cidrs = ["0.0.0.0/0"]

  eks_managed_node_groups = {
    default = {
      desired_size = 1
      max_size     = 1
      min_size     = 1

      instance_types = ["t3.small"]
      capacity_type  = "ON_DEMAND"
    }
  }

  aws_auth_roles = [
    {
      rolearn  = "arn:aws:iam::123456789012:role/github-actions-eks-role"
      username = "github"
      groups   = ["system:masters"]
    }
  ]

  enable_irsa = truemanage_aws_auth_configmap = true
}


module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  name    = "eks-vpc"
  cidr    = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  enable_dns_hostnames = true
  enable_dns_support   = true
  map_public_ip_on_launch = true
}