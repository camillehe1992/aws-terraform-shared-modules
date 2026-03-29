# ECS Cluster Module

Creates AWS ECS clusters for container orchestration.

<!-- BEGIN_TF_DOCS -->

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.37.0 |
## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_ecs_capacity_provider.auto_scaling_group_provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_capacity_provider) | resource |
| [aws_ecs_capacity_provider.managed_instances_provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_capacity_provider) | resource |
| [aws_ecs_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_ecs_cluster_capacity_providers.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster_capacity_providers) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_scaling_group_provider"></a> [auto\_scaling\_group\_provider](#input\_auto\_scaling\_group\_provider) | Auto scaling group provider | <pre>object({<br/>    auto_scaling_group_arn         = string<br/>    managed_termination_protection = optional(string, "ENABLED")<br/>    managed_draining               = optional(string, "ENABLED")<br/>    instance_warmup_period         = optional(number, 300)<br/>    maximum_scaling_step_size      = optional(number, 100)<br/>    minimum_scaling_step_size      = optional(number, 1)<br/>    status                         = optional(string, "ENABLED")<br/>    target_capacity                = optional(number, 10)<br/>  })</pre> | `null` | no |
| <a name="input_capacity_providers"></a> [capacity\_providers](#input\_capacity\_providers) | List of capacity providers (usually FARGATE or FARGATE\_SPOT) | `list(string)` | `[]` | no |
| <a name="input_container_insights"></a> [container\_insights](#input\_container\_insights) | Enable CloudWatch Container Insights | `bool` | `false` | no |
| <a name="input_default_capacity_provider_strategy"></a> [default\_capacity\_provider\_strategy](#input\_default\_capacity\_provider\_strategy) | Default strategy for the cluster | <pre>list(object({<br/>    capacity_provider = string<br/>    weight            = number<br/>    base              = number<br/>  }))</pre> | `[]` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | KMS key ID for encrypting cluster resources | `string` | `null` | no |
| <a name="input_log_configuration"></a> [log\_configuration](#input\_log\_configuration) | Log configuration for the cluster | <pre>object({<br/>    enabled                      = bool<br/>    s3_bucket_name               = string<br/>    s3_bucket_encryption_enabled = bool<br/>    s3_key_prefix                = string<br/>  })</pre> | <pre>{<br/>  "enabled": true,<br/>  "s3_bucket_encryption_enabled": false,<br/>  "s3_bucket_name": null,<br/>  "s3_key_prefix": ""<br/>}</pre> | no |
| <a name="input_managed_instances_provider"></a> [managed\_instances\_provider](#input\_managed\_instances\_provider) | Managed instances provider | <pre>object({<br/>    infrastructure_role_arn = string<br/>    instance_launch_template = object({<br/>      ec2_instance_profile_arn = string<br/>      monitoring               = string<br/>      subnets                  = list(string)<br/>      security_groups          = list(string)<br/>      storage_size_gib         = number<br/>      min_meory_mib            = number<br/>      max_meory_mib            = number<br/>      min_vcpu_count           = number<br/>      max_vcpu_count           = number<br/>      instance_generations     = list(string)<br/>      cpu_manufacturers        = list(string)<br/>    })<br/>  })</pre> | `null` | no |
| <a name="input_managed_storage_configuration"></a> [managed\_storage\_configuration](#input\_managed\_storage\_configuration) | Managed storage configuration for the cluster | <pre>object({<br/>    enabled                              = bool<br/>    fargate_ephemeral_storage_kms_key_id = string<br/>    kms_key_id                           = string<br/>  })</pre> | <pre>{<br/>  "enabled": false,<br/>  "fargate_ephemeral_storage_kms_key_id": null,<br/>  "kms_key_id": null<br/>}</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | ECS cluster name | `string` | n/a | yes |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | Number of days to retain logs | `number` | `7` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply | `map(string)` | `{}` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_arn"></a> [cluster\_arn](#output\_cluster\_arn) | ARN of the ECS cluster |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | ID of the ECS cluster |
| <a name="output_cluster_log_group_name"></a> [cluster\_log\_group\_name](#output\_cluster\_log\_group\_name) | Name of the ECS cluster log group |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | Name of the ECS cluster |
<!-- END_TF_DOCS -->
## Examples
See [examples/ecs_cluster](../../examples/ecs_cluster)
