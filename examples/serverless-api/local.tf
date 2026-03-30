data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

locals {
  region     = data.aws_region.current.id
  account_id = data.aws_caller_identity.current.account_id
  tags = {
    Example = "serverless-api"
  }
  # Lambda Function
  function_name = "hello-world"
  description   = "An example lambda function"
  handler       = "index.lambda_handler"
  runtime       = "python3.13"
  source_dir    = "./function/src/"
  output_path   = "./.build/function.zip"
  environment_variables = {
    ENVIRONMENT             = "dev"
    POWERTOOLS_SERVICE_NAME = "hello-world"
    POWERTOOLS_LOG_LEVEL    = "INFO"
    POWERTOOLS_DEBUG        = "true"
  }
  # https://docs.aws.amazon.com/powertools/python/latest/includes/_layer_homepage_arm64/#python-313
  # Use the official layer ARN
  lambda_layers = [
    "arn:aws:lambda:ap-southeast-1:017000801446:layer:AWSLambdaPowertoolsPythonV3-python313-arm64:30"
  ]
  # API Gateway
  api_name   = "hello-world-openapi-api"
  stage_name = "dev"
}
