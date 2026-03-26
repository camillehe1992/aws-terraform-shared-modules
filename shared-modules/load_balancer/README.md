# Load Balancer Module

Creates AWS Application Load Balancers (ALB) and Network Load Balancers (NLB) with target groups, listeners, and routing rules.

<!-- BEGIN_TF_DOCS -->

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
## Resources

| Name | Type |
|------|------|
| [aws_lb.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_lb_target_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_logs"></a> [access\_logs](#input\_access\_logs) | Access logs configuration | <pre>object({<br/>    bucket  = string<br/>    prefix  = optional(string)<br/>    enabled = optional(bool, true)<br/>  })</pre> | `null` | no |
| <a name="input_enable_cross_zone_load_balancing"></a> [enable\_cross\_zone\_load\_balancing](#input\_enable\_cross\_zone\_load\_balancing) | Enable cross-zone load balancing | `bool` | `true` | no |
| <a name="input_enable_deletion_protection"></a> [enable\_deletion\_protection](#input\_enable\_deletion\_protection) | Enable deletion protection for the load balancer | `bool` | `false` | no |
| <a name="input_enable_http2"></a> [enable\_http2](#input\_enable\_http2) | Enable HTTP/2 support (ALB only) | `bool` | `true` | no |
| <a name="input_internal"></a> [internal](#input\_internal) | Whether the load balancer is internal (true) or internet-facing (false) | `bool` | `false` | no |
| <a name="input_listener_rules"></a> [listener\_rules](#input\_listener\_rules) | Configuration for listener rules | <pre>list(object({<br/>    listener_index = number<br/>    priority       = number<br/>    actions = list(object({<br/>      type              = string<br/>      target_group_name = optional(string)<br/>      redirect = optional(object({<br/>        port        = optional(string)<br/>        protocol    = optional(string)<br/>        status_code = optional(string, "HTTP_301")<br/>      }))<br/>      fixed_response = optional(object({<br/>        content_type = optional(string, "text/plain")<br/>        message_body = optional(string)<br/>        status_code  = optional(string, "200")<br/>      }))<br/>    }))<br/>    conditions = list(object({<br/>      path_pattern = optional(object({<br/>        values = list(string)<br/>      }))<br/>      host_header = optional(object({<br/>        values = list(string)<br/>      }))<br/>      http_header = optional(object({<br/>        http_header_name = string<br/>        values           = list(string)<br/>      }))<br/>      http_request_method = optional(object({<br/>        values = list(string)<br/>      }))<br/>      query_string = optional(list(object({<br/>        key   = optional(string)<br/>        value = string<br/>      })))<br/>      source_ip = optional(object({<br/>        values = list(string)<br/>      }))<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_listeners"></a> [listeners](#input\_listeners) | Configuration for listeners | <pre>list(object({<br/>    port            = number<br/>    protocol        = string<br/>    ssl_policy      = optional(string)<br/>    certificate_arn = optional(string)<br/>    default_action = object({<br/>      type              = string<br/>      target_group_name = optional(string)<br/>      redirect = optional(object({<br/>        port        = optional(string)<br/>        protocol    = optional(string)<br/>        status_code = optional(string, "HTTP_301")<br/>      }))<br/>      fixed_response = optional(object({<br/>        content_type = optional(string, "text/plain")<br/>        message_body = optional(string)<br/>        status_code  = optional(string, "200")<br/>      }))<br/>    })<br/>  }))</pre> | n/a | yes |
| <a name="input_load_balancer_type"></a> [load\_balancer\_type](#input\_load\_balancer\_type) | Type of load balancer: application, network, or gateway | `string` | `"application"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the load balancer | `string` | n/a | yes |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | List of security group IDs for the load balancer | `list(string)` | n/a | yes |
| <a name="input_subnet_mappings"></a> [subnet\_mappings](#input\_subnet\_mappings) | Subnet mappings for NLB with Elastic IPs | <pre>list(object({<br/>    subnet_id            = string<br/>    allocation_id        = optional(string)<br/>    private_ipv4_address = optional(string)<br/>    ipv6_address         = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | List of subnet IDs for the load balancer | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources | `map(string)` | `{}` | no |
| <a name="input_target_groups"></a> [target\_groups](#input\_target\_groups) | Configuration for target groups | <pre>list(object({<br/>    name        = string<br/>    port        = number<br/>    protocol    = string<br/>    target_type = optional(string, "ip")<br/>    health_check = optional(object({<br/>      enabled             = optional(bool, true)<br/>      healthy_threshold   = optional(number, 2)<br/>      unhealthy_threshold = optional(number, 2)<br/>      timeout             = optional(number, 5)<br/>      interval            = optional(number, 30)<br/>      path                = optional(string, "/")<br/>      port                = optional(string, "traffic-port")<br/>      protocol            = optional(string, "HTTP")<br/>      matcher             = optional(string, "200")<br/>    }))<br/>    stickiness = optional(object({<br/>      type            = optional(string, "lb_cookie")<br/>      cookie_duration = optional(number, 86400)<br/>      enabled         = optional(bool, false)<br/>    }))<br/>    deregistration_delay = optional(number, 300)<br/>  }))</pre> | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID where the load balancer will be created | `string` | n/a | yes |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_listener_arns"></a> [listener\_arns](#output\_listener\_arns) | ARNs of the listeners |
| <a name="output_listener_rule_arns"></a> [listener\_rule\_arns](#output\_listener\_rule\_arns) | ARNs of the listener rules |
| <a name="output_load_balancer_arn"></a> [load\_balancer\_arn](#output\_load\_balancer\_arn) | ARN of the load balancer |
| <a name="output_load_balancer_dns_name"></a> [load\_balancer\_dns\_name](#output\_load\_balancer\_dns\_name) | DNS name of the load balancer |
| <a name="output_load_balancer_type"></a> [load\_balancer\_type](#output\_load\_balancer\_type) | Type of the load balancer |
| <a name="output_load_balancer_zone_id"></a> [load\_balancer\_zone\_id](#output\_load\_balancer\_zone\_id) | Zone ID of the load balancer |
| <a name="output_target_group_arn_suffixes"></a> [target\_group\_arn\_suffixes](#output\_target\_group\_arn\_suffixes) | ARN suffixes of the target groups |
| <a name="output_target_group_arns"></a> [target\_group\_arns](#output\_target\_group\_arns) | ARNs of the target groups |
| <a name="output_target_group_names"></a> [target\_group\_names](#output\_target\_group\_names) | Names of the target groups |
| <a name="output_target_groups"></a> [target\_groups](#output\_target\_groups) | Target groups of the load balancer |

## Examples
<!-- terraform-docs gets the path; we strip it manually -->
See [examples/REPLACE_ME](../../examples/REPLACE_ME).
<!-- END_TF_DOCS -->
## Examples
See [examples/load_balancer](../../examples/load_balancer)
