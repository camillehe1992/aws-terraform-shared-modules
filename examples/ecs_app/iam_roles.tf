# Here are some reosurce dependencies for ECS service task setup:
# - ECS Task Execution Role
# - ECS Task Role

# Create IAM role for ECS task execution
data "aws_iam_policy_document" "ecs_tasks_execution_role_inline_policy" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchImportUpstreamImage", // Required for first-time cache pulls
    ]
    resources = ["*"]
  }
}

module "ecs_task_execution_role" {
  source = "../../shared-modules/iam_role"

  role_name        = "demo-ecs-execution-role"
  role_description = "IAM role for ECS task execution"
  principals = {
    "Service" = {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
  user_managed_policies = {
    mini_policy = data.aws_iam_policy_document.ecs_tasks_execution_role_inline_policy.json
  }

  tags = local.tags
}

data "aws_iam_policy_document" "ecs_tasks_role_inline_policy" {
  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue",
    ]
    resources = ["*"]
  }
}

module "ecs_task_role" {
  source = "../../shared-modules/iam_role"

  role_name        = "demo-ecs-task-role"
  role_description = "IAM role for ECS task"
  principals = {
    "Service" = {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
  user_managed_policies = {
    secret_policy = data.aws_iam_policy_document.ecs_tasks_role_inline_policy.json
  }

  tags = local.tags
}

output "ecs_task_execution_role_arn" {
  value = module.ecs_task_execution_role.role_arn
}

output "ecs_task_role_arn" {
  value = module.ecs_task_role.role_arn
}
