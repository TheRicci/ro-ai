variable "bot_memory_table_name" {
  description = "Name of the DynamoDB table used for bot memory."
  type        = string
}

variable "bot_memory_partition_key" {
  description = "Partition key for the bot memory DynamoDB table."
  type        = string
}

variable "bot_memory_sort_key" {
  description = "Sort key for the bot memory DynamoDB table."
  type        = string
}

variable "bot_memory_billing_mode" {
  description = "Billing mode for the bot memory DynamoDB table."
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "bot_artifacts_bucket_name" {
  description = "Name of the S3 bucket used for bot artifacts."
  type        = string
}

variable "enable_point_in_time_recovery" {
  description = "Whether to enable point-in-time recovery for the bot memory table."
  type        = bool
  default     = true
}

variable "enable_bucket_versioning" {
  description = "Whether to enable S3 bucket versioning for bot artifacts."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Common tags applied to all resources."
  type        = map(string)
  default     = {}
}
