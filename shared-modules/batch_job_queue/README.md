# Batch Job Queue Module

Creates AWS Batch job queues for job scheduling and management.

<!-- BEGIN_TF_DOCS -->

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.37.0 |
## Resources

| Name | Type |
|------|------|
| [aws_batch_job_queue.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/batch_job_queue) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compute_environments"></a> [compute\_environments](#input\_compute\_environments) | Ordered list of compute environment ARNs | <pre>list(object({<br/>    order               = number<br/>    compute_environment = string<br/>  }))</pre> | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the job queue | `string` | n/a | yes |
| <a name="input_priority"></a> [priority](#input\_priority) | Priority of the job queue (higher is better) | `number` | `1` | no |
| <a name="input_scheduling_policy_arn"></a> [scheduling\_policy\_arn](#input\_scheduling\_policy\_arn) | ARN of the scheduling policy | `string` | `null` | no |
| <a name="input_state"></a> [state](#input\_state) | State of the job queue (ENABLED or DISABLED) | `string` | `"ENABLED"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to resources | `map(string)` | `{}` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_job_queue_arn"></a> [job\_queue\_arn](#output\_job\_queue\_arn) | ARN of the job queue |
| <a name="output_job_queue_name"></a> [job\_queue\_name](#output\_job\_queue\_name) | Name of the job queue |
<!-- END_TF_DOCS -->
## Examples
See [examples/batch_job_queue](../../examples/batch_job_queue)
