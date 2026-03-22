# IAM Role for Batch Job
module "job_role" {
  source    = "../../shared-modules/iam_role"
  role_name = "demo-batch-job-role"

  principals = {
    "Service" = {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }

  aws_managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  ]
}

module "job_definition" {
  source = "../../shared-modules/batch_job_definition"

  name             = "demo-ec2--busybox-job"
  container_image  = "busybox:latest"
  container_memory = 1024
  container_vcpu   = 1
  job_role_arn     = module.job_role.role_arn

  environment = {
    ENV = "demo"
  }

  tags = {
    Environment = "dev"
  }
}


output "job_definition_arn" {
  value = module.job_definition.job_definition_arn
}
