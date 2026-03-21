variable "bucket_name" {
  description = "Globally-unique name for the S3 bucket"
  type        = string
}

variable "tags" {
  description = "Tags applied to every AWS resource"
  type        = map(string)
  default     = {}
}

# ---------  optional behaviours  ---------
variable "enable_website_hosting" {
  description = "Turn on S3 static-website hosting (index + error doc)"
  type        = bool
  default     = true
}

variable "index_document" {
  description = "Default index file"
  type        = string
  default     = "index.html"
}

variable "error_document" {
  description = "File returned for 4xx errors"
  type        = string
  default     = "404.html"
}

variable "public_read" {
  description = "Make bucket contents publicly readable"
  type        = bool
  default     = true
}

variable "force_destroy" {
  description = "Delete bucket even when it contains objects"
  type        = bool
  default     = false
}

variable "versioning" {
  description = "Keep multiple versions of each object"
  type        = bool
  default     = false
}

variable "cors_allowed_origins" {
  description = "List of origins allowed via CORS (* for all)"
  type        = list(string)
  default     = ["*"]
}

variable "cors_allowed_methods" {
  description = "HTTP verbs allowed via CORS"
  type        = list(string)
  default     = ["GET", "HEAD"]
}

variable "cors_allowed_headers" {
  description = "Headers allowed in CORS pre-flight"
  type        = list(string)
  default     = ["*"]
}
