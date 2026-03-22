## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret.secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.versions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The KMS key id or ARN to use for encrypting the secret value. If not specified, the default AWS managed key will be used. | `string` | `null` | no |
| <a name="input_recovery_window_in_days"></a> [recovery\_window\_in\_days](#input\_recovery\_window\_in\_days) | The number of days to wait before recovery of the secret. Default is 7 days. | `number` | `7` | no |
| <a name="input_secret_prefix"></a> [secret\_prefix](#input\_secret\_prefix) | The prefix of secret | `string` | `""` | no |
| <a name="input_secret_specs"></a> [secret\_specs](#input\_secret\_specs) | A map of secret specs. Each key is the secret name, and each value is an object with description and secret\_string. | <pre>map(object({<br/>    description   = string<br/>    secret_string = string<br/>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The key value pairs we want to apply as tags to the resources contained in this module | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_secrets"></a> [secrets](#output\_secrets) | n/a |

<!-- BEGIN_TF_DOCS -->

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.35.1 |
## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret.secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.versions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.default_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The KMS key id or ARN to use for encrypting the secret value. If not specified, the default AWS managed key will be used. | `string` | `null` | no |
| <a name="input_recovery_window_in_days"></a> [recovery\_window\_in\_days](#input\_recovery\_window\_in\_days) | The number of days to wait before recovery of the secret. Default is 7 days. | `number` | `7` | no |
| <a name="input_secret_prefix"></a> [secret\_prefix](#input\_secret\_prefix) | The prefix of secret | `string` | `""` | no |
| <a name="input_secret_specs"></a> [secret\_specs](#input\_secret\_specs) | A map of secret specs. Each key is the secret name, and each value is an object with description and secret\_string. | <pre>map(object({<br/>    description   = string<br/>    secret_string = string<br/>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The key value pairs we want to apply as tags to the resources contained in this module | `map(string)` | `{}` | no |
| <a name="input_user_provided_policy"></a> [user\_provided\_policy](#input\_user\_provided\_policy) | The user provided IAM policy document to use for the secret. If not specified, the default policy will be used. | `string` | `null` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_secrets"></a> [secrets](#output\_secrets) | n/a |

## Examples
<!-- terraform-docs gets the path; we strip it manually -->
See [examples/secretsmanager_secrets](../../examples/secretsmanager_secrets).
<!-- END_TF_DOCS -->
