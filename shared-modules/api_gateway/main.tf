data "aws_iam_policy_document" "default" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions   = ["execute-api:Invoke"]
    resources = ["${aws_api_gateway_rest_api.this.execution_arn}/*"]

    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"
      values   = ["0.0.0.0/0"]
    }
  }
}

resource "aws_api_gateway_rest_api_policy" "default_policy" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  policy      = data.aws_iam_policy_document.default.json
}

# REST API from OpenAPI body
resource "aws_api_gateway_rest_api" "this" {
  name        = var.api_name
  description = var.description
  body        = var.openapi_file_content

  put_rest_api_mode = "merge"

  endpoint_configuration {
    types = var.endpoint_types
  }

  tags = var.tags
}

# Deploy the API
resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.this.body))
  }
  # Force new deployment when spec changes
  lifecycle {
    create_before_destroy = true
  }
}

# Stage for API Gateway
resource "aws_api_gateway_stage" "this" {
  deployment_id = aws_api_gateway_deployment.this.id
  rest_api_id   = aws_api_gateway_rest_api.this.id
  stage_name    = var.stage_name

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.this.arn
    format = jsonencode({
      "requestId"      = "$context.requestId",
      "ip"             = "$context.identity.sourceIp",
      "caller"         = "$context.identity.caller",
      "user"           = "$context.identity.user",
      "requestTime"    = "$context.requestTime",
      "httpMethod"     = "$context.httpMethod",
      "resourcePath"   = "$context.resourcePath",
      "status"         = "$context.status",
      "protocol"       = "$context.protocol",
      "responseLength" = "$context.responseLength"
    })
  }
}

# CloudWatch Log Group for API Gateway
resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/apigateway/${aws_api_gateway_rest_api.this.id}/${var.stage_name}"
  retention_in_days = var.retention_in_days

  tags = var.tags
}
