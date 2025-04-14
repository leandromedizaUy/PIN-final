### Claves acceso SSH ###
resource "aws_key_pair" "remote-host-control-ssh" {
  # ssh-keygen -t rsa -b 2048 -f "remote-host-control"
  key_name = "${var.server_name}-ssh"
  public_key = file("~/.ssh/pin.pub")

  tags = {
    Name = "${var.server_name}-ssh"
    Owner = var.owner
    Team = var.team
  }
}