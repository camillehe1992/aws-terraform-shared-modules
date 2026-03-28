variable "tags" {
  description = "The key value pairs we want to apply as tags to the resources contained in this module"
  type        = map(string)
  default     = {}
}

variable "strategy" {
  description = "The placement strategy to use for the compute environment"
  type        = string
  default     = "cluster"
}

variable "partition_count" {
  description = "The number of partitions to use for the compute environment"
  type        = number
  default     = 2
}

variable "spread_level" {
  description = "The spread level to use for the compute environment"
  type        = string
  default     = "rack"
}

variable "name" {
  description = "Name of the compute environment"
  type        = string
}

variable "allocation_strategy" {
  description = "The allocation strategy to use for the compute environment"
  type        = string
  default     = "BEST_FIT"
}

variable "bid_percentage" {
  description = "The bid percentage to use for the compute environment"
  type        = number
  default     = 0
}

variable "ec2_key_pair" {
  description = "The EC2 key pair to use for the compute environment"
  type        = string
  default     = null
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

variable "image_id_override" {
  description = "The image ID to use for the compute environment"
  type        = string
  default     = null
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

variable "spot_iam_fleet_role_arn" {
  description = "ARN of the IAM role that Batch uses to launch instances in the compute environment."
  type        = string
  default     = null
}

variable "instance_role_profile_arn" {
  description = "ARN of the IAM role that Batch uses to launch instances in the compute environment."
  type        = string
  default     = null
}

variable "service_role_arn" {
  description = "ARN of the IAM role that Batch uses to manage resources on your behalf."
  type        = string
  nullable    = true
  default     = null
}

variable "state" {
  description = "The state of the compute environment"
  type        = string
  default     = "ENABLED"
}

variable "job_execution_timeout_minutes" {
  description = "The timeout (in minutes) that Batch terminates jobs in the compute environment."
  type        = number
  default     = 30
}

variable "terminate_jobs_on_update" {
  description = "Whether to terminate jobs in the compute environment when it is updated."
  type        = bool
  default     = true
}
