locals {
  public_ecr_image              = "public.ecr.aws/nginx/nginx:alpine"
  service_name                  = "demo-web-service"
  ecs_cloudwatch_log_group_name = "/ecs/${local.service_name}"
}

# ECS Service with Task Definition
module "fargate_ecs_service" {
  source = "../../shared-modules/ecs_service"

  service_name = local.service_name
  cluster_id   = module.fargate_cluster.cluster_arn
  family_name  = "demo-web-task"

  cpu    = "256"
  memory = "512"

  task_role_arn      = module.ecs_task_role.role_arn
  execution_role_arn = module.ecs_task_execution_role.role_arn

  cloudwatch_log_group_name = local.ecs_cloudwatch_log_group_name
  enable_ecs_managed_tags   = true

  containers = [
    {
      name  = "web"
      image = local.public_ecr_image
      port_mappings = [
        {
          container_port = 80
          protocol       = "tcp"
        }
      ]
      log_configuration = {
        log_driver = "awslogs"
        options = {
          "awslogs-group"         = local.ecs_cloudwatch_log_group_name
          "awslogs-region"        = data.aws_region.current.id
          "awslogs-stream-prefix" = "web"
        }
      }
    }
  ]

  subnets         = data.aws_subnets.private.ids
  security_groups = [module.ecs_security_group.security_group_id]

  tags = local.tags
}

# Outputs
output "service_name" {
  description = "Name of the ECS service"
  value       = module.fargate_ecs_service.service_name
}

output "service_arn" {
  description = "ARN of the ECS service"
  value       = module.fargate_ecs_service.service_arn
}

output "task_definition_arn" {
  description = "ARN of the task definition"
  value       = module.fargate_ecs_service.task_definition_arn
}

output "task_definition_family" {
  description = "Family of the task definition"
  value       = module.fargate_ecs_service.task_definition_family
}

output "container_names" {
  description = "Names of the containers"
  value       = module.fargate_ecs_service.container_names
}
