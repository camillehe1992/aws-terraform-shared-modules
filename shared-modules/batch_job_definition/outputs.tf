output "job_definition_arn" {
  value       = aws_batch_job_definition.this.arn
  description = "ARN of the job definition"
}

output "job_definition_name" {
  value       = aws_batch_job_definition.this.name
  description = "Name of the job definition (latest:rev)"
}
