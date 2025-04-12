output "_eks_cluster_name" {
  description = "The name of the EKS cluster"
  value       = aws_eks_cluster.eks_cluster.name
}

output "_eks_cluster_endpoint" {
  description = "The endpoint of the EKS cluster"
  value       = aws_eks_cluster.eks_cluster.endpoint
}

output "_eks_cluster_arn" {
  description = "The ARN of the EKS cluster"
  value       = aws_eks_cluster.eks_cluster.arn
}

output "_eks_subnet_ids" {
  description = "The IDs of the created subnets"
  value       = [aws_subnet.eks_subnet_a.id, aws_subnet.eks_subnet_b.id]
}
