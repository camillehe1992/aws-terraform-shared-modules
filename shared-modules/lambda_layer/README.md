# Lambda Layer Module

Creates AWS Lambda layers for shared code and dependencies.

<!-- BEGIN_TF_DOCS -->

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | 2.7.1 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.37.0 |
## Resources

| Name | Type |
|------|------|
| [aws_lambda_layer_version.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_layer_version) | resource |
| [archive_file.this](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compatible_architectures"></a> [compatible\_architectures](#input\_compatible\_architectures) | The type of computer processor that Lambda uses to run the function | `set(string)` | <pre>[<br/>  "arm64"<br/>]</pre> | no |
| <a name="input_compatible_runtimes"></a> [compatible\_runtimes](#input\_compatible\_runtimes) | List of compatible runtimes of the Lambda layer, e.g. [python3.12] | `list(string)` | <pre>[<br/>  "python3.12"<br/>]</pre> | no |
| <a name="input_description"></a> [description](#input\_description) | The description of Lambda layer | `string` | `""` | no |
| <a name="input_layer_name"></a> [layer\_name](#input\_layer\_name) | The name of Lambda layer | `string` | n/a | yes |
| <a name="input_output_path"></a> [output\_path](#input\_output\_path) | The path to the output zip file | `string` | n/a | yes |
| <a name="input_source_dir"></a> [source\_dir](#input\_source\_dir) | Relative path to the function's requirement file within the current working directory | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | The key value pairs we want to apply as tags to the resources contained in this module | `map(string)` | `{}` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_layer_arn"></a> [layer\_arn](#output\_layer\_arn) | The ARN of the Lambda layer |
| <a name="output_layer_version"></a> [layer\_version](#output\_layer\_version) | The version of the Lambda layer |

## Examples
<!-- terraform-docs gets the path; we strip it manually -->
See [examples/REPLACE_ME](../../examples/REPLACE_ME).
<!-- END_TF_DOCS -->
## Examples
See [examples/lambda_layer](../../examples/lambda_layer)
