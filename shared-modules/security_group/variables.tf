# General Deployment Variables
variable "tags" {
  description = "The key value pairs we want to apply as tags to the resources contained in this module"
  type        = map(string)
  default     = {}
}

variable "description" {
  description = "The description of SG"
  type        = string
  default     = "Managed by Terraform"
}

variable "name" {
  description = "The name of SG"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the SG is created"
  type        = string
}

variable "ingress_prefix_lists" {
  type        = set(string)
  description = "A set of prefix list for ingress"
  default     = []
}

variable "ingress_referenced_sg_ids" {
  type        = set(string)
  description = "A set of referenced SG ids for ingress"
  default     = []
}

variable "ingress_cidrs" {
  type = set(object({
    description = string
    cidr_ipv4   = optional(string)
    cidr_ipv6   = optional(string)
    from_port   = optional(number)
    to_port     = optional(number)
    ip_protocol = optional(string)
  }))
  description = "A set of CIDR for ingress"
  default     = []
}

variable "egress_referenced_sg_ids" {
  type        = set(string)
  description = "A set of referenced SG ids for egress"
  default     = []
}

variable "egress_cidrs" {
  type = set(object({
    description = string
    cidr_ipv4   = optional(string)
    cidr_ipv6   = optional(string)
    from_port   = optional(number)
    to_port     = optional(number)
    ip_protocol = optional(string)
  }))
  description = "A set of CIDR for egress, default to allow all outbound traffic"
  default = [
    {
      description = "Allow all outbound IPv4 traffic"
      cidr_ipv4   = "0.0.0.0/0"
      from_port   = null
      to_port     = null
      ip_protocol = "-1"
    },
    {
      description = "Allow all outbound IPv6 traffic"
      cidr_ipv6   = "::/0"
      from_port   = null
      to_port     = null
      ip_protocol = "-1"
    }
  ]
}
