variable "name" {
  description = "Name of the job definition"
  type        = string
}

variable "container_image" {
  description = "Docker image to run"
  type        = string
}

variable "container_memory" {
  description = "Memory (MiB) for the container"
  type        = number
  default     = 1024
}

variable "container_vcpu" {
  description = "vCPU count for the container"
  type        = number
  default     = 1
}

variable "job_role_arn" {
  description = "IAM role the container can assume"
  type        = string
  default     = ""
}

variable "environment" {
  description = "Key-value pairs injected into the container"
  type        = map(string)
  default     = {}
}

variable "platform_capabilities" {
  description = "FARGATE or EC2"
  type        = list(string)
  default     = ["EC2"]
}

variable "retry_strategy" {
  description = "Retry configuration"
  type = object({
    attempts = number
  })
  default = { attempts = 3 }
}

variable "timeout_minutes" {
  description = "Job timeout (minutes)"
  type        = number
  default     = 30
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}
