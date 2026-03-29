resource "aws_launch_template" "this" {
  name          = "${local.custom_ec2_cluster_name}-lt"
  image_id      = local.image[local.image.use].image_id
  instance_type = local.image[local.image.use].instance_types[0]
}

resource "aws_autoscaling_group" "this" {
  name               = "${local.custom_ec2_cluster_name}-asg"
  availability_zones = data.aws_availability_zones.current.names
  max_size           = 1
  min_size           = 0
  desired_capacity   = 0

  protect_from_scale_in = true

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }
}

# Create ECS Cluster with infrastructure - Fargate and Custom EC2 Instances (ASG)
module "fargate_custom_ec2_cluster" {
  source = "../../shared-modules/ecs_cluster"

  name               = local.custom_ec2_cluster_name
  capacity_providers = ["FARGATE", "FARGATE_SPOT"]

  default_capacity_provider_strategy = [
    { capacity_provider = "FARGATE_SPOT", weight = 2, base = 0 },
    { capacity_provider = "FARGATE", weight = 1, base = 0 }
  ]

  auto_scaling_group_provider = {
    auto_scaling_group_arn         = aws_autoscaling_group.this.arn
    managed_termination_protection = "ENABLED"
    managed_draining               = "ENABLED"
    maximum_scaling_step_size      = 100
    minimum_scaling_step_size      = 1
    status                         = "ENABLED"
    target_capacity                = 10
  }

  tags = local.tags
}

output "fargate_custom_ec2_cluster_id" {
  value = module.fargate_custom_ec2_cluster.cluster_id
}
