module "ec2" {
  source = "./ec2"
  ec2_public_key = var.ec2_public_key
}

module "eks" {
  source = "./eks"
}