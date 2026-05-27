output "cluster_name" {
  description = "Name of the EKS cluster."
  value       = module.eks_platform.cluster_name
}

output "cluster_support_enabled_addons" {
  description = "Names of the Terraform-managed EKS add-ons."
  value       = module.cluster_support.enabled_addons
}

output "cluster_support_addon_arns" {
  description = "ARNs of the Terraform-managed EKS add-ons."
  value       = module.cluster_support.addon_arns
}

output "cluster_support_addon_statuses" {
  description = "Status values of the Terraform-managed EKS add-ons."
  value       = module.cluster_support.addon_statuses
}

output "vpc_id" {
  description = "VPC ID."
  value       = module.network_foundation.vpc_id
}

output "private_subnet_ids" {
  description = "Private subnet IDs."
  value       = module.network_foundation.private_subnet_ids
}

output "world_db_security_group_id" {
  description = "World DB security group ID."
  value       = module.network_foundation.world_db_security_group_id
}

output "cluster_endpoint" {
  description = "Endpoint of the EKS cluster."
  value       = module.eks_platform.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Cluster security group ID."
  value       = module.eks_platform.cluster_security_group_id
}

output "cluster_role_arn" {
  description = "Cluster IAM role ARN."
  value       = module.eks_platform.cluster_role_arn
}

output "node_role_arn" {
  description = "Managed node group IAM role ARN."
  value       = module.eks_platform.node_role_arn
}

output "oidc_issuer" {
  description = "OIDC issuer URL reported by the EKS cluster."
  value       = module.eks_platform.oidc_issuer
}

output "workload_role_names" {
  description = "Map of workload IAM role names."
  value       = module.workload_identity.role_names
}

output "workload_role_arns" {
  description = "Map of workload IAM role ARNs."
  value       = module.workload_identity.role_arns
}

output "pod_identity_association_ids" {
  description = "Map of pod identity association IDs."
  value       = module.workload_identity.association_ids
}

output "bot_memory_table_name" {
  description = "Name of the bot memory DynamoDB table."
  value       = module.bot_data_plane.bot_memory_table_name
}

output "bot_memory_table_arn" {
  description = "ARN of the bot memory DynamoDB table."
  value       = module.bot_data_plane.bot_memory_table_arn
}

output "bot_artifacts_bucket_name" {
  description = "Name of the bot artifacts S3 bucket."
  value       = module.bot_data_plane.bot_artifacts_bucket_name
}

output "bot_artifacts_bucket_arn" {
  description = "ARN of the bot artifacts S3 bucket."
  value       = module.bot_data_plane.bot_artifacts_bucket_arn
}

output "world_db_instance_identifier" {
  description = "Identifier of the world database instance."
  value       = module.world_data_plane.db_instance_identifier
}

output "world_db_address" {
  description = "Endpoint address of the world database."
  value       = module.world_data_plane.db_address
}

output "world_db_secret_name" {
  description = "Secrets Manager secret name for the world database."
  value       = module.world_data_plane.secret_name
}

output "world_db_secret_arn" {
  description = "Secrets Manager secret ARN for the world database."
  value       = module.world_data_plane.secret_arn
}
