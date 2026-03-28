# Create IAM role for container instances
module "batch_instance_role" {
  source = "../../shared-modules/iam_role"

  role_name        = "batch-instance-role"
  role_description = "The IAM role and instance profile for the container instances to use when they're launched"
  principals = {
    "Service" = {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
  aws_managed_policy_arns = [
    "arn:${local.aws_partition}:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
  ]
  has_iam_instance_profile = true
  tags = merge(local.tags, {
    "Module" = "iam_role"
  })
}

module "batch_execution_role" {
  source           = "../../shared-modules/iam_role"
  role_name        = "batch-execution-role"
  role_description = "The IAM role and instance profile for the container instances to use when launched on Fargate"
  principals = {
    "Service" = {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
  aws_managed_policy_arns = [
    "arn:${local.aws_partition}:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
    "arn:${local.aws_partition}:iam::aws:policy/EC2InstanceProfileForImageBuilderECRContainerBuilds"
  ]
  has_iam_instance_profile = true
  tags = merge(local.tags, {
    "Module" = "iam_role"
  })
}

module "spot_iam_fleet_role" {
  source = "../../shared-modules/iam_role"

  role_name        = "spot-iam-fleet-role"
  role_description = "The IAM role and instance profile for the spot instances to use when they're launched"
  principals = {
    "Service" = {
      type        = "Service"
      identifiers = ["spotfleet.amazonaws.com"]
    }
  }
  aws_managed_policy_arns = [
    "arn:${local.aws_partition}:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
  ]
  has_iam_instance_profile = true
  tags = merge(local.tags, {
    "Module" = "iam_role"
  })
}

output "batch_instance_role_arn" {
  description = "The ARN of batch instance role"
  value       = module.batch_instance_role.role_arn
}

output "batch_execution_role_arn" {
  description = "The ARN of batch execution role"
  value       = module.batch_execution_role.role_arn
}
