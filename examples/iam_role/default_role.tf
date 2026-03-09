# Example with all default values

# Example with default AWS managed policy AmazonEC2FullAccess attached
module "default_role" {
  source    = "../../shared-modules/iam_role"
  role_name = "default-role"
}

output "default_role_arn" {
  description = "The ARN of default role"
  value       = module.default_role.role_arn
}
