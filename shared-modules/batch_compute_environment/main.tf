locals {
  common_tags = merge(var.tags, {
    Module = "batch_compute_environment"
  })
  is_fargate = var.compute_resources_type == "FARGATE_SPOT" || var.compute_resources_type == "FARGATE" ? true : false
}

resource "aws_placement_group" "this" {
  count = local.is_fargate ? 0 : 1

  name            = "${var.name}-${var.strategy}"
  partition_count = var.strategy == "partition" ? var.partition_count : null
  spread_level    = var.strategy == "spread" ? var.spread_level : null
  strategy        = var.strategy
  tags            = local.common_tags
}

resource "aws_batch_compute_environment" "this" {
  name = var.name

  compute_resources {
    type                = var.compute_resources_type
    spot_iam_fleet_role = local.is_fargate ? null : var.spot_iam_fleet_role_arn
    allocation_strategy = local.is_fargate ? null : var.allocation_strategy
    bid_percentage      = local.is_fargate ? null : var.bid_percentage
    instance_type       = local.is_fargate ? null : var.instance_types
    instance_role       = local.is_fargate ? null : var.instance_role_profile_arn
    ec2_key_pair        = local.is_fargate ? null : var.ec2_key_pair

    desired_vcpus   = var.desired_vcpus
    max_vcpus       = var.max_vcpus
    min_vcpus       = local.is_fargate ? null : var.min_vcpus
    placement_group = local.is_fargate ? null : aws_placement_group.this[0].name

    ec2_configuration {
      image_id_override = var.image_id_override
      image_type        = coalesce(var.image_id_override, "ECS_AL2")
    }

    subnets            = var.subnet_ids
    security_group_ids = var.security_group_ids
  }

  service_role = var.service_role_arn
  state        = var.state
  type         = "MANAGED"

  dynamic "update_policy" {
    for_each = local.is_fargate ? [] : [{}]
    content {
      job_execution_timeout_minutes = var.job_execution_timeout_minutes
      terminate_jobs_on_update      = var.terminate_jobs_on_update
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      compute_resources[0].desired_vcpus, # Allow auto scaling
    ]
  }

  tags = local.common_tags
}
