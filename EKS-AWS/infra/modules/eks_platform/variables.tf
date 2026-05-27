variable "cluster_name" {
  description = "Name of the EKS cluster."
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version for the EKS cluster."
  type        = string
}

variable "cluster_subnet_ids" {
  description = "Subnet IDs used by the EKS control plane."
  type        = list(string)
}

variable "cluster_security_group_ids" {
  description = "Optional security group IDs associated with the EKS control plane."
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

variable "node_subnet_ids" {
  description = "Subnet IDs for the managed node group. Defaults to cluster_subnet_ids when empty."
  type        = list(string)
  default     = []
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
  default     = {}
}

variable "node_max_unavailable" {
  description = "Maximum unavailable nodes during an update."
  type        = number
  default     = 1
}

variable "tags" {
  description = "Common tags applied to all resources."
  type        = map(string)
  default     = {}
}
