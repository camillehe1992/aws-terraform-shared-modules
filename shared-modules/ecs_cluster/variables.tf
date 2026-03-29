variable "retention_in_days" {
  description = "Number of days to retain logs"
  type        = number
  default     = 7
}

variable "name" {
  description = "ECS cluster name"
  type        = string
}

variable "kms_key_id" {
  description = "KMS key ID for encrypting cluster resources"
  type        = string
  default     = null
}

variable "log_configuration" {
  description = "Log configuration for the cluster"
  type = object({
    enabled                      = bool
    s3_bucket_name               = string
    s3_bucket_encryption_enabled = bool
    s3_key_prefix                = string
  })
  default = {
    enabled                      = true
    s3_bucket_name               = null
    s3_bucket_encryption_enabled = false
    s3_key_prefix                = ""
  }
}

variable "managed_storage_configuration" {
  description = "Managed storage configuration for the cluster"
  type = object({
    enabled                              = bool
    fargate_ephemeral_storage_kms_key_id = string
    kms_key_id                           = string
  })
  default = {
    enabled                              = false
    fargate_ephemeral_storage_kms_key_id = null
    kms_key_id                           = null
  }
}

variable "container_insights" {
  description = "Enable CloudWatch Container Insights"
  type        = bool
  default     = false
}

variable "capacity_providers" {
  description = "List of capacity providers (usually FARGATE or FARGATE_SPOT)"
  type        = list(string)
  default     = []
}

variable "default_capacity_provider_strategy" {
  description = "Default strategy for the cluster"
  type = list(object({
    capacity_provider = string
    weight            = number
    base              = number
  }))
  default = []
}

variable "auto_scaling_group_provider" {
  description = "Auto scaling group provider"
  type = object({
    auto_scaling_group_arn         = string
    managed_termination_protection = optional(string, "ENABLED")
    managed_draining               = optional(string, "ENABLED")
    instance_warmup_period         = optional(number, 300)
    maximum_scaling_step_size      = optional(number, 100)
    minimum_scaling_step_size      = optional(number, 1)
    status                         = optional(string, "ENABLED")
    target_capacity                = optional(number, 10)
  })
  default = null
}

variable "managed_instances_provider" {
  description = "Managed instances provider"
  type = object({
    infrastructure_role_arn = string
    instance_launch_template = object({
      ec2_instance_profile_arn = string
      monitoring               = string
      subnets                  = list(string)
      security_groups          = list(string)
      storage_size_gib         = number
      min_meory_mib            = number
      max_meory_mib            = number
      min_vcpu_count           = number
      max_vcpu_count           = number
      instance_generations     = list(string)
      cpu_manufacturers        = list(string)
    })
  })
  default = null
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}
