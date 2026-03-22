<!-- BEGIN_TF_DOCS -->

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | 2.7.1 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.37.0 |
## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_lambda_function.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [archive_file.this](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_architectures"></a> [architectures](#input\_architectures) | Instruction set architecture for your Lambda function. Valid values are ["x86\_64"] and ["arm64"]. | `list(string)` | <pre>[<br/>  "x86_64"<br/>]</pre> | no |
| <a name="input_description"></a> [description](#input\_description) | The description of Lambda function | `string` | `""` | no |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | A set of environment variables of Lambda function | `map(string)` | `{}` | no |
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | (Required) The Lambda function name | `string` | n/a | yes |
| <a name="input_handler"></a> [handler](#input\_handler) | The handler of Lambda function | `string` | `"lambda_function.handler"` | no |
| <a name="input_ipv6_allowed_for_dual_stack"></a> [ipv6\_allowed\_for\_dual\_stack](#input\_ipv6\_allowed\_for\_dual\_stack) | Indicates whether the function is allowed to be invoked over IPv6. Defaults to false. | `bool` | `false` | no |
| <a name="input_lambda_permissions"></a> [lambda\_permissions](#input\_lambda\_permissions) | A map of lambda permissions | <pre>map(object({<br/>    principal  = string<br/>    source_arn = string<br/>  }))</pre> | `{}` | no |
| <a name="input_layers"></a> [layers](#input\_layers) | A list of Lambda function associated layers ARN | `list(string)` | `[]` | no |
| <a name="input_memory_size"></a> [memory\_size](#input\_memory\_size) | The memory size (MiB) of Lambda function | `number` | `128` | no |
| <a name="input_output_path"></a> [output\_path](#input\_output\_path) | The zip file name of Lambda function source code | `string` | `null` | no |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | The retention (days) of Lambda function Cloudwatch logs group | `number` | `14` | no |
| <a name="input_role_arn"></a> [role\_arn](#input\_role\_arn) | (Required) The ARN of Lambda function excution role | `string` | n/a | yes |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | The runtime of Lambda function | `string` | `"python3.12"` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | A list of Security group Ids | `list(string)` | `[]` | no |
| <a name="input_source_dir"></a> [source\_dir](#input\_source\_dir) | The source dir of Lambda function source code. Conflict with source\_file | `string` | `null` | no |
| <a name="input_source_file"></a> [source\_file](#input\_source\_file) | The file name of Lambda function source code | `string` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of Subnet Ids | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The key value pairs we want to apply as tags to the resources contained in this module | `map(string)` | `{}` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | The timeout (seconds) of Lambda function | `number` | `60` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_function_arn"></a> [function\_arn](#output\_function\_arn) | The ARN of the Lambda function |
| <a name="output_function_name"></a> [function\_name](#output\_function\_name) | The name of the Lambda function |
| <a name="output_invoke_arn"></a> [invoke\_arn](#output\_invoke\_arn) | The ARN to be used for invoking the Lambda function from API Gateway |
| <a name="output_log_group_name"></a> [log\_group\_name](#output\_log\_group\_name) | The name of the CloudWatch Log Group |

## Examples
<!-- terraform-docs gets the path; we strip it manually -->
See [examples/lambda_function](../../examples/lambda_function).
<!-- END_TF_DOCS -->
