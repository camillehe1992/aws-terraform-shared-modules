# Outputs
output "invoke_url" {
  description = "The invoke URL for the API Gateway stage"
  value       = aws_api_gateway_stage.this.invoke_url
}
output "rest_api_id" {
  description = "The ID of the API Gateway REST API"
  value       = aws_api_gateway_rest_api.this.id
}
output "execution_arn" {
  description = "The ARN of the API Gateway execution"
  value       = aws_api_gateway_rest_api.this.execution_arn
}

output "cw_log_group_arn" {
  description = "The ARN of the CloudWatch Log Group for API Gateway"
  value       = aws_cloudwatch_log_group.this.arn
}
