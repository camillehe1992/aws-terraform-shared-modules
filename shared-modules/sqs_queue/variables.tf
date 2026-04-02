# General Configuration
variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "queue_name" {
  description = "The name of the SQS queue"
  type        = string
}

# Queue Type Configuration
variable "queue_type" {
  description = "Type of queue (STANDARD or FIFO)"
  type        = string
  default     = "STANDARD"

  validation {
    condition     = contains(["STANDARD", "FIFO"], var.queue_type)
    error_message = "Queue type must be either STANDARD or FIFO."
  }
}

# Message Configuration
variable "delay_seconds" {
  description = "The time in seconds that the delivery of all messages in the queue is delayed. An integer from 0 to 900 (15 minutes)"
  type        = number
  default     = 0

  validation {
    condition     = var.delay_seconds >= 0 && var.delay_seconds <= 900
    error_message = "Delay seconds must be between 0 and 900."
  }
}

variable "max_message_size" {
  description = "The limit of how many bytes that a message can contain before Amazon SQS rejects it. An integer from 1024 bytes (1 KiB) to 262144 bytes (256 KiB)"
  type        = number
  default     = 262144

  validation {
    condition     = var.max_message_size >= 1024 && var.max_message_size <= 262144
    error_message = "Max message size must be between 1024 and 262144 bytes."
  }
}

variable "message_retention_seconds" {
  description = "The number of seconds that Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days)"
  type        = number
  default     = 345600

  validation {
    condition     = var.message_retention_seconds >= 60 && var.message_retention_seconds <= 1209600
    error_message = "Message retention seconds must be between 60 and 1209600."
  }
}

variable "receive_wait_time_seconds" {
  description = "The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning. An integer from 0 to 20 (seconds)"
  type        = number
  default     = 0

  validation {
    condition     = var.receive_wait_time_seconds >= 0 && var.receive_wait_time_seconds <= 20
    error_message = "Receive wait time seconds must be between 0 and 20."
  }
}

variable "visibility_timeout_seconds" {
  description = "The visibility timeout for the queue. An integer from 0 to 43200 (12 hours)"
  type        = number
  default     = 30

  validation {
    condition     = var.visibility_timeout_seconds >= 0 && var.visibility_timeout_seconds <= 43200
    error_message = "Visibility timeout seconds must be between 0 and 43200."
  }
}

# FIFO Queue Configuration
variable "content_based_deduplication" {
  description = "Enables content-based deduplication for FIFO queues"
  type        = bool
  default     = false
}

# Dead Letter Queue Configuration
variable "dead_letter_queue_enabled" {
  description = "Enable dead letter queue"
  type        = bool
  default     = false
}

variable "max_receive_count" {
  description = "The number of times a message is delivered to the source queue before being moved to the dead-letter queue"
  type        = number
  default     = 3

  validation {
    condition     = var.max_receive_count >= 1 && var.max_receive_count <= 1000
    error_message = "Max receive count must be between 1 and 1000."
  }
}

variable "dlq_message_retention_seconds" {
  description = "The number of seconds that Amazon SQS retains a message in the dead letter queue"
  type        = number
  default     = 1209600

  validation {
    condition     = var.dlq_message_retention_seconds >= 60 && var.dlq_message_retention_seconds <= 1209600
    error_message = "DLQ message retention seconds must be between 60 and 1209600."
  }
}

# Encryption Configuration
variable "encryption_enabled" {
  description = "Enable server-side encryption (SSE)"
  type        = bool
  default     = true
}

variable "kms_master_key_id" {
  description = "The ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK"
  type        = string
  default     = "alias/aws/sqs"
}

variable "kms_data_key_reuse_period_seconds" {
  description = "The length of time, in seconds, for which Amazon SQS can reuse a data key"
  type        = number
  default     = 300

  validation {
    condition     = var.kms_data_key_reuse_period_seconds >= 60 && var.kms_data_key_reuse_period_seconds <= 86400
    error_message = "KMS data key reuse period seconds must be between 60 and 86400."
  }
}

# Policy Configuration
variable "queue_policy_enabled" {
  description = "Enable queue policy (uses secure default policy if custom policy not provided)"
  type        = bool
  default     = true
}

variable "queue_policy" {
  description = "Custom JSON policy for the SQS queue. If empty, uses secure default policy with HTTPS-only traffic and least privilege"
  type        = string
  default     = ""
}
