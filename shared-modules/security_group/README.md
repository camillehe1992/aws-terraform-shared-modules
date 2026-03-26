# Security Group Module

Creates AWS Security Groups with flexible ingress and egress rules. Supports CIDR blocks, IPv6, prefix lists, and referenced security groups.

<!-- BEGIN_TF_DOCS -->

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.36.0 |
## Resources

| Name | Type |
|------|------|
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_security_group_egress_rule.allow_cidr_ipv4](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_egress_rule.allow_cidr_ipv6](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.allow_cidr_ipv4](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.allow_cidr_ipv6](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.allow_prefix_lists](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.allow_referenced_sgs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | The description of SG | `string` | `"Managed by Terraform"` | no |
| <a name="input_egress_cidrs"></a> [egress\_cidrs](#input\_egress\_cidrs) | A set of CIDR for egress, default to allow all outbound traffic | <pre>set(object({<br/>    description = string<br/>    cidr_ipv4   = optional(string)<br/>    cidr_ipv6   = optional(string)<br/>    from_port   = optional(number)<br/>    to_port     = optional(number)<br/>    ip_protocol = optional(string)<br/>  }))</pre> | <pre>[<br/>  {<br/>    "cidr_ipv4": "0.0.0.0/0",<br/>    "description": "Allow all outbound IPv4 traffic",<br/>    "from_port": null,<br/>    "ip_protocol": "-1",<br/>    "to_port": null<br/>  },<br/>  {<br/>    "cidr_ipv6": "::/0",<br/>    "description": "Allow all outbound IPv6 traffic",<br/>    "from_port": null,<br/>    "ip_protocol": "-1",<br/>    "to_port": null<br/>  }<br/>]</pre> | no |
| <a name="input_egress_referenced_sg_ids"></a> [egress\_referenced\_sg\_ids](#input\_egress\_referenced\_sg\_ids) | A set of referenced SG ids for egress | `set(string)` | `[]` | no |
| <a name="input_ingress_cidrs"></a> [ingress\_cidrs](#input\_ingress\_cidrs) | A set of CIDR for ingress | <pre>set(object({<br/>    description = string<br/>    cidr_ipv4   = optional(string)<br/>    cidr_ipv6   = optional(string)<br/>    from_port   = optional(number)<br/>    to_port     = optional(number)<br/>    ip_protocol = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_ingress_prefix_lists"></a> [ingress\_prefix\_lists](#input\_ingress\_prefix\_lists) | A set of prefix list for ingress | `set(string)` | `[]` | no |
| <a name="input_ingress_referenced_sgs"></a> [ingress\_referenced\_sgs](#input\_ingress\_referenced\_sgs) | Map of referenced security groups with port information | <pre>map(object({<br/>    security_group_id = string<br/>    from_port         = number<br/>    to_port           = number<br/>    protocol          = string<br/>    description       = string<br/>  }))</pre> | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of SG | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | The key value pairs we want to apply as tags to the resources contained in this module | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC ID where the SG is created | `string` | n/a | yes |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security_group_arn"></a> [security\_group\_arn](#output\_security\_group\_arn) | ARN of the security group |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | ID of the security group |
<!-- END_TF_DOCS -->
## Examples
See [examples/security_group](../../examples/security_group)
