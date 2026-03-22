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

  # dynamic "job_state_time_limit_action" {
  #   for_each = var.job_state_time_limit_action != null ? [var.job_state_time_limit_action] : []
  #   content {
  #     action           = job_state_time_limit_action.value.action
  #     max_time_seconds = job_state_time_limit_action.value.max_time_seconds
  #     reason           = job_state_time_limit_action.value.reason
  #     state            = job_state_time_limit_action.value.state
  #   }
  # }

  scheduling_policy_arn = var.scheduling_policy_arn

  tags = var.tags
}
