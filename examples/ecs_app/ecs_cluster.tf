# Here are some reosurce dependencies for ECS service task setup:
# - ECS Cluster

locals {
  ecs_cluster_name = "demo-ecs-fargate-cluster"
}
# Create ECS Cluster
module "fargate_cluster" {
  source = "../../shared-modules/ecs_cluster"

  name               = local.ecs_cluster_name
  capacity_providers = ["FARGATE", "FARGATE_SPOT"]

  default_capacity_provider_strategy = [
    { capacity_provider = "FARGATE_SPOT", weight = 2, base = 0 },
    { capacity_provider = "FARGATE", weight = 1, base = 0 }
  ]

  container_insights = true

  tags = local.tags
}

output "ecs_cluster_id" {
  value = module.fargate_cluster.cluster_id
}
