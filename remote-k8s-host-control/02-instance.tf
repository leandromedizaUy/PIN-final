# Crear la IAM Role para la instancia EC2
resource "aws_iam_role" "ec2_admin" {
  name = "ec2-admin"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ebs_access" {
  role       = aws_iam_role.ec2_admin.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2-instance-profile"
  role = aws_iam_role.ec2_admin.name
}

resource "aws_instance" "remote-host-control" {
  ami = var.ami_id #ubuntu
  instance_type = var.instance_type

  # ejecutar un script inmediatamente despues de crear la instancia EC2:
  user_data = "${file("set-k8s-host-control.sh")}"

  # Asigna la llave que hemos creado a la instancia:
  key_name = aws_key_pair.remote-host-control-ssh.key_name

  # Asigna los SG a la instancia:
  vpc_security_group_ids = [
    aws_security_group.remote-host-control-sg.id
  ]

  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

  tags = {
    Name = var.server_name
    Owner = var.owner
    Team = var.team
  }
}