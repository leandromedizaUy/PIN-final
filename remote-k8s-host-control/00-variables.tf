### Variables ###
variable "ami_id" {
  description = "ID de la AMI para la instancia EC2"
  default = "ami-084568db4383264d4"
}

variable "instance_type" {
  description = "Tipo de Instancia EC2"
  default = "t2.micro"
}

variable "server_name" {
  description = "Nombre del servidor web"
  default = "remote-host-control"
}

variable "owner" {
  description = "Owner Email"
  default = "diegofernando150@gmail.com"
}

variable "team" {
  description = "team project"
  default = "devops"
}