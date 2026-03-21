# The example of Lambda layer with external dependencies via npm
# External means the dependencies are defined in nodejs/package.json file.
# We need to install them manually, then add them into layer source code.

# In this example, we install the axios and lodash libraries into the layer.

resource "null_resource" "npm_install" {
  triggers = {
    always_run = true
  }
  provisioner "local-exec" {
    working_dir = path.cwd
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
      cd nodejs && npm install
    EOT
  }
}

module "external_lambda_layer_npm" {
  depends_on = [null_resource.npm_install]
  source     = "../../shared-modules/lambda_layer"

  layer_name               = "external-nodejs-layer"
  description              = "Lambda layer for Node.js 20.x with axios and lodash libraries"
  source_dir               = "nodejs"
  output_path              = "${local.temp_dir}/nodejs.zip"
  compatible_runtimes      = ["nodejs20.x", "nodejs22.x"]
  compatible_architectures = ["arm64"]
}

output "external_lambda_layer_npm" {
  description = "The ARN of the Lambda layer"
  value       = module.external_lambda_layer_npm.layer_arn
}
