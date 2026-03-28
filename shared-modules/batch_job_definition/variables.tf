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

variable "execution_role_arn" {
  description = "IAM role the container can assume for Fargate"
  type        = string
  default     = ""
}

variable "platform_capabilities" {
  description = "FARGATE or EC2"
  type        = list(string)
  default     = ["EC2"]
}

variable "command" {
  description = "Command to run"
  type        = list(string)
  default     = []
}

variable "volumes" {
  description = "Volumes to mount"
  type = list(object({
    name   = string
    source = string
  }))
  default = []
}

variable "mount_points" {
  description = "Mount points to use"
  type = list(object({
    container = string
    host      = string
  }))
  default = []
}

variable "secrets" {
  description = "Secrets to inject"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "retry_strategy" {
  description = "Retry configuration"
  type = object({
    attempts = number
  })
  default = { attempts = 3 }
}

variable "parameters" {
  description = "Key-value pairs injected into the container"
  type        = map(string)
  default     = {}
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
