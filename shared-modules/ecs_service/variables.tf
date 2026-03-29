# Log Group Configuration
# Check: CKV_AWS_338: "Ensure CloudWatch log groups retains logs for at least 1 year"
variable "retention_in_days" {
  description = "Number of days to retain log events in the CloudWatch Logs group"
  type        = number
  default     = 7
}

# Check: CKV_AWS_158: "Ensure that CloudWatch Log Group is encrypted by KMS"
variable "kms_key_id" {
  description = "KMS key ID for encrypting CloudWatch Logs group"
  type        = string
  default     = null
}

# ECS Service Configuration
variable "service_name" {
  description = "Name of the ECS service"
  type        = string
}

variable "cluster_id" {
  description = "ECS cluster ID where the service will be deployed"
  type        = string
}

variable "desired_count" {
  description = "Number of instances of the task definition to run"
  type        = number
  default     = 1
}

variable "launch_type" {
  description = "Launch type for the ECS service (EC2 or FARGATE)"
  type        = string
  default     = "FARGATE"
}

variable "deployment_maximum_percent" {
  description = "The upper limit (as a percentage of the desired count) of the number of running tasks that can be running in a service during a deployment"
  type        = number
  default     = 200
}

variable "deployment_minimum_healthy_percent" {
  description = "The lower limit (as a percentage of the desired count) of the number of running tasks that must be running in a service during a deployment"
  type        = number
  default     = 100
}

variable "deployment_circuit_breaker" {
  description = "Enable deployment circuit breaker for rollback on failure"
  type        = bool
  default     = false
}

variable "enable_execute_command" {
  description = "Enable ECS Exec for debugging"
  type        = bool
  default     = false
}

variable "force_new_deployment" {
  description = "Force a new deployment of the service"
  type        = bool
  default     = false
}

variable "wait_for_steady_state" {
  description = "Wait for the service to reach a steady state"
  type        = bool
  default     = true
}

variable "propagate_tags" {
  description = "Propagate tags from the service to the tasks"
  type        = string
  default     = "SERVICE"
}

# Task Definition Configuration
variable "family_name" {
  description = "Family name for the task definition"
  type        = string
}

variable "network_mode" {
  description = "Network mode for the task definition"
  type        = string
  default     = "awsvpc"
}

variable "cpu" {
  description = "CPU units for the task"
  type        = string
  default     = "256"
}

variable "memory" {
  description = "Memory for the task"
  type        = string
  default     = "512"
}

variable "execution_role_arn" {
  description = "ARN of the task execution role"
  type        = string
}

variable "task_role_arn" {
  description = "ARN of the task role"
  type        = string
  default     = null
}

variable "containers" {
  description = "Container definitions for the task"
  type = list(object({
    name        = string
    image       = string
    cpu         = optional(number)
    memory      = optional(number)
    essential   = optional(bool, true)
    environment = optional(map(string), {})
    secrets = optional(list(object({
      name       = string
      value_from = string
    })), [])
    port_mappings = optional(list(object({
      container_port = number
      host_port      = optional(number)
      protocol       = optional(string, "tcp")
    })), [])
    mount_points = optional(list(object({
      source_volume  = string
      container_path = string
      read_only      = optional(bool, false)
    })), [])
    log_configuration = optional(object({
      log_driver = optional(string, "awslogs")
      options    = optional(map(string), {})
      secret_options = optional(list(object({
        name       = string
        value_from = string
      })), [])
    }))
    health_check = optional(object({
      command      = list(string)
      interval     = optional(number, 30)
      timeout      = optional(number, 5)
      retries      = optional(number, 3)
      start_period = optional(number, 0)
    }))
    working_directory        = optional(string)
    user                     = optional(string)
    readonly_root_filesystem = optional(bool, false)
    privileged               = optional(bool, false)
    linux_parameters         = optional(any)
  }))
}

variable "volumes" {
  description = "Volume definitions for the task"
  type = list(object({
    name = string
    efs_volume_configuration = optional(object({
      file_system_id          = string
      root_directory          = optional(string, "/")
      transit_encryption      = optional(string, "DISABLED")
      transit_encryption_port = optional(number)
      authorization_config = optional(object({
        access_point_id = optional(string)
        iam             = optional(string, "DISABLED")
      }))
    }))
    docker_volume_configuration = optional(object({
      scope         = optional(string, "task")
      autoprovision = optional(bool, false)
      driver        = optional(string, "local")
      driver_opts   = optional(map(string), {})
      labels        = optional(map(string), {})
    }))
  }))
  default = []
}

variable "runtime_platform" {
  description = "Runtime platform configuration"
  type = object({
    cpu_architecture        = optional(string, "X86_64")
    operating_system_family = optional(string, "LINUX")
  })
  default = null
}

# Network Configuration (for awsvpc mode)
variable "subnets" {
  description = "Subnets for the service (required for awsvpc network mode)"
  type        = list(string)
  default     = []
}

variable "security_groups" {
  description = "Security groups for the service (required for awsvpc network mode)"
  type        = list(string)
  default     = []
}

variable "assign_public_ip" {
  description = "Assign public IP to tasks"
  type        = bool
  default     = false
}

# Load Balancer Configuration
variable "load_balancers" {
  description = "Load balancer configuration for the service"
  type = list(object({
    target_group_arn = string
    container_name   = string
    container_port   = number
  }))
  default = []
}

# Service Discovery Configuration
variable "service_discovery" {
  description = "Service discovery configuration"
  type = object({
    registry_arn   = string
    port           = optional(number)
    container_name = optional(string)
    container_port = optional(number)
  })
  default = null
}

variable "service_registries" {
  description = "Service registries for the service"
  type = list(object({
    registry_arn   = string
    port           = optional(number)
    container_name = optional(string)
    container_port = optional(number)
  }))
  default = []
}

# Common
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
