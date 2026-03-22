variable "name" {
  description = "ECS cluster name"
  type        = string
}

variable "capacity_providers" {
  description = "List of capacity providers (usually FARGATE or FARGATE_SPOT)"
  type        = list(string)
  default     = ["FARGATE"]
}

variable "default_capacity_provider_strategy" {
  description = "Default strategy for the cluster"
  type = list(object({
    capacity_provider = string
    weight            = number
    base              = number
  }))
  default = [{
    capacity_provider = "FARGATE"
    weight            = 1
    base              = 0
  }]
}

variable "container_insights" {
  description = "Enable CloudWatch Container Insights"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}
