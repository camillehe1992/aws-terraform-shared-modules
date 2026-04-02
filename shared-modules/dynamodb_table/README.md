# DynamoDB Table Module

Creates AWS DynamoDB tables with optional global secondary indexes.

<!-- BEGIN_TF_DOCS -->

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.39.0 |
## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_mode"></a> [billing\_mode](#input\_billing\_mode) | The billing mode of the DynamoDB table | `string` | `"PAY_PER_REQUEST"` | no |
| <a name="input_deletion_protection_enabled"></a> [deletion\_protection\_enabled](#input\_deletion\_protection\_enabled) | Whether deletion protection is enabled for the DynamoDB table | `bool` | `false` | no |
| <a name="input_global_secondary_indexes"></a> [global\_secondary\_indexes](#input\_global\_secondary\_indexes) | The global secondary indexes of the DynamoDB table | <pre>list(object({<br/>    name = string<br/>    key_schema = list(object({<br/>      attribute_name = string<br/>      attribute_type = string<br/>      key_type       = string<br/>    }))<br/>    read_capacity      = optional(number, 1)<br/>    write_capacity     = optional(number, 1)<br/>    non_key_attributes = optional(list(string), [])<br/>    projection_type    = optional(string, "INCLUDE")<br/>  }))</pre> | `[]` | no |
| <a name="input_hash_key"></a> [hash\_key](#input\_hash\_key) | The hash key of the DynamoDB table | `string` | n/a | yes |
| <a name="input_point_in_time_recovery"></a> [point\_in\_time\_recovery](#input\_point\_in\_time\_recovery) | Whether point-in-time recovery is enabled for the DynamoDB table | `bool` | `false` | no |
| <a name="input_range_key"></a> [range\_key](#input\_range\_key) | The range key of the DynamoDB table | `string` | `null` | no |
| <a name="input_read_capacity"></a> [read\_capacity](#input\_read\_capacity) | The read capacity units of the DynamoDB table | `number` | `1` | no |
| <a name="input_recovery_period_in_days"></a> [recovery\_period\_in\_days](#input\_recovery\_period\_in\_days) | The recovery period in days of the point-in-time recovery | `number` | `7` | no |
| <a name="input_stream_enabled"></a> [stream\_enabled](#input\_stream\_enabled) | Whether DynamoDB Streams is enabled for the DynamoDB table | `bool` | `false` | no |
| <a name="input_stream_view_type"></a> [stream\_view\_type](#input\_stream\_view\_type) | The view type of the DynamoDB Streams | `string` | `null` | no |
| <a name="input_table_description"></a> [table\_description](#input\_table\_description) | The description of the DynamoDB table | `string` | n/a | yes |
| <a name="input_table_name"></a> [table\_name](#input\_table\_name) | The name of the DynamoDB table | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | The key value pairs apply as tags to all resources in the module | `map(string)` | `{}` | no |
| <a name="input_ttl_attribute_name"></a> [ttl\_attribute\_name](#input\_ttl\_attribute\_name) | The attribute name of the TTL attribute | `string` | `null` | no |
| <a name="input_ttl_enabled"></a> [ttl\_enabled](#input\_ttl\_enabled) | Whether TTL is enabled for the DynamoDB table | `bool` | `false` | no |
| <a name="input_write_capacity"></a> [write\_capacity](#input\_write\_capacity) | The write capacity of the DynamoDB table | `number` | `1` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_table_arn"></a> [table\_arn](#output\_table\_arn) | The ARN of the DynamoDB table |
| <a name="output_table_id"></a> [table\_id](#output\_table\_id) | The ID of the DynamoDB table |
| <a name="output_table_name"></a> [table\_name](#output\_table\_name) | The name of the DynamoDB table |
| <a name="output_table_stream_arn"></a> [table\_stream\_arn](#output\_table\_stream\_arn) | The ARN of the DynamoDB table stream |
<!-- END_TF_DOCS -->
## Examples
See [examples/dynamodb_table](../../examples/dynamodb_table)
