output "enabled_addons" {
  description = "Names of the EKS add-ons managed by this module."
  value       = sort(keys(aws_eks_addon.this))
}

output "addon_arns" {
  description = "ARNs of the managed EKS add-ons."
  value       = { for name, addon in aws_eks_addon.this : name => addon.arn }
}

output "addon_versions" {
  description = "Resolved versions of the managed EKS add-ons."
  value       = { for name, addon in aws_eks_addon.this : name => addon.addon_version }
}

output "addon_statuses" {
  description = "Status values reported for the managed EKS add-ons."
  value       = { for name, addon in aws_eks_addon.this : name => addon.status }
}
