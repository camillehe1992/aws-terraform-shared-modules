# API Gateway that invokes the Lambda Function
module "api_gateway" {
  source = "../../shared-modules/api_gateway"

  api_name   = local.api_name
  stage_name = local.stage_name

  openapi_file_content = templatefile("${path.cwd}/openapi.yaml", {
    lambda_invoke_arn = module.lambda_function.invoke_arn
  })

  tags = merge(local.tags, {
    Shared-Module = "api_gateway"
  })
}

output "api_invoke_url" {
  value = module.api_gateway.invoke_url
}

output "api_cw_log_group_arn" {
  value = module.api_gateway.cw_log_group_arn
}
