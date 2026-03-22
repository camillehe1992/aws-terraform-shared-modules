<!-- BEGIN_TF_DOCS -->

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.37.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.8.1 |
## Resources

| Name | Type |
|------|------|
| [aws_batch_compute_environment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/batch_compute_environment) | resource |
| [aws_placement_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/placement_group) | resource |
| [random_string.resource_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compute_resources_type"></a> [compute\_resources\_type](#input\_compute\_resources\_type) | The type of compute resources in the compute environment | `string` | `"EC2"` | no |
| <a name="input_desired_vcpus"></a> [desired\_vcpus](#input\_desired\_vcpus) | The number of vCPUs that your compute environment launches with. | `number` | `0` | no |
| <a name="input_instance_role_profile_arn"></a> [instance\_role\_profile\_arn](#input\_instance\_role\_profile\_arn) | ARN of the IAM role that Batch uses to launch instances in the compute environment. | `string` | `null` | no |
| <a name="input_instance_types"></a> [instance\_types](#input\_instance\_types) | A list of instance type that launched in batch compute environment | `set(string)` | <pre>[<br/>  "c5.large",<br/>  "c5.xlarge",<br/>  "c5.2xlarge"<br/>]</pre> | no |
| <a name="input_job_execution_timeout_minutes"></a> [job\_execution\_timeout\_minutes](#input\_job\_execution\_timeout\_minutes) | The timeout (in minutes) that Batch terminates jobs in the compute environment. | `number` | `30` | no |
| <a name="input_max_vcpus"></a> [max\_vcpus](#input\_max\_vcpus) | The max vCPU that the compute environment maintains | `number` | `16` | no |
| <a name="input_min_vcpus"></a> [min\_vcpus](#input\_min\_vcpus) | The min vCPU that the compute environment maintains | `number` | `0` | no |
| <a name="input_resource_prefix"></a> [resource\_prefix](#input\_resource\_prefix) | Prefix of the resource name | `string` | `""` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | List of Security Group ids that Batch job runs in | `list(string)` | n/a | yes |
| <a name="input_service_role_arn"></a> [service\_role\_arn](#input\_service\_role\_arn) | ARN of the IAM role that Batch uses to manage resources on your behalf. | `string` | n/a | yes |
| <a name="input_state"></a> [state](#input\_state) | The state of the compute environment | `string` | `"ENABLED"` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of Subnet ids that Batch job runs in | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | The key value pairs we want to apply as tags to the resources contained in this module | `map(string)` | `{}` | no |
| <a name="input_terminate_jobs_on_update"></a> [terminate\_jobs\_on\_update](#input\_terminate\_jobs\_on\_update) | Whether to terminate jobs in the compute environment when it is updated. | `bool` | `true` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC ID that the compute environment is in. | `string` | n/a | yes |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_compute_environment_arn"></a> [compute\_environment\_arn](#output\_compute\_environment\_arn) | ARN of the Batch compute environment |
| <a name="output_ecs_cluster_arn"></a> [ecs\_cluster\_arn](#output\_ecs\_cluster\_arn) | ARN of the ECS cluster associated with the Batch compute environment |

## Examples
<!-- terraform-docs gets the path; we strip it manually -->
See [examples/batch_compute_environment](../../examples/batch_compute_environment).
<!-- END_TF_DOCS -->
