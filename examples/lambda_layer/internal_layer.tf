# The example of Lambda layer with user defined logging dependencies
# The layer source code is defined in ./lambda_layer folder.
# Wwe extract some common functionalities or utils from Lambda function into layer,
# and make them as a separate module, then it can be used in multiple Lambda functions.

module "internal_lambda_layer" {
  source = "../../shared-modules/lambda_layer"

  layer_name               = "internal-logging-layer"
  description              = "Lambda layer for Python 3.12"
  source_dir               = "./lambda_layer"
  output_path              = "${local.temp_dir}/lambda_layer.zip"
  compatible_runtimes      = ["python3.12", "python3.13"]
  compatible_architectures = ["arm64"]
}

output "internal_lambda_layer" {
  description = "The ARN of the Lambda layer"
  value       = module.internal_lambda_layer.layer_arn
}
