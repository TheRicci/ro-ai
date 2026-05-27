module "network_foundation" {
  source = "../../modules/network_foundation"

  name                 = var.network_name
  cluster_name         = var.cluster_name
  vpc_cidr             = var.vpc_cidr
  availability_zones   = var.availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  world_db_port        = var.world_db_port
  tags                 = local.common_tags
}

module "eks_platform" {
  source = "../../modules/eks_platform"

  cluster_name               = var.cluster_name
  kubernetes_version         = var.kubernetes_version
  cluster_subnet_ids         = module.network_foundation.private_subnet_ids
  cluster_security_group_ids = var.cluster_security_group_ids
  endpoint_private_access    = var.endpoint_private_access
  endpoint_public_access     = var.endpoint_public_access
  enabled_cluster_log_types  = var.enabled_cluster_log_types
  node_group_name            = var.node_group_name
  node_subnet_ids            = module.network_foundation.private_subnet_ids
  node_instance_types        = var.node_instance_types
  node_capacity_type         = var.node_capacity_type
  node_desired_size          = var.node_desired_size
  node_min_size              = var.node_min_size
  node_max_size              = var.node_max_size
  node_disk_size             = var.node_disk_size
  node_labels                = var.node_labels
  node_max_unavailable       = var.node_max_unavailable
  tags                       = local.common_tags
}

module "cluster_support" {
  source = "../../modules/cluster_support"

  cluster_name                = var.cluster_name
  coredns_version             = var.coredns_addon_version
  kube_proxy_version          = var.kube_proxy_addon_version
  vpc_cni_version             = var.vpc_cni_addon_version
  pod_identity_agent_version  = var.pod_identity_agent_version
  resolve_conflicts_on_create = var.addon_resolve_conflicts_on_create
  resolve_conflicts_on_update = var.addon_resolve_conflicts_on_update
  tags                        = local.common_tags

  depends_on = [module.eks_platform]
}

module "workload_identity" {
  source = "../../modules/workload_identity"

  cluster_name              = var.cluster_name
  cluster_arn               = module.eks_platform.cluster_arn
  world_db_secret_name      = var.world_db_secret_name
  intelligence_secret_name  = var.intelligence_secret_name
  bot_runtime_secret_name   = var.bot_runtime_secret_name
  bot_memory_table_name     = var.bot_memory_table_name
  bot_artifacts_bucket_name = var.bot_artifacts_bucket_name
  tags                      = local.common_tags
}

module "bot_data_plane" {
  source = "../../modules/bot_data_plane"

  bot_memory_table_name         = var.bot_memory_table_name
  bot_memory_partition_key      = var.bot_memory_partition_key
  bot_memory_sort_key           = var.bot_memory_sort_key
  bot_memory_billing_mode       = var.bot_memory_billing_mode
  bot_artifacts_bucket_name     = var.bot_artifacts_bucket_name
  enable_point_in_time_recovery = var.enable_point_in_time_recovery
  enable_bucket_versioning      = var.enable_bucket_versioning
  tags                          = local.common_tags
}

module "world_data_plane" {
  source = "../../modules/world_data_plane"

  identifier              = var.world_db_identifier
  engine                  = var.world_db_engine
  engine_version          = var.world_db_engine_version
  instance_class          = var.world_db_instance_class
  allocated_storage       = var.world_db_allocated_storage
  max_allocated_storage   = var.world_db_max_allocated_storage
  db_name                 = var.world_db_name
  username                = var.world_db_username
  port                    = var.world_db_port
  subnet_ids              = module.network_foundation.private_subnet_ids
  vpc_security_group_ids  = [module.network_foundation.world_db_security_group_id]
  secret_name             = var.world_db_secret_name
  skip_final_snapshot     = var.world_db_skip_final_snapshot
  deletion_protection     = var.world_db_deletion_protection
  backup_retention_period = var.world_db_backup_retention_period
  tags                    = local.common_tags
}
