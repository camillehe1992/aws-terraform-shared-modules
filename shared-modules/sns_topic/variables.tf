variable "tags" {
  description = "The key value pairs we want to apply as tags to the resources contained in this module"
  type        = map(string)
  default     = {}
}

variable "topic_name" {
  description = "The name of the topic"
  type        = string
}

variable "notification_email_addresses" {
  description = "The list of email address that subscribes the SNS topic to receive notification"
  type        = list(string)
  default     = []
}

variable "sns_topic_policy" {
  type        = string
  description = "The SNS topic policy for allowing particular actions on topic"
  default     = null
}
