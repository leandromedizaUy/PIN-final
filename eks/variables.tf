variable "cluster_name" {
  description = "Nombre del cluster EKS"
  type        = string
  default     = "eks-mundos-e"
}

variable "cluster_version" {
  description = "Versión de Kubernetes"
  type        = string
  default     = "1.27"
}