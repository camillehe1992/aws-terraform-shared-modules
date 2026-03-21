resource "random_string" "resource_suffix" {
  length  = 3
  special = false
  upper   = false
}

resource "aws_placement_group" "this" {
  count = var.compute_resources_type == "FARGATE" ? 0 : 1

  name     = "${var.resource_prefix}cluster-placement-group-${random_string.resource_suffix.result}"
  strategy = "cluster"
}

resource "aws_batch_compute_environment" "this" {
  name = "${var.resource_prefix}ce-${random_string.resource_suffix.result}"

  compute_resources {
    instance_type = var.compute_resources_type == "FARGATE" ? null : var.instance_types
    instance_role = var.compute_resources_type == "FARGATE" ? null : var.instance_role_profile_arn

    max_vcpus       = var.max_vcpus
    min_vcpus       = var.compute_resources_type == "FARGATE" ? null : var.min_vcpus
    desired_vcpus   = var.desired_vcpus
    placement_group = var.compute_resources_type == "FARGATE" ? null : aws_placement_group.this[0].name

    subnets            = var.subnet_ids
    security_group_ids = var.security_group_ids

    type                = var.compute_resources_type
    spot_iam_fleet_role = null
  }

  service_role = var.service_role_arn
  state        = var.state
  type         = "MANAGED"

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      compute_resources[0].desired_vcpus, # Allow auto scaling
    ]
  }

  tags = var.tags
}
