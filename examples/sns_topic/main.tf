# Example Modules
module "events_sns_topic" {
  source = "../../shared-modules/sns_topic"

  topic_name                   = "events-alert"
  notification_email_addresses = ["camille.he@outlook.com"]
}

output "sns_topic_arn" {
  description = "ARN of the SNS topic"
  value       = module.events_sns_topic.sns_topic_arn
}

# SNS trigger by lambda function
data "aws_iam_policy_document" "lambda_sns_topic_policy" {
  statement {
    effect  = "Allow"
    actions = ["SNS:Publish"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    resources = ["*"]
  }
}

module "lambda_sns_topic" {
  source = "../../shared-modules/sns_topic"

  topic_name                   = "s3-alert"
  notification_email_addresses = ["camille.he@outlook.com"]
  sns_topic_policy             = data.aws_iam_policy_document.lambda_sns_topic_policy.json
}

output "lambda_sns_topic_arn" {
  value = module.lambda_sns_topic.sns_topic_arn
}
