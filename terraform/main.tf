provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "pin_key" {
  key_name   = "pin"
  public_key = file("~/.ssh/pin.pub")
}

resource "aws_instance" "jenkins_ec2" {
  ami                         = "ami-0c02fb55956c7d316"
  instance_type               = "t3.nano"
  key_name                    = aws_key_pair.pin_key.key_name
  associate_public_ip_address = true
  user_data = file("scripts/install_jenkins.sh")
  tags = {
    Name = "Jenkins EC2"
  }
}

output "ec2_public_ip" {
  value = aws_instance.jenkins_ec2.public_ip
}