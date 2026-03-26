# ECS Service Outputs
output "service_name" {
  description = "Name of the ECS service"
  value       = aws_ecs_service.this.name
}

output "service_id" {
  description = "ID of the ECS service"
  value       = aws_ecs_service.this.id
}

output "service_arn" {
  description = "ARN of the ECS service"
  value       = aws_ecs_service.this.arn
}

# Task Definition Outputs
output "task_definition_arn" {
  description = "ARN of the task definition"
  value       = aws_ecs_task_definition.this.arn
}

output "task_definition_family" {
  description = "Family of the task definition"
  value       = aws_ecs_task_definition.this.family
}

output "task_definition_revision" {
  description = "Revision of the task definition"
  value       = aws_ecs_task_definition.this.revision
}

# Container and Image Information
output "container_names" {
  description = "Names of the containers in the task definition"
  value       = [for container in var.containers : container.name]
}

output "container_images" {
  description = "Images used by the containers"
  value       = { for container in var.containers : container.name => container.image }
}

# Resource Information
output "cpu" {
  description = "CPU units for the task"
  value       = var.cpu
}

output "memory" {
  description = "Memory for the task"
  value       = var.memory
}

# Network Configuration
output "network_mode" {
  description = "Network mode of the task definition"
  value       = aws_ecs_task_definition.this.network_mode
}

# Security and IAM
output "execution_role_arn" {
  description = "ARN of the task execution role"
  value       = var.execution_role_arn
}

output "task_role_arn" {
  description = "ARN of the task role"
  value       = var.task_role_arn
}
