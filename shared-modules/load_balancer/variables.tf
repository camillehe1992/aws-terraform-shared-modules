# General Configuration
variable "name" {
  description = "Name of the load balancer"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the load balancer will be created"
  type        = string
}

variable "subnets" {
  description = "List of subnet IDs for the load balancer"
  type        = list(string)
}

variable "security_groups" {
  description = "List of security group IDs for the load balancer"
  type        = list(string)
}

variable "internal" {
  description = "Whether the load balancer is internal (true) or internet-facing (false)"
  type        = bool
  default     = false
}

variable "load_balancer_type" {
  description = "Type of load balancer: application, network, or gateway"
  type        = string
  default     = "application"
}

# Advanced Configuration
variable "enable_deletion_protection" {
  description = "Enable deletion protection for the load balancer"
  type        = bool
  default     = false
}

variable "enable_http2" {
  description = "Enable HTTP/2 support (ALB only)"
  type        = bool
  default     = true
}

variable "enable_cross_zone_load_balancing" {
  description = "Enable cross-zone load balancing"
  type        = bool
  default     = true
}

# Access Logs Configuration
variable "access_logs" {
  description = "Access logs configuration"
  type = object({
    bucket  = string
    prefix  = optional(string)
    enabled = optional(bool, true)
  })
  default = null
}

# Subnet Mappings for NLB with Elastic IPs
variable "subnet_mappings" {
  description = "Subnet mappings for NLB with Elastic IPs"
  type = list(object({
    subnet_id            = string
    allocation_id        = optional(string)
    private_ipv4_address = optional(string)
    ipv6_address         = optional(string)
  }))
  default = []
}

# Target Groups Configuration
variable "target_groups" {
  description = "Configuration for target groups"
  type = list(object({
    name        = string
    port        = number
    protocol    = string
    target_type = optional(string, "ip")
    health_check = optional(object({
      enabled             = optional(bool, true)
      healthy_threshold   = optional(number, 2)
      unhealthy_threshold = optional(number, 2)
      timeout             = optional(number, 5)
      interval            = optional(number, 30)
      path                = optional(string, "/")
      port                = optional(string, "traffic-port")
      protocol            = optional(string, "HTTP")
      matcher             = optional(string, "200")
    }))
    stickiness = optional(object({
      type            = optional(string, "lb_cookie")
      cookie_duration = optional(number, 86400)
      enabled         = optional(bool, false)
    }))
    deregistration_delay = optional(number, 300)
  }))
}

# Listeners Configuration
variable "listeners" {
  description = "Configuration for listeners"
  type = list(object({
    port            = number
    protocol        = string
    ssl_policy      = optional(string)
    certificate_arn = optional(string)
    default_action = object({
      type              = string
      target_group_name = optional(string)
      redirect = optional(object({
        port        = optional(string)
        protocol    = optional(string)
        status_code = optional(string, "HTTP_301")
      }))
      fixed_response = optional(object({
        content_type = optional(string, "text/plain")
        message_body = optional(string)
        status_code  = optional(string, "200")
      }))
    })
  }))
}

# Listener Rules Configuration
variable "listener_rules" {
  description = "Configuration for listener rules"
  type = list(object({
    listener_index = number
    priority       = number
    actions = list(object({
      type              = string
      target_group_name = optional(string)
      redirect = optional(object({
        port        = optional(string)
        protocol    = optional(string)
        status_code = optional(string, "HTTP_301")
      }))
      fixed_response = optional(object({
        content_type = optional(string, "text/plain")
        message_body = optional(string)
        status_code  = optional(string, "200")
      }))
    }))
    conditions = list(object({
      path_pattern = optional(object({
        values = list(string)
      }))
      host_header = optional(object({
        values = list(string)
      }))
      http_header = optional(object({
        http_header_name = string
        values           = list(string)
      }))
      http_request_method = optional(object({
        values = list(string)
      }))
      query_string = optional(list(object({
        key   = optional(string)
        value = string
      })))
      source_ip = optional(object({
        values = list(string)
      }))
    }))
  }))
  default = []
}

# Common Tags
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
