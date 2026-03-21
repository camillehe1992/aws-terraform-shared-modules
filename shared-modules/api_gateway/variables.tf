variable "api_name" {
  description = "Name of the API Gateway"
  type        = string
}

variable "description" {
  description = "Description of the API Gateway"
  type        = string
  default     = "Created by Terraform from OpenAPI"
}

variable "openapi_file_content" {
  description = "Content of the OpenAPI specification file (YAML or JSON)"
  type        = string
}
variable "endpoint_types" {
  description = "Endpoint type of the API Gateway"
  type        = list(string)
  default     = ["REGIONAL"]
}

variable "stage_name" {
  description = "Stage name of the API Gateway"
  type        = string
  default     = "prod"
}

variable "retention_in_days" {
  description = "Number of days to retain log events"
  type        = number
  default     = 7
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
