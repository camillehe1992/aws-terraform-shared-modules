# ECS Service Module

Creates AWS ECS services with integrated task definitions, supporting both Fargate and EC2 launch types.

<!-- BEGIN_TF_DOCS -->

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.38.0 |
## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_ecs_service.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assign_public_ip"></a> [assign\_public\_ip](#input\_assign\_public\_ip) | Assign public IP to tasks | `bool` | `false` | no |
| <a name="input_cluster_id"></a> [cluster\_id](#input\_cluster\_id) | ECS cluster ID where the service will be deployed | `string` | n/a | yes |
| <a name="input_containers"></a> [containers](#input\_containers) | Container definitions for the task | <pre>list(object({<br/>    name        = string<br/>    image       = string<br/>    cpu         = optional(number)<br/>    memory      = optional(number)<br/>    essential   = optional(bool, true)<br/>    environment = optional(map(string), {})<br/>    secrets = optional(list(object({<br/>      name       = string<br/>      value_from = string<br/>    })), [])<br/>    port_mappings = optional(list(object({<br/>      container_port = number<br/>      host_port      = optional(number)<br/>      protocol       = optional(string, "tcp")<br/>    })), [])<br/>    mount_points = optional(list(object({<br/>      source_volume  = string<br/>      container_path = string<br/>      read_only      = optional(bool, false)<br/>    })), [])<br/>    log_configuration = optional(object({<br/>      log_driver = optional(string, "awslogs")<br/>      options    = optional(map(string), {})<br/>      secret_options = optional(list(object({<br/>        name       = string<br/>        value_from = string<br/>      })), [])<br/>    }))<br/>    health_check = optional(object({<br/>      command      = list(string)<br/>      interval     = optional(number, 30)<br/>      timeout      = optional(number, 5)<br/>      retries      = optional(number, 3)<br/>      start_period = optional(number, 0)<br/>    }))<br/>    working_directory        = optional(string)<br/>    user                     = optional(string)<br/>    readonly_root_filesystem = optional(bool, false)<br/>    privileged               = optional(bool, false)<br/>    linux_parameters         = optional(any)<br/>  }))</pre> | n/a | yes |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | CPU units for the task | `string` | `"256"` | no |
| <a name="input_deployment_circuit_breaker"></a> [deployment\_circuit\_breaker](#input\_deployment\_circuit\_breaker) | Enable deployment circuit breaker for rollback on failure | `bool` | `false` | no |
| <a name="input_deployment_maximum_percent"></a> [deployment\_maximum\_percent](#input\_deployment\_maximum\_percent) | The upper limit (as a percentage of the desired count) of the number of running tasks that can be running in a service during a deployment | `number` | `200` | no |
| <a name="input_deployment_minimum_healthy_percent"></a> [deployment\_minimum\_healthy\_percent](#input\_deployment\_minimum\_healthy\_percent) | The lower limit (as a percentage of the desired count) of the number of running tasks that must be running in a service during a deployment | `number` | `100` | no |
| <a name="input_desired_count"></a> [desired\_count](#input\_desired\_count) | Number of instances of the task definition to run | `number` | `1` | no |
| <a name="input_enable_execute_command"></a> [enable\_execute\_command](#input\_enable\_execute\_command) | Enable ECS Exec for debugging | `bool` | `false` | no |
| <a name="input_execution_role_arn"></a> [execution\_role\_arn](#input\_execution\_role\_arn) | ARN of the task execution role | `string` | n/a | yes |
| <a name="input_family_name"></a> [family\_name](#input\_family\_name) | Family name for the task definition | `string` | n/a | yes |
| <a name="input_force_new_deployment"></a> [force\_new\_deployment](#input\_force\_new\_deployment) | Force a new deployment of the service | `bool` | `false` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | KMS key ID for encrypting CloudWatch Logs group | `string` | `null` | no |
| <a name="input_launch_type"></a> [launch\_type](#input\_launch\_type) | Launch type for the ECS service (EC2 or FARGATE) | `string` | `"FARGATE"` | no |
| <a name="input_load_balancers"></a> [load\_balancers](#input\_load\_balancers) | Load balancer configuration for the service | <pre>list(object({<br/>    target_group_arn = string<br/>    container_name   = string<br/>    container_port   = number<br/>  }))</pre> | `[]` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | Memory for the task | `string` | `"512"` | no |
| <a name="input_network_mode"></a> [network\_mode](#input\_network\_mode) | Network mode for the task definition | `string` | `"awsvpc"` | no |
| <a name="input_propagate_tags"></a> [propagate\_tags](#input\_propagate\_tags) | Propagate tags from the service to the tasks | `string` | `"SERVICE"` | no |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | Number of days to retain log events in the CloudWatch Logs group | `number` | `7` | no |
| <a name="input_runtime_platform"></a> [runtime\_platform](#input\_runtime\_platform) | Runtime platform configuration | <pre>object({<br/>    cpu_architecture        = optional(string, "X86_64")<br/>    operating_system_family = optional(string, "LINUX")<br/>  })</pre> | `null` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | Security groups for the service (required for awsvpc network mode) | `list(string)` | `[]` | no |
| <a name="input_service_discovery"></a> [service\_discovery](#input\_service\_discovery) | Service discovery configuration | <pre>object({<br/>    registry_arn   = string<br/>    port           = optional(number)<br/>    container_name = optional(string)<br/>    container_port = optional(number)<br/>  })</pre> | `null` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Name of the ECS service | `string` | n/a | yes |
| <a name="input_service_registries"></a> [service\_registries](#input\_service\_registries) | Service registries for the service | <pre>list(object({<br/>    registry_arn   = string<br/>    port           = optional(number)<br/>    container_name = optional(string)<br/>    container_port = optional(number)<br/>  }))</pre> | `[]` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Subnets for the service (required for awsvpc network mode) | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources | `map(string)` | `{}` | no |
| <a name="input_task_role_arn"></a> [task\_role\_arn](#input\_task\_role\_arn) | ARN of the task role | `string` | `null` | no |
| <a name="input_volumes"></a> [volumes](#input\_volumes) | Volume definitions for the task | <pre>list(object({<br/>    name = string<br/>    efs_volume_configuration = optional(object({<br/>      file_system_id          = string<br/>      root_directory          = optional(string, "/")<br/>      transit_encryption      = optional(string, "DISABLED")<br/>      transit_encryption_port = optional(number)<br/>      authorization_config = optional(object({<br/>        access_point_id = optional(string)<br/>        iam             = optional(string, "DISABLED")<br/>      }))<br/>    }))<br/>    docker_volume_configuration = optional(object({<br/>      scope         = optional(string, "task")<br/>      autoprovision = optional(bool, false)<br/>      driver        = optional(string, "local")<br/>      driver_opts   = optional(map(string), {})<br/>      labels        = optional(map(string), {})<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_wait_for_steady_state"></a> [wait\_for\_steady\_state](#input\_wait\_for\_steady\_state) | Wait for the service to reach a steady state | `bool` | `true` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_images"></a> [container\_images](#output\_container\_images) | Images used by the containers |
| <a name="output_container_names"></a> [container\_names](#output\_container\_names) | Names of the containers in the task definition |
| <a name="output_cpu"></a> [cpu](#output\_cpu) | CPU units for the task |
| <a name="output_execution_role_arn"></a> [execution\_role\_arn](#output\_execution\_role\_arn) | ARN of the task execution role |
| <a name="output_memory"></a> [memory](#output\_memory) | Memory for the task |
| <a name="output_network_mode"></a> [network\_mode](#output\_network\_mode) | Network mode of the task definition |
| <a name="output_service_arn"></a> [service\_arn](#output\_service\_arn) | ARN of the ECS service |
| <a name="output_service_id"></a> [service\_id](#output\_service\_id) | ID of the ECS service |
| <a name="output_service_name"></a> [service\_name](#output\_service\_name) | Name of the ECS service |
| <a name="output_task_definition_arn"></a> [task\_definition\_arn](#output\_task\_definition\_arn) | ARN of the task definition |
| <a name="output_task_definition_family"></a> [task\_definition\_family](#output\_task\_definition\_family) | Family of the task definition |
| <a name="output_task_definition_revision"></a> [task\_definition\_revision](#output\_task\_definition\_revision) | Revision of the task definition |
| <a name="output_task_role_arn"></a> [task\_role\_arn](#output\_task\_role\_arn) | ARN of the task role |
<!-- END_TF_DOCS -->
## Examples
See [examples/ecs_app](../../examples/ecs_app)
