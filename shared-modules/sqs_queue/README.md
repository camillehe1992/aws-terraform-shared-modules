# SQS Queue Module

Creates AWS SQS queues/FIFO with optional DLQ configuration. Supports HTTPS-only traffic and least privilege access.

<!-- BEGIN_TF_DOCS -->

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.39.0 |
## Resources

| Name | Type |
|------|------|
| [aws_sqs_queue.dead_letter_queue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_policy) | resource |
| [aws_iam_policy_document.default_queue_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_content_based_deduplication"></a> [content\_based\_deduplication](#input\_content\_based\_deduplication) | Enables content-based deduplication for FIFO queues | `bool` | `false` | no |
| <a name="input_dead_letter_queue_enabled"></a> [dead\_letter\_queue\_enabled](#input\_dead\_letter\_queue\_enabled) | Enable dead letter queue | `bool` | `false` | no |
| <a name="input_delay_seconds"></a> [delay\_seconds](#input\_delay\_seconds) | The time in seconds that the delivery of all messages in the queue is delayed. An integer from 0 to 900 (15 minutes) | `number` | `0` | no |
| <a name="input_dlq_message_retention_seconds"></a> [dlq\_message\_retention\_seconds](#input\_dlq\_message\_retention\_seconds) | The number of seconds that Amazon SQS retains a message in the dead letter queue | `number` | `1209600` | no |
| <a name="input_encryption_enabled"></a> [encryption\_enabled](#input\_encryption\_enabled) | Enable server-side encryption (SSE) | `bool` | `true` | no |
| <a name="input_kms_data_key_reuse_period_seconds"></a> [kms\_data\_key\_reuse\_period\_seconds](#input\_kms\_data\_key\_reuse\_period\_seconds) | The length of time, in seconds, for which Amazon SQS can reuse a data key | `number` | `300` | no |
| <a name="input_kms_master_key_id"></a> [kms\_master\_key\_id](#input\_kms\_master\_key\_id) | The ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK | `string` | `"alias/aws/sqs"` | no |
| <a name="input_max_message_size"></a> [max\_message\_size](#input\_max\_message\_size) | The limit of how many bytes that a message can contain before Amazon SQS rejects it. An integer from 1024 bytes (1 KiB) to 262144 bytes (256 KiB) | `number` | `262144` | no |
| <a name="input_max_receive_count"></a> [max\_receive\_count](#input\_max\_receive\_count) | The number of times a message is delivered to the source queue before being moved to the dead-letter queue | `number` | `3` | no |
| <a name="input_message_retention_seconds"></a> [message\_retention\_seconds](#input\_message\_retention\_seconds) | The number of seconds that Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days) | `number` | `345600` | no |
| <a name="input_queue_name"></a> [queue\_name](#input\_queue\_name) | The name of the SQS queue | `string` | n/a | yes |
| <a name="input_queue_policy"></a> [queue\_policy](#input\_queue\_policy) | Custom JSON policy for the SQS queue. If empty, uses secure default policy with HTTPS-only traffic and least privilege | `string` | `""` | no |
| <a name="input_queue_policy_enabled"></a> [queue\_policy\_enabled](#input\_queue\_policy\_enabled) | Enable queue policy (uses secure default policy if custom policy not provided) | `bool` | `true` | no |
| <a name="input_queue_type"></a> [queue\_type](#input\_queue\_type) | Type of queue (STANDARD or FIFO) | `string` | `"STANDARD"` | no |
| <a name="input_receive_wait_time_seconds"></a> [receive\_wait\_time\_seconds](#input\_receive\_wait\_time\_seconds) | The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning. An integer from 0 to 20 (seconds) | `number` | `0` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resource | `map(string)` | `{}` | no |
| <a name="input_visibility_timeout_seconds"></a> [visibility\_timeout\_seconds](#input\_visibility\_timeout\_seconds) | The visibility timeout for the queue. An integer from 0 to 43200 (12 hours) | `number` | `30` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dead_letter_queue_arn"></a> [dead\_letter\_queue\_arn](#output\_dead\_letter\_queue\_arn) | The ARN of the dead letter queue |
| <a name="output_dead_letter_queue_enabled"></a> [dead\_letter\_queue\_enabled](#output\_dead\_letter\_queue\_enabled) | Whether dead letter queue is enabled |
| <a name="output_dead_letter_queue_name"></a> [dead\_letter\_queue\_name](#output\_dead\_letter\_queue\_name) | The name of the dead letter queue |
| <a name="output_dead_letter_queue_url"></a> [dead\_letter\_queue\_url](#output\_dead\_letter\_queue\_url) | The URL of the dead letter queue |
| <a name="output_encryption_enabled"></a> [encryption\_enabled](#output\_encryption\_enabled) | Whether encryption is enabled |
| <a name="output_fifo_queue"></a> [fifo\_queue](#output\_fifo\_queue) | Whether the queue is a FIFO queue |
| <a name="output_kms_master_key_id"></a> [kms\_master\_key\_id](#output\_kms\_master\_key\_id) | The ID of the KMS master key |
| <a name="output_queue_arn"></a> [queue\_arn](#output\_queue\_arn) | The ARN of the SQS queue |
| <a name="output_queue_id"></a> [queue\_id](#output\_queue\_id) | The ID of the SQS queue |
| <a name="output_queue_name"></a> [queue\_name](#output\_queue\_name) | The name of the SQS queue |
| <a name="output_queue_type"></a> [queue\_type](#output\_queue\_type) | The type of the queue (STANDARD or FIFO) |
| <a name="output_queue_url"></a> [queue\_url](#output\_queue\_url) | The URL of the SQS queue |
<!-- END_TF_DOCS -->
## Examples
See [examples/sqs_queue](../../examples/sqs_queue)
