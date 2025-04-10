provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "pin_key" {
  key_name   = "pin"
  public_key = file("~/.ssh/pin.pub")
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins_sg"
  description = "Allow SSH from anywhere (solo para testing)"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "jenkins_ec2" {
  ami                         = "ami-0655cec52acf2717b"
  instance_type               = "t3.small"
  key_name                    = aws_key_pair.pin_key.key_name
  vpc_security_group_ids      = [aws_security_group.jenkins_sg.id]
  associate_public_ip_address = true
  //user_data = file("${path.module}/../scripts/install_jenkins.sh")
  tags = {
    Name = "MundosE"
  }
}

output "ec2_public_ip" {
  value = aws_instance.jenkins_ec2.public_ip
}