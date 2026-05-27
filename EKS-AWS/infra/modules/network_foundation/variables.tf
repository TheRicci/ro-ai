variable "name" {
  description = "Base name for the network foundation resources."
  type        = string
}

variable "cluster_name" {
  description = "Optional cluster name used to tag Kubernetes-aware subnets."
  type        = string
  default     = null
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "availability_zones" {
  description = "Availability zones used by the public and private subnets."
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets."
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets."
  type        = list(string)
}

variable "world_db_port" {
  description = "Port opened on the world database security group."
  type        = number
  default     = 3306
}

variable "tags" {
  description = "Common tags applied to all resources."
  type        = map(string)
  default     = {}
}
