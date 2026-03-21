variable "tags" {
  description = "The key value pairs we want to apply as tags to the resources contained in this module"
  type        = map(string)
  default     = {}
}

variable "resource_prefix" {
  description = "Prefix of the resource name"
  type        = string
  default     = ""
}

variable "instance_types" {
  description = "A list of instance type that launched in batch compute environment"
  type        = set(string)
  default     = ["c5.large", "c5.xlarge", "c5.2xlarge"]
}

variable "max_vcpus" {
  description = "The max vCPU that the compute environment maintains"
  type        = number
  default     = 16
}

variable "min_vcpus" {
  description = "The min vCPU that the compute environment maintains"
  type        = number
  default     = 0
}

variable "desired_vcpus" {
  description = "The number of vCPUs that your compute environment launches with."
  type        = number
  default     = 0
}

variable "vpc_id" {
  description = "The VPC ID that the compute environment is in."
  type        = string
}

variable "subnet_ids" {
  description = "List of Subnet ids that Batch job runs in"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of Security Group ids that Batch job runs in"
  type        = list(string)
}

variable "compute_resources_type" {
  description = "The type of compute resources in the compute environment"
  type        = string
  default     = "EC2"
}

variable "instance_role_profile_arn" {
  description = "ARN of the IAM role that Batch uses to launch instances in the compute environment."
  type        = string
  default     = null
}

variable "service_role_arn" {
  description = "ARN of the IAM role that Batch uses to manage resources on your behalf."
  type        = string
}

variable "state" {
  description = "The state of the compute environment"
  type        = string
  default     = "ENABLED"
}

variable "terminate_jobs_on_update" {
  description = "Whether to terminate jobs in the compute environment when it is updated."
  type        = bool
  default     = true
}

variable "job_execution_timeout_minutes" {
  description = "The timeout (in minutes) that Batch terminates jobs in the compute environment."
  type        = number
  default     = 30
}
