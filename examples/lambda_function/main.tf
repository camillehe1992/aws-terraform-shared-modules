# IAM Role for Lambda
module "lambda_role" {
  source    = "../../shared-modules/iam_role"
  role_name = "example-lambda-role"

  principals = {
    "Service" = {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }

  aws_managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  ]
}

# Lambda Function
module "lambda_function" {
  source = "../../shared-modules/lambda_function"

  function_name = "example-hello-world"
  description   = "An example lambda function"
  role_arn      = module.lambda_role.role_arn
  handler       = "index.handler"
  runtime       = "python3.12"

  # Packaging
  source_file = "${path.module}/index.py"
  output_path = "${path.module}/function.zip"

  environment_variables = {
    ENV = "example"
  }

  tags = {
    Environment = "Example"
  }
}

output "lambda_function_arn" {
  value = module.lambda_function.function_arn
}
