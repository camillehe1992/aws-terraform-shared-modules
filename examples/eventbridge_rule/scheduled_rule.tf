# Trigger the log group at 1 AM UTC every day
module "scheduled_rule" {
  source = "../../shared-modules/eventbridge_rule"

  rule_name        = "scheduled-trigger-cw-log-group"
  rule_description = "Trigger a CloudWatch Log Group as scheduled"
  # trigger the log group at 1 AM UTC every day
  schedule_expression = "cron(0 1 * * ? *)"
  input_transformer_specs = {
    input_template = <<EOF
{
  "message": "Scheduled message"
}
EOF
  }
  target_arn = aws_cloudwatch_log_group.this.arn
}

resource "aws_cloudwatch_log_group" "this" {
  name = "terraform-example-log-group"
}

output "scheduled_rule" {
  value = module.scheduled_rule.event_rule_arn
}
