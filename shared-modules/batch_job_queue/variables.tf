variable "name" {
  description = "Name of the job queue"
  type        = string
}

variable "state" {
  description = "State of the job queue (ENABLED or DISABLED)"
  type        = string
  default     = "ENABLED"
}

variable "priority" {
  description = "Priority of the job queue (higher is better)"
  type        = number
  default     = 1
}

variable "compute_environments" {
  description = "Ordered list of compute environment ARNs"
  type = list(object({
    order               = number
    compute_environment = string
  }))
  default = []
}

variable "scheduling_policy_arn" {
  description = "ARN of the scheduling policy"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
