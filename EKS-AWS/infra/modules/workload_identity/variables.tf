variable "cluster_name" {
  description = "Name of the EKS cluster used for pod identity associations."
  type        = string
}

variable "cluster_arn" {
  description = "EKS cluster ARN used to restrict IAM role trust policies."
  type        = string
}

variable "world_namespace" {
  description = "Namespace for world services."
  type        = string
  default     = "ro-ai-world"
}

variable "intelligence_namespace" {
  description = "Namespace for intelligence services."
  type        = string
  default     = "ro-ai-intelligence"
}

variable "bots_namespace" {
  description = "Namespace for bot runtime services."
  type        = string
  default     = "ro-ai-bots"
}

variable "world_service_account_name" {
  description = "Service account name for the world service."
  type        = string
  default     = "ro-ai-world-service"
}

variable "planner_service_account_name" {
  description = "Service account name for the planner service."
  type        = string
  default     = "ro-ai-planner"
}

variable "model_gateway_service_account_name" {
  description = "Service account name for the model gateway service."
  type        = string
  default     = "ro-ai-model-gateway"
}

variable "admin_api_service_account_name" {
  description = "Service account name for the admin API service."
  type        = string
  default     = "ro-ai-admin-api"
}

variable "bot_runtime_service_account_name" {
  description = "Service account name for the bot runtime service."
  type        = string
  default     = "ro-ai-bot-runtime"
}

variable "world_role_name" {
  description = "IAM role name for the world service workload identity."
  type        = string
  default     = "ro-ai-dev-world-service"
}

variable "planner_role_name" {
  description = "IAM role name for the planner workload identity."
  type        = string
  default     = "ro-ai-dev-planner"
}

variable "model_gateway_role_name" {
  description = "IAM role name for the model gateway workload identity."
  type        = string
  default     = "ro-ai-dev-model-gateway"
}

variable "admin_api_role_name" {
  description = "IAM role name for the admin API workload identity."
  type        = string
  default     = "ro-ai-dev-admin-api"
}

variable "bot_runtime_role_name" {
  description = "IAM role name for the bot runtime workload identity."
  type        = string
  default     = "ro-ai-dev-bot-runtime"
}

variable "world_db_secret_name" {
  description = "Secrets Manager secret name for the world database connection."
  type        = string
}

variable "intelligence_secret_name" {
  description = "Secrets Manager secret name for intelligence services."
  type        = string
}

variable "bot_runtime_secret_name" {
  description = "Secrets Manager secret name for bot runtime services."
  type        = string
}

variable "bot_memory_table_name" {
  description = "DynamoDB table name used for bot memory."
  type        = string
}

variable "bot_artifacts_bucket_name" {
  description = "S3 bucket name used for bot artifacts."
  type        = string
}

variable "inline_policy_name" {
  description = "Name used for the inline IAM policy attached to each workload role."
  type        = string
  default     = "ro-ai-access"
}

variable "tags" {
  description = "Common tags applied to all resources."
  type        = map(string)
  default     = {}
}
