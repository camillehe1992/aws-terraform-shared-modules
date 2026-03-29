# Create ECS Cluster with infrastructure - Fargate and Managed Instances
module "fargate_managed_ec2_cluster" {
  source = "../../shared-modules/ecs_cluster"

  name               = local.fargate_managed_ec2_cluster_name
  capacity_providers = ["FARGATE", "FARGATE_SPOT"]

  default_capacity_provider_strategy = [
    { capacity_provider = "FARGATE_SPOT", weight = 2, base = 0 },
    { capacity_provider = "FARGATE", weight = 1, base = 0 }
  ]

  managed_instances_provider = {
    infrastructure_role_arn = module.ecs_infrastructure_role.role_arn
    instance_launch_template = {
      ec2_instance_profile_arn = module.ecs_instance_role.instance_profile_arn
      monitoring               = "BASIC"
      subnets                  = local.network.private_subnet_ids
      security_groups          = local.network.security_group_ids

      storage_size_gib     = local.managed_instances_provider.storage_size_gib
      min_meory_mib        = local.managed_instances_provider.min_meory_mib
      max_meory_mib        = local.managed_instances_provider.max_meory_mib
      min_vcpu_count       = local.managed_instances_provider.min_vcpu_count
      max_vcpu_count       = local.managed_instances_provider.max_vcpu_count
      instance_generations = local.managed_instances_provider.instance_generations
      cpu_manufacturers    = local.managed_instances_provider.cpu_manufacturers
    }
  }

  tags = local.tags
}

output "fargate_managed_ec2_cluster_id" {
  value = module.fargate_managed_ec2_cluster.cluster_id
}
