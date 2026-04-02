locals {
  common_tags = merge(var.tags, {
    Module = "lambda_function"
  })
}

# Archive the source code
data "archive_file" "this" {
  type        = "zip"
  source_file = var.source_file
  source_dir  = var.source_dir
  output_path = var.output_path

  # Exclude specific folders
  excludes = [
    "__pycache__",
    ".pytest_cache",
    "tests",
    "test_*.py",
    "*.pyc",
    "*.pyo",
    ".env",
    "venv",
    "env",
    "node_modules",
    ".git",
    ".DS_Store"
  ]
}

# Lambda function
resource "aws_lambda_function" "this" {
  function_name    = var.function_name
  description      = var.description
  role             = var.role_arn
  handler          = var.handler
  memory_size      = var.memory_size
  runtime          = var.runtime
  timeout          = var.timeout
  filename         = data.archive_file.this.output_path
  source_code_hash = data.archive_file.this.output_base64sha256
  layers           = var.layers
  architectures    = var.architectures

  dynamic "environment" {
    for_each = length(var.environment_variables) > 0 ? [1] : []
    content {
      variables = var.environment_variables
    }
  }

  vpc_config {
    ipv6_allowed_for_dual_stack = var.ipv6_allowed_for_dual_stack
    subnet_ids                  = var.subnet_ids
    security_group_ids          = var.security_group_ids
  }

  tracing_config {
    mode = "Active" # Enable X-Ray tracing
  }

  tags = local.common_tags
}

# Lambda Permission
resource "aws_lambda_permission" "this" {
  for_each = var.lambda_permissions

  statement_id  = each.key
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = each.value.principal
  source_arn    = each.value.source_arn
}

# Lambda function cloudwatch logs gorup
resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = var.retention_in_days
  tags              = local.common_tags
}
