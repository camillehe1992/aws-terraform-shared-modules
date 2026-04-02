locals {
  common_tags = merge(var.tags, {
    Module = "eventbridge_rule"
  })
}

resource "aws_cloudwatch_event_rule" "event_rule" {
  name                = var.rule_name
  description         = var.rule_description
  schedule_expression = var.schedule_expression
  event_pattern       = var.event_pattern
  event_bus_name      = var.event_bus_name
  state               = var.is_enabled ? "ENABLED" : "DISABLED"

  tags = local.common_tags
}

resource "aws_cloudwatch_event_target" "event_target" {
  rule      = aws_cloudwatch_event_rule.event_rule.name
  target_id = var.target_id
  role_arn  = var.role_arn
  arn       = var.target_arn
  input     = var.input_transformer_specs == null ? var.rule_input : null

  dynamic "batch_target" {
    for_each = var.batch_target_specs != null ? [1] : []
    content {
      job_definition = var.batch_target_specs.job_definition
      job_name       = var.batch_target_specs.job_name
      array_size     = var.batch_target_specs.array_size
      job_attempts   = var.batch_target_specs.job_attempts
    }
  }
  ## more targets can be added here if needed
  dynamic "sqs_target" {
    for_each = var.sqs_target_specs != null ? [1] : []
    content {
      message_group_id = var.sqs_target_specs.message_group_id
    }
  }

  dynamic "input_transformer" {
    for_each = var.input_transformer_specs != null ? [1] : []
    content {
      input_paths    = var.input_transformer_specs.input_paths
      input_template = var.input_transformer_specs.input_template
    }
  }
}
