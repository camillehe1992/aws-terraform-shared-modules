resource "aws_batch_job_queue" "this" {
  name     = var.name
  state    = var.state
  priority = var.priority

  dynamic "compute_environment_order" {
    for_each = var.compute_environments
    content {
      order               = compute_environment_order.value.order
      compute_environment = compute_environment_order.value.compute_environment
    }
  }

  scheduling_policy_arn = var.scheduling_policy_arn

  tags = var.tags
}
