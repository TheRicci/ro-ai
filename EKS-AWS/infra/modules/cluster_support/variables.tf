variable "cluster_name" {
  description = "Name of the EKS cluster that will receive the support add-ons."
  type        = string
}

variable "coredns_version" {
  description = "Optional pinned version for the CoreDNS add-on."
  type        = string
  default     = null
}

variable "kube_proxy_version" {
  description = "Optional pinned version for the kube-proxy add-on."
  type        = string
  default     = null
}

variable "vpc_cni_version" {
  description = "Optional pinned version for the VPC CNI add-on."
  type        = string
  default     = null
}

variable "pod_identity_agent_version" {
  description = "Optional pinned version for the EKS Pod Identity Agent add-on."
  type        = string
  default     = null
}

variable "resolve_conflicts_on_create" {
  description = "Conflict handling mode when an add-on is first created."
  type        = string
  default     = "OVERWRITE"
}

variable "resolve_conflicts_on_update" {
  description = "Conflict handling mode when an add-on is updated."
  type        = string
  default     = "OVERWRITE"
}

variable "tags" {
  description = "Common tags applied to all managed add-ons."
  type        = map(string)
  default     = {}
}
