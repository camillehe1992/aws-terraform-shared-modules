# Example usage of SQS Queue module
# This example creates both a standard queue and a FIFO queue with various configurations

locals {
  common_tags = {
    Project   = "sqs-queue-example"
    ManagedBy = "terraform"
  }
}

# Standard SQS Queue
module "standard_queue" {
  source = "../../shared-modules/sqs_queue"

  queue_name = "example-standard-queue"
  tags       = local.common_tags

  # Queue configuration
  delay_seconds              = 0
  max_message_size           = 262144 # 256 KB
  message_retention_seconds  = 345600 # 4 days
  receive_wait_time_seconds  = 10     # Long polling
  visibility_timeout_seconds = 30     # 30 seconds

  # Dead Letter Queue configuration
  dead_letter_queue_enabled     = true
  max_receive_count             = 3
  dlq_message_retention_seconds = 1209600 # 14 days

  # Encryption
  encryption_enabled = true
  kms_master_key_id  = "alias/aws/sqs"

  # Policy (optional)
  queue_policy_enabled = true
}

# Outputs
output "standard_queue_url" {
  description = "URL of the standard SQS queue"
  value       = module.standard_queue.queue_url
}

output "standard_queue_arn" {
  description = "ARN of the standard SQS queue"
  value       = module.standard_queue.queue_arn
}

output "standard_dlq_url" {
  description = "URL of the standard queue's dead letter queue"
  value       = module.standard_queue.dead_letter_queue_url
}
