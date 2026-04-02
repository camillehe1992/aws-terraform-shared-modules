locals {
  common_tags = merge(var.tags, {
    Module = "secretsmanager_secrets"
  })
}

data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

data "aws_iam_policy_document" "default_policy" {
  statement {
    sid    = "OnlyCurrentAccountCanReadTheSecret"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:root"]
    }

    actions = [
      "secretsmanager:GetSecretValue"
    ]
    resources = ["*"]
  }
}


resource "aws_secretsmanager_secret" "secrets" {
  for_each = var.secret_specs

  description             = each.value.description
  name                    = "${var.secret_prefix}${each.key}"
  recovery_window_in_days = var.recovery_window_in_days
  kms_key_id              = var.kms_key_id
  policy                  = coalesce(var.user_provided_policy, data.aws_iam_policy_document.default_policy.json)
  tags                    = local.common_tags
}

resource "aws_secretsmanager_secret_version" "versions" {
  for_each = var.secret_specs

  secret_id     = aws_secretsmanager_secret.secrets[each.key].id
  secret_string = each.value.secret_string
}
