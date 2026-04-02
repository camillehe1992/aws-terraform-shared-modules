locals {
  common_tags = merge(var.tags, {
    Module = "batch_job_definition"
  })
}

data "aws_region" "current" {}

resource "aws_batch_job_definition" "this" {
  name                  = var.name
  type                  = "container"
  platform_capabilities = var.platform_capabilities

  container_properties = jsonencode({
    command          = var.command
    image            = var.container_image
    jobRoleArn       = var.job_role_arn
    executionRoleArn = var.execution_role_arn
    resourceRequirements = [
      { type = "MEMORY", value = tostring(var.container_memory) },
      { type = "VCPU", value = tostring(var.container_vcpu) }
    ]

    volumes     = var.volumes
    mountPoints = var.mount_points

    environment = [for k, v in var.environment : { name = k, value = v }]
    secrets     = var.secrets
    parameters  = var.parameters

    logConfiguration = {
      logDriver = "awslogs",
      options = {
        "awslogs-group"         = "/aws/batch/job"
        "awslogs-region"        = data.aws_region.current.id
        "awslogs-stream-prefix" = var.name
      },
      secretOptions = []
    }
  })

  retry_strategy {
    attempts = var.retry_strategy.attempts
    evaluate_on_exit {
      action           = "RETRY"
      on_exit_code     = "*"
      on_reason        = "*"
      on_status_reason = "*"
    }
  }

  timeout {
    attempt_duration_seconds = var.timeout_minutes * 60
  }

  tags = local.common_tags
}
