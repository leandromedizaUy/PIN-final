### OUTPUTS ###
output "server_public_ip" {
  description = "Dirección IP publica de la instancia EC2"
  value = aws_instance.remote-host-control.public_ip
}

output "server_public_dns" {
  description = "DNS Publico de la instancia EC2"
  value = aws_instance.remote-host-control.public_dns
}