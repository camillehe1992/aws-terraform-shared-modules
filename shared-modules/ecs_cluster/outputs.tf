output "cluster_arn" {
  value       = aws_ecs_cluster.this.arn
  description = "ARN of the ECS cluster"
}

output "cluster_name" {
  value       = aws_ecs_cluster.this.name
  description = "Name of the ECS cluster"
}

output "cluster_id" {
  value       = aws_ecs_cluster.this.id
  description = "ID of the ECS cluster"
}

output "cluster_log_group_name" {
  value       = var.log_configuration.enabled ? aws_cloudwatch_log_group.this[0].name : null
  description = "Name of the ECS cluster log group"
}
