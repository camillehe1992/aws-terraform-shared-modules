# ECS Service with Task Definition
module "nginx_service" {
  source = "../../shared-modules/ecs_service"

  cluster_id         = module.fargate_only_cluster.cluster_id
  service_name       = local.service_name
  family_name        = local.family_name
  cpu                = local.cpu
  memory             = local.memory
  containers         = local.containers
  task_role_arn      = module.ecs_task_role.role_arn
  execution_role_arn = module.ecs_task_execution_role.role_arn
  subnets            = local.network.private_subnet_ids
  security_groups    = local.network.security_group_ids
  load_balancers = [
    for tg in local.target_groups : {
      target_group_arn = module.nginx_alb.target_group_arns[tg.name]
      container_name   = one([for c in local.containers : c.name if c.port_mappings[0].container_port == tg.port])
      container_port   = tg.port
    }
  ]

  tags = local.tags
}

# Outputs
output "service_arn" {
  description = "ARN of the ECS service"
  value       = module.nginx_service.service_arn
}

output "task_definition_arn" {
  description = "ARN of the task definition"
  value       = module.nginx_service.task_definition_arn
}
