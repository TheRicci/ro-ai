output "role_arns" {
  description = "Map of workload role ARNs keyed by workload identifier."
  value = {
    for workload_name, role in aws_iam_role.workload :
    workload_name => role.arn
  }
}

output "role_names" {
  description = "Map of workload role names keyed by workload identifier."
  value = {
    for workload_name, role in aws_iam_role.workload :
    workload_name => role.name
  }
}

output "association_ids" {
  description = "Map of pod identity association IDs keyed by workload identifier."
  value = {
    for workload_name, association in aws_eks_pod_identity_association.workload :
    workload_name => association.association_id
  }
}
