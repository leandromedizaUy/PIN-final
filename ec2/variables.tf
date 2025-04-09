variable "ec2_public_key" {
  description = "Clave pública SSH para acceder a EC2"
  type        = string
}

resource "random_string" "test" {
  length = 4
  lower  = true
}