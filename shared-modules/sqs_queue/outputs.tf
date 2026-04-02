# Queue Information
output "queue_url" {
  description = "The URL of the SQS queue"
  value       = aws_sqs_queue.this.url
}

output "queue_arn" {
  description = "The ARN of the SQS queue"
  value       = aws_sqs_queue.this.arn
}

output "queue_name" {
  description = "The name of the SQS queue"
  value       = aws_sqs_queue.this.name
}

output "queue_id" {
  description = "The ID of the SQS queue"
  value       = aws_sqs_queue.this.id
}

# Dead Letter Queue Information
output "dead_letter_queue_enabled" {
  description = "Whether dead letter queue is enabled"
  value       = var.dead_letter_queue_enabled
}

output "dead_letter_queue_url" {
  description = "The URL of the dead letter queue"
  value       = var.dead_letter_queue_enabled ? aws_sqs_queue.dead_letter_queue[0].url : null
}

output "dead_letter_queue_arn" {
  description = "The ARN of the dead letter queue"
  value       = var.dead_letter_queue_enabled ? aws_sqs_queue.dead_letter_queue[0].arn : null
}

output "dead_letter_queue_name" {
  description = "The name of the dead letter queue"
  value       = var.dead_letter_queue_enabled ? aws_sqs_queue.dead_letter_queue[0].name : null
}

# Queue Configuration
output "queue_type" {
  description = "The type of the queue (STANDARD or FIFO)"
  value       = var.queue_type
}

output "fifo_queue" {
  description = "Whether the queue is a FIFO queue"
  value       = var.queue_type == "FIFO"
}

output "encryption_enabled" {
  description = "Whether encryption is enabled"
  value       = var.encryption_enabled
}

output "kms_master_key_id" {
  description = "The ID of the KMS master key"
  value       = var.encryption_enabled ? var.kms_master_key_id : null
}
