module "fargate_cluster" {
  source = "../../shared-modules/ecs_cluster"

  name               = "demo-ecs-fargate-cluster"
  capacity_providers = ["FARGATE", "FARGATE_SPOT"]

  default_capacity_provider_strategy = [
    { capacity_provider = "FARGATE_SPOT", weight = 2, base = 0 },
    { capacity_provider = "FARGATE", weight = 1, base = 0 }
  ]

  container_insights = true

  tags = {
    Environment = "dev"
  }
}

output "cluster_arn" {
  value = module.fargate_cluster.cluster_arn
}
