#
resource "aws_kms_key" "example" {
  description         = "KMS key for demo"
  enable_key_rotation = true
}

resource "aws_kms_alias" "example" {
  name          = "alias/demo-kms-key"
  target_key_id = aws_kms_key.example.key_id
}

module "default_secrets_with_cmk" {
  source = "../../shared-modules/secretsmanager_secrets"

  secret_prefix = "/demo-with-cmk/"
  kms_key_id    = aws_kms_key.example.arn
  secret_specs = {
    "example-secret" = {
      description   = "Example secret"
      secret_string = "example-secret-value"
    }
  }
  recovery_window_in_days = 14

  tags = {
    "Environment" = "Demo"
  }
}

output "default_secrets_with_cmk" {
  value = module.default_secrets_with_cmk.secrets
}
