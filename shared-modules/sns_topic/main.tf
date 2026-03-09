data "aws_iam_policy_document" "allow_events_publish" {
  statement {
    effect  = "Allow"
    actions = ["SNS:Publish"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    resources = ["*"]
  }
}

resource "aws_sns_topic" "this" {
  name = var.topic_name
  # kms_master_key_id = aws_kms_key.sns_key.id
  delivery_policy = <<EOF
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "minDelayTarget": 20,
      "maxDelayTarget": 20,
      "numRetries": 3,
      "numMaxDelayRetries": 0,
      "numNoDelayRetries": 0,
      "numMinDelayRetries": 0,
      "backoffFunction": "linear"
    },
    "disableSubscriptionOverrides": false,
    "defaultThrottlePolicy": {
      "maxReceivesPerSecond": 1
    }
  }
}
EOF
  tags            = var.tags
}

resource "aws_sns_topic_policy" "allow_publish_policy" {
  arn    = aws_sns_topic.this.arn
  policy = coalesce(var.sns_topic_policy, data.aws_iam_policy_document.allow_events_publish.json)
}

resource "aws_sns_topic_subscription" "trigger_topic_emails" {
  for_each = toset(var.notification_email_addresses)

  topic_arn = aws_sns_topic.this.arn
  protocol  = "email"
  endpoint  = each.key
}
