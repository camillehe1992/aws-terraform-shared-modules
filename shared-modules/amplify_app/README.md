# Amplify App Module

Creates AWS Amplify applications for continuous deployment and hosting.

<!-- BEGIN_TF_DOCS -->

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.36.0 |
## Resources

| Name | Type |
|------|------|
| [aws_amplify_app.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/amplify_app) | resource |
| [aws_amplify_branch.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/amplify_branch) | resource |
| [aws_ssm_parameter.secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_token"></a> [access\_token](#input\_access\_token) | Personal access token for a third-party source control system for an Amplify app | `string` | n/a | yes |
| <a name="input_branch_config"></a> [branch\_config](#input\_branch\_config) | The branch config of current platform | <pre>map(object({<br/>    enabled                     = optional(bool, true)<br/>    environment                 = string<br/>    branch_name                 = string<br/>    enable_auto_build           = optional(bool, true)<br/>    enable_pull_request_preview = optional(bool, true)<br/>    environment_variables       = optional(map(string), {})<br/>    secrets                     = optional(list(string), [])<br/>  }))</pre> | n/a | yes |
| <a name="input_framework"></a> [framework](#input\_framework) | The framework of web application | `string` | `"Vue"` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | The prefix name of the Amplify app | `string` | n/a | yes |
| <a name="input_repository"></a> [repository](#input\_repository) | The repository for source code | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | The key value pairs we want to apply as tags to the resources contained in this module | `map(string)` | `{}` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_amplify_app"></a> [amplify\_app](#output\_amplify\_app) | ARN of the Amplify app |

## Examples
<!-- terraform-docs gets the path; we strip it manually -->
See [examples/REPLACE_ME](../../examples/REPLACE_ME).
<!-- END_TF_DOCS -->
## Examples
See [examples/amplify_app](../../examples/amplify_app)
