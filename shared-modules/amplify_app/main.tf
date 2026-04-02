# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/amplify_app
resource "aws_amplify_app" "this" {
  for_each = local.branch_config

  name         = "${each.key}-${var.name_prefix}-${local.platform_type}"
  repository   = var.repository
  access_token = var.access_token
  build_spec   = file(local.build_spec)

  auto_branch_creation_config {
    enable_auto_build           = true
    enable_pull_request_preview = true
    framework                   = var.framework
  }

  # The default rewrites and redirects added by the Amplify Console.
  custom_rule {
    source = "/<*>"
    status = "404"
    target = "/index.html"
  }

  tags = merge(local.common_tags, var.tags)
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/amplify_branch
resource "aws_amplify_branch" "this" {
  for_each = local.branch_config

  app_id                      = aws_amplify_app.this[each.key].id
  branch_name                 = each.value.branch_name
  stage                       = each.value.environment == "production" ? "PRODUCTION" : "BETA"
  enable_auto_build           = each.value.enable_auto_build
  enable_pull_request_preview = each.value.enable_pull_request_preview
  environment_variables       = each.value.environment_variables
}

resource "aws_ssm_parameter" "secrets" {
  depends_on = [aws_amplify_app.this]
  for_each   = local.secrets

  type  = "SecureString"
  name  = each.key
  value = each.value

  tags = merge(local.common_tags, var.tags)
}
