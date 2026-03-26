# SNS Topic Module

Creates AWS SNS topics with subscriptions and delivery policies.

<!-- BEGIN_TF_DOCS -->

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.35.1 |
## Resources

| Name | Type |
|------|------|
| [aws_sns_topic.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_policy.allow_publish_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_policy) | resource |
| [aws_sns_topic_subscription.trigger_topic_emails](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_iam_policy_document.allow_events_publish](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_notification_email_addresses"></a> [notification\_email\_addresses](#input\_notification\_email\_addresses) | The list of email address that subscribes the SNS topic to receive notification | `list(string)` | `[]` | no |
| <a name="input_sns_topic_policy"></a> [sns\_topic\_policy](#input\_sns\_topic\_policy) | The SNS topic policy for allowing particular actions on topic | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The key value pairs we want to apply as tags to the resources contained in this module | `map(string)` | `{}` | no |
| <a name="input_topic_name"></a> [topic\_name](#input\_topic\_name) | The name of the topic | `string` | n/a | yes |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sns_topic_arn"></a> [sns\_topic\_arn](#output\_sns\_topic\_arn) | ARN of the SNS topic |
<!-- END_TF_DOCS -->
## Examples
See [examples/sns_topic](../../examples/sns_topic)
