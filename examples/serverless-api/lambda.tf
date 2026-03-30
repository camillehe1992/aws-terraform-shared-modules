# Lambda Function
module "lambda_function" {
  source = "../../shared-modules/lambda_function"

  function_name = local.function_name
  description   = local.description
  role_arn      = module.lambda_execution_role.role_arn
  handler       = local.handler
  runtime       = local.runtime

  # Lambda Layers
  layers = local.lambda_layers

  # Packaging
  source_dir  = local.source_dir
  output_path = local.output_path
  # Environment Variables
  environment_variables = local.environment_variables

  lambda_permissions = {
    allow_api_gateway = {
      principal  = "apigateway.amazonaws.com"
      source_arn = "arn:aws:execute-api:${local.region}:${local.account_id}:*/*/*/*"
    }
  }

  tags = merge(local.tags, {
    Shared-Module = "lambda_function"
  })
}

output "lambda_function_arn" {
  value = module.lambda_function.function_arn
}

output "lambda_function_cw_log_group_arn" {
  value = module.lambda_function.log_group_arn
}
