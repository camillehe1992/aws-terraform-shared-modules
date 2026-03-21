output "compute_environment_arn" {
  description = "ARN of the Batch compute environment"
  value       = aws_batch_compute_environment.this.arn
}

output "ecs_cluster_arn" {
  description = "ARN of the ECS cluster associated with the Batch compute environment"
  value       = aws_batch_compute_environment.this.ecs_cluster_arn
}
