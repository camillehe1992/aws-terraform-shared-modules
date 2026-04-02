# # Example usage of SQS Queue module

# FIFO SQS Queue
module "fifo_queue" {
  source = "../../shared-modules/sqs_queue"

  queue_name = "example-fifo-queue.fifo"
  tags       = local.common_tags

  # Queue type
  queue_type = "FIFO"

  # Queue configuration
  delay_seconds              = 0
  max_message_size           = 262144 # 256 KB
  message_retention_seconds  = 345600 # 4 days
  receive_wait_time_seconds  = 10     # Long polling
  visibility_timeout_seconds = 30     # 30 seconds

  # FIFO specific configuration
  content_based_deduplication = true

  # Dead Letter Queue configuration
  dead_letter_queue_enabled     = true
  max_receive_count             = 3
  dlq_message_retention_seconds = 1209600 # 14 days

  # Encryption
  encryption_enabled = true
  kms_master_key_id  = "alias/aws/sqs"

  # Policy (optional)
  queue_policy_enabled = false
}

# Outputs
output "fifo_queue_url" {
  description = "URL of the FIFO SQS queue"
  value       = module.fifo_queue.queue_url
}

output "fifo_queue_arn" {
  description = "ARN of the FIFO SQS queue"
  value       = module.fifo_queue.queue_arn
}

output "fifo_dlq_url" {
  description = "URL of the FIFO queue's dead letter queue"
  value       = module.fifo_queue.dead_letter_queue_url
}
