
output "job_queue_arn" {
  value       = aws_batch_job_queue.this.arn
  description = "ARN of the job queue"
}

output "job_queue_name" {
  value       = aws_batch_job_queue.this.name
  description = "Name of the job queue"
}
