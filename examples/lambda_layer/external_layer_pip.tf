# The example of Lambda layer with external dependencies via pip
# External means the dependencies are defined in requirements.txt file.
# We need to install them manually, then add them into layer source code.

# This minimal requirements.txt installs the python package - requests (a popular HTTP library) into the layer.
# Install dependencies via pip
resource "null_resource" "pip_install" {
  triggers = {
    always_run = true
  }
  provisioner "local-exec" {
    working_dir = path.cwd
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
      pip install -r requirements.txt --platform ${local.platform} --only-binary=:all: -t ${local.temp_dir}/pip_depedencies/python
    EOT
  }
}

module "external_lambda_layer_pip" {
  depends_on = [null_resource.pip_install]
  source     = "../../shared-modules/lambda_layer"

  layer_name               = "external-http-layer"
  description              = "Lambda layer for Python 3.12 with requests library"
  source_dir               = "${local.temp_dir}/pip_depedencies"
  output_path              = "${local.temp_dir}/pip_depedencies.zip"
  compatible_runtimes      = ["python3.12", "python3.13"]
  compatible_architectures = ["arm64"]
}

output "external_lambda_layer_pip" {
  description = "The ARN of the Lambda layer"
  value       = module.external_lambda_layer_pip.layer_arn
}
