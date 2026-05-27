variable "project_name" {
  description = "Project name used for tagging."
  type        = string
  default     = "ro-ai"
}

variable "environment" {
  description = "Environment name used for tagging."
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "AWS region for the development environment."
  type        = string
  default     = "us-east-1"
}

variable "network_name" {
  description = "Base name for the network foundation resources."
  type        = string
  default     = "ro-ai-dev"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Availability zones used by the network foundation."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets."
  type        = list(string)
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets."
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable "cluster_name" {
  description = "Name of the EKS cluster."
  type        = string
  default     = "ro-ai-dev"
}

variable "kubernetes_version" {
  description = "Kubernetes version for the EKS cluster."
  type        = string
  default     = "1.35"
}

variable "cluster_security_group_ids" {
  description = "Additional security group IDs associated with the EKS control plane."
  type        = list(string)
  default     = []
}

variable "endpoint_private_access" {
  description = "Whether the EKS endpoint is accessible privately."
  type        = bool
  default     = true
}

variable "endpoint_public_access" {
  description = "Whether the EKS endpoint is accessible publicly."
  type        = bool
  default     = true
}

variable "enabled_cluster_log_types" {
  description = "Optional EKS control plane log types."
  type        = list(string)
  default     = []
}

variable "node_group_name" {
  description = "Name of the managed node group."
  type        = string
  default     = "core"
}

variable "node_instance_types" {
  description = "Instance types for the managed node group."
  type        = list(string)
  default     = ["m7i.large"]
}

variable "node_capacity_type" {
  description = "Capacity type for the managed node group."
  type        = string
  default     = "ON_DEMAND"
}

variable "node_desired_size" {
  description = "Desired node count."
  type        = number
  default     = 2
}

variable "node_min_size" {
  description = "Minimum node count."
  type        = number
  default     = 2
}

variable "node_max_size" {
  description = "Maximum node count."
  type        = number
  default     = 3
}

variable "node_disk_size" {
  description = "Disk size for managed nodes in GiB."
  type        = number
  default     = 20
}

variable "node_labels" {
  description = "Labels applied to nodes in the managed node group."
  type        = map(string)
  default = {
    role        = "core"
    environment = "dev"
  }
}

variable "node_max_unavailable" {
  description = "Maximum unavailable nodes during an update."
  type        = number
  default     = 1
}

variable "coredns_addon_version" {
  description = "Optional pinned version for the CoreDNS add-on."
  type        = string
  default     = null
}

variable "kube_proxy_addon_version" {
  description = "Optional pinned version for the kube-proxy add-on."
  type        = string
  default     = null
}

variable "vpc_cni_addon_version" {
  description = "Optional pinned version for the VPC CNI add-on."
  type        = string
  default     = null
}

variable "pod_identity_agent_version" {
  description = "Optional pinned version for the EKS Pod Identity Agent add-on."
  type        = string
  default     = null
}

variable "addon_resolve_conflicts_on_create" {
  description = "Conflict handling mode when Terraform first creates a managed EKS add-on."
  type        = string
  default     = "OVERWRITE"
}

variable "addon_resolve_conflicts_on_update" {
  description = "Conflict handling mode when Terraform updates a managed EKS add-on."
  type        = string
  default     = "OVERWRITE"
}

variable "bot_memory_table_name" {
  description = "DynamoDB table name used for bot memory."
  type        = string
  default     = "ro-ai-dev-bot-memory"
}

variable "bot_memory_partition_key" {
  description = "Partition key name for the bot memory table."
  type        = string
  default     = "bot_id"
}

variable "bot_memory_sort_key" {
  description = "Sort key name for the bot memory table."
  type        = string
  default     = "memory_key"
}

variable "bot_memory_billing_mode" {
  description = "Billing mode for the bot memory table."
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "bot_artifacts_bucket_name" {
  description = "S3 bucket name used for bot artifacts."
  type        = string
}

variable "intelligence_secret_name" {
  description = "Secrets Manager secret name used by intelligence services."
  type        = string
  default     = "ro-ai/dev/intelligence"
}

variable "bot_runtime_secret_name" {
  description = "Secrets Manager secret name used by bot runtime services."
  type        = string
  default     = "ro-ai/dev/bot-runtime"
}

variable "enable_point_in_time_recovery" {
  description = "Whether to enable point-in-time recovery for the bot memory table."
  type        = bool
  default     = true
}

variable "enable_bucket_versioning" {
  description = "Whether to enable versioning for the bot artifacts bucket."
  type        = bool
  default     = false
}

variable "world_db_identifier" {
  description = "Identifier for the world RDS instance."
  type        = string
  default     = "ro-ai-dev-world"
}

variable "world_db_engine" {
  description = "Database engine for the world database."
  type        = string
  default     = "mariadb"
}

variable "world_db_engine_version" {
  description = "Optional engine version for the world database."
  type        = string
  default     = null
}

variable "world_db_instance_class" {
  description = "Instance class for the world database."
  type        = string
  default     = "db.t3.micro"
}

variable "world_db_allocated_storage" {
  description = "Initial allocated storage in GiB for the world database."
  type        = number
  default     = 20
}

variable "world_db_max_allocated_storage" {
  description = "Maximum autoscaled storage in GiB for the world database."
  type        = number
  default     = 100
}

variable "world_db_name" {
  description = "Database name for the world database."
  type        = string
  default     = "ragnarok"
}

variable "world_db_username" {
  description = "Master username for the world database."
  type        = string
  default     = "ragnarok"
}

variable "world_db_port" {
  description = "Port for the world database."
  type        = number
  default     = 3306
}

variable "world_db_secret_name" {
  description = "Secrets Manager secret name for the world database connection payload."
  type        = string
  default     = "ro-ai/dev/world-db"
}

variable "world_db_skip_final_snapshot" {
  description = "Whether to skip the final snapshot when deleting the world database."
  type        = bool
  default     = true
}

variable "world_db_deletion_protection" {
  description = "Whether deletion protection is enabled for the world database."
  type        = bool
  default     = false
}

variable "world_db_backup_retention_period" {
  description = "Backup retention period in days for the world database."
  type        = number
  default     = 7
}
