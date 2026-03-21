variable "tags" {
  description = "The key value pairs we want to apply as tags to the resources contained in this module"
  type        = map(string)
  default     = {}
}

variable "layer_name" {
  description = "The name of Lambda layer"
  type        = string
}

variable "description" {
  description = "The description of Lambda layer"
  type        = string
  default     = ""
}

variable "source_dir" {
  description = "Relative path to the function's requirement file within the current working directory"
  type        = string
}

variable "output_path" {
  description = "The path to the output zip file"
  type        = string
}

variable "compatible_runtimes" {
  type        = list(string)
  description = "List of compatible runtimes of the Lambda layer, e.g. [python3.12]"
  default     = ["python3.12"]
}

variable "compatible_architectures" {
  description = "The type of computer processor that Lambda uses to run the function"
  type        = set(string)
  default     = ["arm64"]
}
