locals {
  platform_type     = "multi-apps"
  current_timestamp = timestamp()
  default_tags = {
    Platform_Type = local.platform_type
    Platform      = "Amplify Infrastructure Management Platform"
  }
  build_spec = fileexists("${path.root}/build.yaml") ? "${path.root}/build.yaml" : "${path.module}/build.yaml"
  branch_config = {
    for key, value in var.branch_config : key => value if value.enabled == true
  }
  branch_secrets = flatten(values({
    for key, value in local.branch_config : key => [
      for secret in value.secrets :
      {
        name  = "/amplify/shared/${aws_amplify_app.this[key].id}/${secret}"
        value = secret
      }
    ]
  }))
  secrets = { for secret in local.branch_secrets : secret.name => secret.value }
}
