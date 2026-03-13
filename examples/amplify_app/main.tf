module "amplify_app" {
  source = "../../shared-modules/amplify_app"

  name_prefix   = var.name_prefix
  repository    = var.repository
  access_token  = var.access_token
  branch_config = var.branch_config

  tags = var.tags
}

# Outputs
output "amplify_app" {
  value       = module.amplify_app.amplify_app
  description = "The access domain url for each environment."
}
