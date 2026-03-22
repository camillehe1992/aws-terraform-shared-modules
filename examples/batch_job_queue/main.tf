data "aws_partition" "this" {}
data "aws_region" "this" {}
data "aws_caller_identity" "this" {}

locals {
  aws_partition                  = data.aws_partition.this.partition
  aws_region                     = data.aws_region.this.id
  aws_account_id                 = data.aws_caller_identity.this.account_id
  compute_environment_arn_prefix = "arn:${local.aws_partition}:batch:${local.aws_region}:${local.aws_account_id}:compute-environment/"
  priority                       = 10
  fargate_compute_environments = [
    {
      order               = 2
      compute_environment = "${local.compute_environment_arn_prefix}standard-ce-tq7"
    }
  ]
  standard_compute_environments = [
    {
      order               = 1
      compute_environment = "${local.compute_environment_arn_prefix}standard-ce-tq7"
    }
  ]
}

module "high_priority_job_queue" {
  source = "../../shared-modules/batch_job_queue"

  name                 = "dev-high-priority"
  priority             = local.priority
  compute_environments = local.standard_compute_environments
}

output "high_priority_queue_arn" {
  value = module.high_priority_job_queue.job_queue_arn
}
