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

variable "branch_config" {
  type = map(object({
    enabled                     = bool
    environment                 = string
    branch_name                 = string
    enable_auto_build           = string
    enable_pull_request_preview = string
    environment_variables       = map(string)
  }))
  description = "The branch config of current platform"
}
