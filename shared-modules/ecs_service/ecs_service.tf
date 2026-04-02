resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/ecs/${var.service_name}"
  retention_in_days = var.retention_in_days
  kms_key_id        = var.kms_key_id
  tags              = local.common_tags
}

# Check: CKV_AWS_333: "Ensure ECS services do not have public IP addresses assigned to them automatically"
resource "aws_ecs_service" "this" {
  name            = var.service_name
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = var.desired_count
  launch_type     = var.launch_type

  deployment_maximum_percent         = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent

  deployment_circuit_breaker {
    enable   = var.deployment_circuit_breaker
    rollback = var.deployment_circuit_breaker
  }

  dynamic "network_configuration" {
    for_each = var.network_mode == "awsvpc" ? [1] : []
    content {
      subnets          = var.subnets
      security_groups  = var.security_groups
      assign_public_ip = var.assign_public_ip
    }
  }

  dynamic "service_registries" {
    for_each = var.service_registries != null ? var.service_registries : []
    content {
      registry_arn   = service_registries.value.registry_arn
      port           = service_registries.value.port
      container_name = service_registries.value.container_name
      container_port = service_registries.value.container_port
    }
  }

  dynamic "load_balancer" {
    for_each = var.load_balancers != null ? var.load_balancers : []
    content {
      target_group_arn = load_balancer.value.target_group_arn
      container_name   = load_balancer.value.container_name
      container_port   = load_balancer.value.container_port
    }
  }

  enable_ecs_managed_tags = true
  enable_execute_command  = var.enable_execute_command
  force_new_deployment    = var.force_new_deployment
  wait_for_steady_state   = var.wait_for_steady_state
  propagate_tags          = var.propagate_tags

  # Optional: Allow external changes without Terraform plan difference
  lifecycle {
    ignore_changes = [
      desired_count
    ]
  }

  tags = local.common_tags
}
