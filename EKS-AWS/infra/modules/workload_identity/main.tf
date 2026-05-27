data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

locals {
  bot_memory_table_arn     = "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/${var.bot_memory_table_name}"
  bot_artifacts_bucket_arn = "arn:aws:s3:::${var.bot_artifacts_bucket_name}"

  workloads = {
    world_service = {
      namespace         = var.world_namespace
      service_account   = var.world_service_account_name
      role_name         = var.world_role_name
      secret_names      = [var.world_db_secret_name]
      use_bot_memory    = false
      use_bot_artifacts = false
    }
    planner = {
      namespace         = var.intelligence_namespace
      service_account   = var.planner_service_account_name
      role_name         = var.planner_role_name
      secret_names      = [var.intelligence_secret_name]
      use_bot_memory    = true
      use_bot_artifacts = true
    }
    model_gateway = {
      namespace         = var.intelligence_namespace
      service_account   = var.model_gateway_service_account_name
      role_name         = var.model_gateway_role_name
      secret_names      = [var.intelligence_secret_name]
      use_bot_memory    = false
      use_bot_artifacts = false
    }
    admin_api = {
      namespace         = var.intelligence_namespace
      service_account   = var.admin_api_service_account_name
      role_name         = var.admin_api_role_name
      secret_names      = [var.intelligence_secret_name]
      use_bot_memory    = true
      use_bot_artifacts = true
    }
    bot_runtime = {
      namespace         = var.bots_namespace
      service_account   = var.bot_runtime_service_account_name
      role_name         = var.bot_runtime_role_name
      secret_names      = [var.bot_runtime_secret_name]
      use_bot_memory    = false
      use_bot_artifacts = false
    }
  }
}

data "aws_iam_policy_document" "assume_role" {
  for_each = local.workloads

  statement {
    sid    = "AllowEksAuthToAssumeRoleForPodIdentity"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:RequestTag/kubernetes-namespace"
      values   = [each.value.namespace]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:RequestTag/kubernetes-service-account"
      values   = [each.value.service_account]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = [var.cluster_arn]
    }
  }
}

resource "aws_iam_role" "workload" {
  for_each = local.workloads

  name               = each.value.role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role[each.key].json

  tags = merge(
    var.tags,
    {
      Name = each.value.role_name
    }
  )
}

data "aws_iam_policy_document" "access" {
  for_each = local.workloads

  dynamic "statement" {
    for_each = length(each.value.secret_names) > 0 ? [each.value.secret_names] : []

    content {
      sid    = "ReadScopedSecrets"
      effect = "Allow"
      actions = [
        "secretsmanager:DescribeSecret",
        "secretsmanager:GetSecretValue"
      ]
      resources = [
        for secret_name in statement.value :
        "arn:aws:secretsmanager:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:secret:${secret_name}*"
      ]
    }
  }

  dynamic "statement" {
    for_each = each.value.use_bot_memory ? [1] : []

    content {
      sid    = "UseBotMemoryTable"
      effect = "Allow"
      actions = [
        "dynamodb:BatchGetItem",
        "dynamodb:BatchWriteItem",
        "dynamodb:DeleteItem",
        "dynamodb:DescribeTable",
        "dynamodb:GetItem",
        "dynamodb:PutItem",
        "dynamodb:Query",
        "dynamodb:Scan",
        "dynamodb:UpdateItem"
      ]
      resources = [
        local.bot_memory_table_arn,
        "${local.bot_memory_table_arn}/index/*"
      ]
    }
  }

  dynamic "statement" {
    for_each = each.value.use_bot_artifacts ? [1] : []

    content {
      sid    = "UseBotArtifactsBucket"
      effect = "Allow"
      actions = [
        "s3:DeleteObject",
        "s3:GetObject",
        "s3:ListBucket",
        "s3:PutObject"
      ]
      resources = [
        local.bot_artifacts_bucket_arn,
        "${local.bot_artifacts_bucket_arn}/*"
      ]
    }
  }
}

resource "aws_iam_role_policy" "access" {
  for_each = local.workloads

  name   = var.inline_policy_name
  role   = aws_iam_role.workload[each.key].id
  policy = data.aws_iam_policy_document.access[each.key].json
}

resource "aws_eks_pod_identity_association" "workload" {
  for_each = local.workloads

  cluster_name    = var.cluster_name
  namespace       = each.value.namespace
  service_account = each.value.service_account
  role_arn        = aws_iam_role.workload[each.key].arn
}
