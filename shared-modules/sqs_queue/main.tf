locals {
  # Common tags for all resources
  common_tags = merge(
    var.tags,
    {
      ManagedBy = "terraform"
      Module    = "sqs_queue"
    }
  )
}

# Create SQS Queue
resource "aws_sqs_queue" "this" {
  name                       = var.queue_name
  delay_seconds              = var.delay_seconds
  max_message_size           = var.max_message_size
  message_retention_seconds  = var.message_retention_seconds
  receive_wait_time_seconds  = var.receive_wait_time_seconds
  visibility_timeout_seconds = var.visibility_timeout_seconds

  # Dead Letter Queue configuration
  redrive_policy = var.dead_letter_queue_enabled ? jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dead_letter_queue[0].arn
    maxReceiveCount     = var.max_receive_count
  }) : null

  # Encryption
  kms_master_key_id                 = var.encryption_enabled ? var.kms_master_key_id : null
  kms_data_key_reuse_period_seconds = var.encryption_enabled ? var.kms_data_key_reuse_period_seconds : null

  # FIFO Queue configuration
  fifo_queue                  = var.queue_type == "FIFO"
  content_based_deduplication = var.queue_type == "FIFO" ? var.content_based_deduplication : null

  tags = local.common_tags
}

# Create Dead Letter Queue if enabled
resource "aws_sqs_queue" "dead_letter_queue" {
  count = var.dead_letter_queue_enabled ? 1 : 0

  name                      = var.queue_type == "FIFO" ? "${replace(var.queue_name, ".fifo", "")}-dlq.fifo" : "${var.queue_name}-dlq"
  delay_seconds             = var.delay_seconds
  max_message_size          = var.max_message_size
  message_retention_seconds = var.dlq_message_retention_seconds
  receive_wait_time_seconds = var.receive_wait_time_seconds

  # FIFO Queue configuration for DLQ
  fifo_queue                  = var.queue_type == "FIFO"
  content_based_deduplication = var.queue_type == "FIFO" ? var.content_based_deduplication : null

  tags = merge(local.common_tags, {
    QueueType = "DeadLetter"
  })
}

# Create SQS Queue Policy
resource "aws_sqs_queue_policy" "this" {
  count = var.queue_policy_enabled ? 1 : 0

  queue_url = aws_sqs_queue.this.id
  policy    = var.queue_policy != "" ? var.queue_policy : data.aws_iam_policy_document.default_queue_policy.json
}
