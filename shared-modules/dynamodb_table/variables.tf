variable "tags" {
  type        = map(string)
  default     = {}
  description = "The key value pairs apply as tags to all resources in the module"
}

variable "table_name" {
  description = "The name of the DynamoDB table"
  type        = string
}

variable "table_description" {
  description = "The description of the DynamoDB table"
  type        = string
}

variable "hash_key" {
  description = "The hash key of the DynamoDB table"
  type        = string
}

variable "range_key" {
  description = "The range key of the DynamoDB table"
  type        = string
  default     = null
}

variable "billing_mode" {
  description = "The billing mode of the DynamoDB table"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "read_capacity" {
  description = "The read capacity units of the DynamoDB table"
  type        = number
  default     = 1
}

variable "write_capacity" {
  description = "The write capacity of the DynamoDB table"
  type        = number
  default     = 1
}

variable "deletion_protection_enabled" {
  description = "Whether deletion protection is enabled for the DynamoDB table"
  type        = bool
  default     = false
}

variable "global_secondary_indexes" {
  description = "The global secondary indexes of the DynamoDB table"
  type = list(object({
    name = string
    key_schema = list(object({
      attribute_name = string
      attribute_type = optional(string, "S")
      key_type       = string
    }))
    read_capacity      = optional(number, 1)
    write_capacity     = optional(number, 1)
    non_key_attributes = optional(list(string), [])
    projection_type    = optional(string, "INCLUDE")
  }))
  default = []
}

variable "ttl_enabled" {
  description = "Whether TTL is enabled for the DynamoDB table"
  type        = bool
  default     = false
}

variable "ttl_attribute_name" {
  description = "The attribute name of the TTL attribute"
  type        = string
  default     = null
}

variable "stream_enabled" {
  description = "Whether DynamoDB Streams is enabled for the DynamoDB table"
  type        = bool
  default     = false
}

variable "stream_view_type" {
  description = "The view type of the DynamoDB Streams"
  type        = string
  default     = null
}

variable "point_in_time_recovery" {
  description = "Whether point-in-time recovery is enabled for the DynamoDB table"
  type        = bool
  default     = false
}

variable "recovery_period_in_days" {
  description = "The recovery period in days of the point-in-time recovery"
  type        = number
  default     = 7
}
