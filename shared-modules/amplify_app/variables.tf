variable "tags" {
  type        = map(string)
  description = "The key value pairs we want to apply as tags to the resources contained in this module"
  default     = {}
}

variable "name_prefix" {
  type        = string
  description = "The prefix name of the Amplify app"
}

variable "repository" {
  type        = string
  description = "The repository for source code"
}

variable "access_token" {
  type        = string
  description = "Personal access token for a third-party source control system for an Amplify app"
  sensitive   = true
}

variable "framework" {
  type        = string
  default     = "Vue"
  description = "The framework of web application"
}

variable "branch_config" {
  type = map(object({
    enabled                     = optional(bool, true)
    environment                 = string
    branch_name                 = string
    enable_auto_build           = optional(bool, true)
    enable_pull_request_preview = optional(bool, true)
    environment_variables       = optional(map(string), {})
    secrets                     = optional(list(string), [])
  }))
  description = "The branch config of current platform"
  validation {
    condition     = alltrue([for key, value in var.branch_config : value.environment == "production" || value.environment == "develop"])
    error_message = "environment must be either production or develop"
  }

  validation {
    condition     = length(keys(var.branch_config)) == length((distinct([for key, value in var.branch_config : value.environment])))
    error_message = "environment must be unique"
  }
}
