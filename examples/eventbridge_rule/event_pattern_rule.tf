# Trigger the log group when a new message is published to SNS topic
module "event_pattern_rule" {
  source = "../../shared-modules/eventbridge_rule"

  rule_name        = "event-pattern-trigger-cw-log-group"
  rule_description = "Trigger a CloudWatch Log Group as event pattern"
  event_pattern = jsonencode({
    source      = ["aws.sns"]
    detail-type = ["SNS Notification"]
    resources   = ["*"]
  })
  # trigger the log group when a new message is published to the log group
  input_transformer_specs = {
    input_paths = {
      message = "$.detail.message"
    }
    input_template = <<EOF
{
  "message": <message>
}
EOF
  }
  target_arn = aws_cloudwatch_log_group.this.arn
}

output "event_pattern_rule_arn" {
  value = module.event_pattern_rule.event_rule_arn
}
