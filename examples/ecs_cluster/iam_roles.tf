# Here are some reosurce dependencies for ECS service task setup:
# - ECS Infrastructure Role
# - ECS Instance Role with Instance Profile

data "aws_iam_policy_document" "ecs_infrastructure_role_inline_policy" {
  statement {
    effect = "Allow"
    actions = [
      "ecs:DescribeCluster",
      "ecs:DescribeClusters",
      "ecs:DescribeTaskDefinition",
      "ecs:DescribeTaskDefinitions",
      "ecs:DescribeTaskSet",
      "ecs:DescribeTaskSets",
      "ecs:DescribeTasks",
      "ecs:DescribeTasks",
    ]
    resources = ["*"]
  }
}

module "ecs_infrastructure_role" {
  source = "../../shared-modules/iam_role"

  role_name        = "ecs-infrastructure-role"
  role_description = "IAM role for ECS infrastructure"
  principals = {
    "Service" = {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com"]
    }
  }
  user_managed_policies = {
    mini_policy = data.aws_iam_policy_document.ecs_infrastructure_role_inline_policy.json
  }

  tags = local.tags
}

data "aws_iam_policy_document" "ecs_instance_role_inline_policy" {
  statement {
    effect = "Allow"
    actions = [
      "ecs:DescribeCluster",
      "ecs:DescribeClusters",
      "ecs:DescribeTaskDefinition",
      "ecs:DescribeTaskDefinitions",
      "ecs:DescribeTaskSet",
      "ecs:DescribeTaskSets",
      "ecs:DescribeTasks",
      "ecs:DescribeTasks",
    ]
    resources = ["*"]
  }
}

module "ecs_instance_role" {
  source = "../../shared-modules/iam_role"

  role_name        = "ecs-instance-role"
  role_description = "IAM role for ECS instance"
  principals = {
    "Service" = {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com"]
    }
  }
  user_managed_policies = {
    mini_policy = data.aws_iam_policy_document.ecs_instance_role_inline_policy.json
  }

  has_iam_instance_profile = true

  tags = local.tags
}

# Outputs
output "ecs_infrastructure_role_arn" {
  value = module.ecs_infrastructure_role.role_arn
}

output "ecs_instance_role_profile_arn" {
  value = module.ecs_instance_role.instance_profile_arn
}
