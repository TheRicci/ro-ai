output "cluster_name" {
  description = "Name of the EKS cluster."
  value       = aws_eks_cluster.this.name
}

output "cluster_arn" {
  description = "ARN of the EKS cluster."
  value       = aws_eks_cluster.this.arn
}

output "cluster_endpoint" {
  description = "Endpoint of the EKS cluster."
  value       = aws_eks_cluster.this.endpoint
}

output "cluster_version" {
  description = "Kubernetes version of the EKS cluster."
  value       = aws_eks_cluster.this.version
}

output "cluster_security_group_id" {
  description = "Cluster security group created by EKS."
  value       = aws_eks_cluster.this.vpc_config[0].cluster_security_group_id
}

output "cluster_role_arn" {
  description = "IAM role ARN used by the EKS control plane."
  value       = aws_iam_role.cluster.arn
}

output "node_role_arn" {
  description = "IAM role ARN used by the managed node group."
  value       = aws_iam_role.node.arn
}

output "node_group_name" {
  description = "Name of the managed node group."
  value       = aws_eks_node_group.core.node_group_name
}

output "oidc_issuer" {
  description = "OIDC issuer URL reported by the EKS cluster."
  value       = aws_eks_cluster.this.identity[0].oidc[0].issuer
}
