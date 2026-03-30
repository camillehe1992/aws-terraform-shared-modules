# IAM Role for Lambda Function
module "lambda_execution_role" {
  source    = "../../shared-modules/iam_role"
  role_name = "lambda-execution-role"

  principals = {
    "Service" = {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }

  aws_managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  ]

  tags = merge(local.tags, {
    Shared-Module = "iam_role"
  })
}

output "lambda_execution_role_arn" {
  value = module.lambda_execution_role.role_arn
}
