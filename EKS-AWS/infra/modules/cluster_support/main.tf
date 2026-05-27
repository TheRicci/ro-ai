locals {
  addon_definitions = {
    coredns = {
      version = var.coredns_version
    }
    "eks-pod-identity-agent" = {
      version = var.pod_identity_agent_version
    }
    "kube-proxy" = {
      version = var.kube_proxy_version
    }
    "vpc-cni" = {
      version = var.vpc_cni_version
    }
  }
}

resource "aws_eks_addon" "this" {
  for_each = local.addon_definitions

  cluster_name                = var.cluster_name
  addon_name                  = each.key
  addon_version               = each.value.version
  resolve_conflicts_on_create = var.resolve_conflicts_on_create
  resolve_conflicts_on_update = var.resolve_conflicts_on_update

  tags = merge(
    var.tags,
    {
      Name = "${var.cluster_name}-${each.key}"
    }
  )
}
