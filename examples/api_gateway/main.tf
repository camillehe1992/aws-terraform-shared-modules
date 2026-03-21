data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

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

module "lambda_function" {
  source        = "../../shared-modules/lambda_function"
  function_name = "example-hello"
  description   = "Lambda for Swagger API"
  role_arn      = module.lambda_role.role_arn
  handler       = "index.handler"
  runtime       = "python3.11"
  source_file   = "${path.module}/index.py"
  output_path   = "${path.module}/function.zip"
  lambda_permissions = {
    allow_api_gateway = {
      principal  = "apigateway.amazonaws.com"
      source_arn = "arn:aws:execute-api:${data.aws_region.current.id}:${data.aws_caller_identity.current.account_id}:*/*/*/*"
    }
  }
}

module "api_gateway" {
  source   = "../../shared-modules/api_gateway"
  api_name = "example-openapi-api"
  openapi_file_content = templatefile("${path.cwd}/openapi.yaml", {
    lambda_invoke_arn = module.lambda_function.invoke_arn
  })
  stage_name = "dev"
  tags       = { Environment = "Example" }
}

output "api_invoke_url" {
  value = module.api_gateway.invoke_url
}
