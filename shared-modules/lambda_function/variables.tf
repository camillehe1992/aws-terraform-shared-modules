variable "tags" {
  description = "The key value pairs we want to apply as tags to the resources contained in this module"
  type        = map(string)
  default     = {}
}

variable "function_name" {
  description = "(Required) The Lambda function name"
  type        = string
}

variable "description" {
  description = "The description of Lambda function"
  type        = string
  default     = ""
}

variable "role_arn" {
  description = "(Required) The ARN of Lambda function excution role"
  type        = string
}

variable "handler" {
  description = "The handler of Lambda function"
  type        = string
  default     = "lambda_function.handler"
}

variable "memory_size" {
  description = "The memory size (MiB) of Lambda function"
  type        = number
  default     = 128
}

variable "timeout" {
  description = "The timeout (seconds) of Lambda function"
  type        = number
  default     = 60
}

variable "runtime" {
  description = "The runtime of Lambda function"
  type        = string
  default     = "python3.12"
}

variable "source_file" {
  description = "The file name of Lambda function source code"
  type        = string
  default     = null
}

variable "source_dir" {
  description = "The source dir of Lambda function source code. Conflict with source_file"
  type        = string
  default     = null
}

variable "output_path" {
  description = "The zip file name of Lambda function source code"
  type        = string
  default     = null
}

variable "layers" {
  description = "A list of Lambda function associated layers ARN"
  type        = list(string)
  default     = []
}

variable "architectures" {
  description = "Instruction set architecture for your Lambda function. Valid values are [\"x86_64\"] and [\"arm64\"]."
  type        = list(string)
  default     = ["x86_64"]
}


variable "environment_variables" {
  description = "A set of environment variables of Lambda function"
  type        = map(string)
  default     = {}
}

variable "ipv6_allowed_for_dual_stack" {
  description = "Indicates whether the function is allowed to be invoked over IPv6. Defaults to false."
  type        = bool
  default     = false
}

variable "subnet_ids" {
  description = "A list of Subnet Ids"
  type        = list(string)
  default     = []
}

variable "security_group_ids" {
  description = "A list of Security group Ids"
  type        = list(string)
  default     = []
}

variable "retention_in_days" {
  description = "The retention (days) of Lambda function Cloudwatch logs group"
  type        = number
  default     = 14
}

variable "lambda_permissions" {
  description = "A map of lambda permissions"
  type = map(object({
    principal  = string
    source_arn = string
  }))
  default = {}
}
