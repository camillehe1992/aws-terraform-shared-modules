# A module to create secrets using shared-modules/secretsmanager_secrets
module "default_secrets" {
  source = "../../shared-modules/secretsmanager_secrets"

  secret_prefix = "/demo/"
  #   kms_key_id    = "alias/aws/secretsmanager"
  secret_specs = {
    "example-secret" = {
      description   = "Example secret"
      secret_string = "example-secret-value"
    }
  }
}

# Output the created secrets
output "default_secrets" {
  value = module.default_secrets.secrets
}
