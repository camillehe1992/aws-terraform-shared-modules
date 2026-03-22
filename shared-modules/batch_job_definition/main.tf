
resource "aws_batch_job_definition" "this" {
  name = var.name
  type = "container"

  platform_capabilities = var.platform_capabilities

  container_properties = jsonencode({
    image = var.container_image
    resourceRequirements = [
      { type = "MEMORY", value = tostring(var.container_memory) },
      { type = "VCPU", value = tostring(var.container_vcpu) }
    ]
    jobRoleArn  = var.job_role_arn
    environment = [for k, v in var.environment : { name = k, value = v }]
  })

  retry_strategy {
    attempts = var.retry_strategy.attempts
  }

  timeout {
    attempt_duration_seconds = var.timeout_minutes * 60
  }

  tags = var.tags
}
