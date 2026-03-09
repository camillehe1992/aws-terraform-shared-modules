# Example with default AWS managed policy AWSLambdaBasicExecutionRole attached

module "lambda_execution_role_arn" {
  source           = "../../shared-modules/iam_role"
  role_name        = "lambda-execution-role"
  role_description = "IAM role created by Terraform for demo Lambda execution"
  principals = {
    "Service" = {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
  aws_managed_policy_arns  = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]
  user_managed_policies    = {}
  has_iam_instance_profile = false
  tags                     = {}
}

output "lambda_execution_role_arn" {
  description = "The ARN of lambda execution role"
  value       = module.lambda_execution_role_arn.role_arn
}
