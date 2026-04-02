# General deployment variables
variable "tags" {
  description = "The key value pairs we want to apply as tags to the resources contained in this module"
  type        = map(string)
  default     = {}
}
# Event rule variables
variable "rule_name" {
  description = "The name of EventBridge rule to trigger a submit of job"
  type        = string
}

variable "rule_description" {
  description = "The description of the rule"
  type        = string
  default     = ""
}

variable "role_arn" {
  type        = string
  description = "The ARN of the IAM role to be used for this target when the rule is triggered"
  default     = null
}

variable "schedule_expression" {
  description = "The schedule expression for CW Event rule in UTC. Trigger at 1:00 AM at UTC"
  type        = string
  default     = null
}

variable "event_pattern" {
  description = "The event pattern that rule should capture. At least one of schedule_expression or event_pattern is required."
  type        = string
  default     = null
}

variable "event_bus_name" {
  description = "The name of the event bus to associate with this rule. Default to default"
  type        = string
  default     = "default"
}

variable "is_enabled" {
  description = "If enable the rule. Default to true"
  type        = bool
  default     = true
}

# Event target variables
variable "target_id" {
  description = "The ID of the target, if missing, will generate a random, unique id"
  type        = string
  default     = null
}
variable "target_arn" {
  description = "The ARN of the target"
  type        = string
}

variable "rule_input" {
  description = "The input of the rule"
  type        = string
  default     = "{}"
}

variable "batch_target_specs" {
  description = "The specifications for the Batch job to submit"
  type = object({
    job_definition = string
    job_name       = string
    array_size     = number
    job_attempts   = number
  })
  default = null
}

variable "sqs_target_specs" {
  description = "The specifications for the SQS queue to send the message"
  type = object({
    message_group_id = string
  })
  default = null
}

variable "input_transformer_specs" {
  description = "The input transformer specifications for the rule"
  type = object({
    input_paths    = optional(map(string))
    input_template = string
  })
  default = null
}
