variable "identifier" {
  description = "Identifier for the world RDS instance."
  type        = string
}

variable "engine" {
  description = "Database engine for the world database."
  type        = string
  default     = "mariadb"
}

variable "engine_version" {
  description = "Optional engine version for the world database."
  type        = string
  default     = null
}

variable "instance_class" {
  description = "Instance class for the world RDS instance."
  type        = string
}

variable "allocated_storage" {
  description = "Initial allocated storage in GiB."
  type        = number
  default     = 20
}

variable "max_allocated_storage" {
  description = "Maximum autoscaled storage in GiB."
  type        = number
  default     = 100
}

variable "db_name" {
  description = "Database name for the world database."
  type        = string
}

variable "username" {
  description = "Master username for the world database."
  type        = string
}

variable "port" {
  description = "Port for the world database."
  type        = number
  default     = 3306
}

variable "subnet_ids" {
  description = "Private subnet IDs for the DB subnet group."
  type        = list(string)
}

variable "vpc_security_group_ids" {
  description = "Security groups allowed to reach the database."
  type        = list(string)
}

variable "secret_name" {
  description = "Secrets Manager secret name to hold the world DB connection payload."
  type        = string
}

variable "db_password_length" {
  description = "Length of the generated database password."
  type        = number
  default     = 24
}

variable "skip_final_snapshot" {
  description = "Whether to skip the final snapshot on delete."
  type        = bool
  default     = true
}

variable "deletion_protection" {
  description = "Whether deletion protection is enabled."
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  description = "Backup retention in days."
  type        = number
  default     = 7
}

variable "tags" {
  description = "Common tags applied to all resources."
  type        = map(string)
  default     = {}
}
