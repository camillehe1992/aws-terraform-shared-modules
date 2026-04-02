locals {
  common_tags = merge(var.tags, {
    Module = "ecs_cluster"
  })
}

# Create CloudWatch Log Group
resource "aws_cloudwatch_log_group" "this" {
  count = var.log_configuration.enabled ? 1 : 0

  name              = "/ecs/${var.name}"
  retention_in_days = var.retention_in_days

  tags = local.common_tags
}

resource "aws_ecs_cluster" "this" {
  name = var.name

  configuration {
    execute_command_configuration {
      kms_key_id = var.kms_key_id
      logging    = var.log_configuration.enabled ? "OVERRIDE" : null

      dynamic "log_configuration" {
        for_each = var.log_configuration.enabled ? [{}] : []
        content {
          cloud_watch_encryption_enabled = true
          cloud_watch_log_group_name     = aws_cloudwatch_log_group.this[0].name
          s3_bucket_name                 = var.log_configuration.s3_bucket_name
          s3_bucket_encryption_enabled   = var.log_configuration.s3_bucket_encryption_enabled
          s3_key_prefix                  = var.log_configuration.s3_key_prefix
        }
      }
    }

    dynamic "managed_storage_configuration" {
      for_each = var.managed_storage_configuration.enabled ? [{}] : []
      content {
        fargate_ephemeral_storage_kms_key_id = var.managed_storage_configuration.fargate_ephemeral_storage_kms_key_id
        kms_key_id                           = var.managed_storage_configuration.kms_key_id
      }
    }
  }

  setting {
    name  = "containerInsights"
    value = var.container_insights ? "enabled" : "disabled"
  }

  tags = local.common_tags
}

resource "aws_ecs_cluster_capacity_providers" "this" {
  cluster_name       = aws_ecs_cluster.this.name
  capacity_providers = var.capacity_providers

  dynamic "default_capacity_provider_strategy" {
    for_each = { for strategy in var.default_capacity_provider_strategy : strategy.capacity_provider => strategy }
    content {
      capacity_provider = default_capacity_provider_strategy.key
      weight            = default_capacity_provider_strategy.value.weight
      base              = default_capacity_provider_strategy.value.base
    }
  }
}
