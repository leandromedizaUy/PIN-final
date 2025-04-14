variable "cluster_name" {}
variable "node_group_name" {}
variable "node_role_arn" {}
variable "subnet_ids" {}
variable "ssh_key_name" {}
variable "desired_size" {
  default = 2
}
variable "min_size" {
  default = 1
}
variable "max_size" {
  default = 3
}
variable "instance_types" {
  default = ["t3.medium"]
}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "depends_on_eks_cluster" {}
