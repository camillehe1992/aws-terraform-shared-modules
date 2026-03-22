<!-- BEGIN_TF_DOCS -->

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.37.0 |
## Resources

| Name | Type |
|------|------|
| [aws_batch_job_definition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/batch_job_definition) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_image"></a> [container\_image](#input\_container\_image) | Docker image to run | `string` | n/a | yes |
| <a name="input_container_memory"></a> [container\_memory](#input\_container\_memory) | Memory (MiB) for the container | `number` | `1024` | no |
| <a name="input_container_vcpu"></a> [container\_vcpu](#input\_container\_vcpu) | vCPU count for the container | `number` | `1` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Key-value pairs injected into the container | `map(string)` | `{}` | no |
| <a name="input_job_role_arn"></a> [job\_role\_arn](#input\_job\_role\_arn) | IAM role the container can assume | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the job definition | `string` | n/a | yes |
| <a name="input_platform_capabilities"></a> [platform\_capabilities](#input\_platform\_capabilities) | FARGATE or EC2 | `list(string)` | <pre>[<br/>  "EC2"<br/>]</pre> | no |
| <a name="input_retry_strategy"></a> [retry\_strategy](#input\_retry\_strategy) | Retry configuration | <pre>object({<br/>    attempts = number<br/>  })</pre> | <pre>{<br/>  "attempts": 3<br/>}</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply | `map(string)` | `{}` | no |
| <a name="input_timeout_minutes"></a> [timeout\_minutes](#input\_timeout\_minutes) | Job timeout (minutes) | `number` | `30` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_job_definition_arn"></a> [job\_definition\_arn](#output\_job\_definition\_arn) | ARN of the job definition |
| <a name="output_job_definition_name"></a> [job\_definition\_name](#output\_job\_definition\_name) | Name of the job definition (latest:rev) |

## Examples
<!-- terraform-docs gets the path; we strip it manually -->
See [examples/batch_job_definition](../../examples/batch_job_definition).
<!-- END_TF_DOCS -->
