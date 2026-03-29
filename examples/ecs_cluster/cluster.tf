# Create ECS Cluster with infrastructure - Fargate only
module "fargate_only_cluster" {
  source = "../../shared-modules/ecs_cluster"

  name               = local.fargate_only_cluster_name
  capacity_providers = ["FARGATE", "FARGATE_SPOT"]

  default_capacity_provider_strategy = [
    { capacity_provider = "FARGATE_SPOT", weight = 2, base = 0 },
    { capacity_provider = "FARGATE", weight = 1, base = 0 }
  ]

  tags = local.tags
}

output "fargate_only_cluster_id" {
  value = module.fargate_only_cluster.cluster_id
}
