# API Gateway Module

Creates AWS API Gateway REST APIs with methods, integrations, and deployment stages.

<!-- BEGIN_TF_DOCS -->

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.37.0 |
## Resources

| Name | Type |
|------|------|
| [aws_api_gateway_deployment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_deployment) | resource |
| [aws_api_gateway_rest_api.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_rest_api) | resource |
| [aws_api_gateway_rest_api_policy.default_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_rest_api_policy) | resource |
| [aws_api_gateway_stage.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_stage) | resource |
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_policy_document.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_name"></a> [api\_name](#input\_api\_name) | Name of the API Gateway | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | Description of the API Gateway | `string` | `"Created by Terraform from OpenAPI"` | no |
| <a name="input_endpoint_types"></a> [endpoint\_types](#input\_endpoint\_types) | Endpoint type of the API Gateway | `list(string)` | <pre>[<br/>  "REGIONAL"<br/>]</pre> | no |
| <a name="input_openapi_file_content"></a> [openapi\_file\_content](#input\_openapi\_file\_content) | Content of the OpenAPI specification file (YAML or JSON) | `string` | n/a | yes |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | Number of days to retain log events | `number` | `7` | no |
| <a name="input_stage_name"></a> [stage\_name](#input\_stage\_name) | Stage name of the API Gateway | `string` | `"prod"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to resources | `map(string)` | `{}` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cw_log_group_arn"></a> [cw\_log\_group\_arn](#output\_cw\_log\_group\_arn) | The ARN of the CloudWatch Log Group for API Gateway |
| <a name="output_execution_arn"></a> [execution\_arn](#output\_execution\_arn) | The ARN of the API Gateway execution |
| <a name="output_invoke_url"></a> [invoke\_url](#output\_invoke\_url) | The invoke URL for the API Gateway stage |
| <a name="output_rest_api_id"></a> [rest\_api\_id](#output\_rest\_api\_id) | The ID of the API Gateway REST API |
<!-- END_TF_DOCS -->
## Examples
See [examples/api_gateway](../../examples/api_gateway)
