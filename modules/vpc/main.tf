module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.0"

  name = var.name
  cidr = var.cidr_block

  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = true


  public_subnet_tags = {
    "kubernetes.io/cluster/eks-mundos-e" = "owned"
    "kubernetes.io/role/elb"             = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/eks-mundos-e" = "owned"
    "kubernetes.io/role/internal-elb"    = "1"
  }

  tags = var.tags
}