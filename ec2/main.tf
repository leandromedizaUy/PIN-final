provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "pin" {
  key_name   = "pin"
  public_key = var.ec2_public_key
}

resource "aws_instance" "devops_ec2" {
  ami                         = "ami-0fc5d935ebf8bc3bc" # Ubuntu 22.04
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.pin.key_name
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.ec2_admin.name

  user_data = file("./ec2/user_data.sh")

  tags = {
    Name = "devops-admin"
  }
}

resource "aws_iam_role" "ec2_role" {
  name = "ec2-admin"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ec2_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_instance_profile" "ec2_admin" {
  name = "ec2-admin-iam-profile"
  role = aws_iam_role.ec2_role.name
}
