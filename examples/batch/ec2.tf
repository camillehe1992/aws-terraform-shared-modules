# Create compute environment - EC2 platform
module "ec2_batch_compute_environment" {
  source = "../../shared-modules/batch_compute_environment"

  name                   = "batch-ec2-ce"
  compute_resources_type = "EC2"
  allocation_strategy    = "BEST_FIT_PROGRESSIVE"

  instance_role_profile_arn = local.batch_instance_role_profile_arn
  vpc_id                    = local.network.vpc_id
  subnet_ids                = local.network.private_subnet_ids
  security_group_ids        = local.network.security_group_ids

  tags = merge(local.tags, {
    "Module"      = "batch_compute_environment"
    "ComputeType" = "EC2"
  })
}

# Create compute environment - EC2 platform - spot
module "ec2_spot_compute_environment" {
  source = "../../shared-modules/batch_compute_environment"

  name                   = "batch-ec2-spot-ce-1"
  compute_resources_type = "SPOT"
  allocation_strategy    = "SPOT_CAPACITY_OPTIMIZED"
  bid_percentage         = 60

  instance_role_profile_arn = local.batch_instance_role_profile_arn
  vpc_id                    = local.network.vpc_id
  subnet_ids                = local.network.private_subnet_ids
  security_group_ids        = local.network.security_group_ids
  spot_iam_fleet_role_arn   = local.spot_iam_fleet_role_arn

  tags = merge(local.tags, {
    "Module"      = "batch_compute_environment"
    "ComputeType" = "EC2_SPOT"
  })
}

# Create job definition - EC2 platform
module "ec2_job_definition" {
  source = "../../shared-modules/batch_job_definition"

  name                  = "busybox-ec2-jd"
  command               = ["/bin/sh", "-c", "echo 'Hello World!'"]
  container_image       = "busybox:latest"
  container_memory      = 1024
  container_vcpu        = 1
  platform_capabilities = ["EC2"]
  job_role_arn          = module.batch_execution_role.role_arn
  execution_role_arn    = module.batch_execution_role.role_arn
  timeout_minutes       = 1

  environment = {
    ENV = "demo"
  }

  tags = merge(local.tags, {
    "Module"      = "batch_job_definition"
    "ComputeType" = "EC2"
  })
}

module "ec2_job_queue" {
  source = "../../shared-modules/batch_job_queue"

  name     = "busybox-ec2-jq"
  priority = local.priority
  compute_environments = [
    {
      order               = 1
      compute_environment = module.ec2_spot_compute_environment.compute_environment_arn
    },
    {
      order               = 2
      compute_environment = module.ec2_batch_compute_environment.compute_environment_arn
  }]

  tags = merge(local.tags, {
    "Module" = "batch_job_queue"
  })
}

# Outputs
output "compute_environment_arn" {
  description = "ARN of the Batch compute environment"
  value       = module.ec2_batch_compute_environment.compute_environment_arn
}

output "spot_compute_environment_arn" {
  description = "ARN of the Batch compute environment - spot"
  value       = module.ec2_spot_compute_environment.compute_environment_arn
}

output "ec2_job_definition_arn" {
  description = "ARN of the Batch job definition"
  value       = module.ec2_job_definition.job_definition_arn
}

output "ec2_job_queue_arn" {
  description = "ARN of the Batch job queue"
  value       = module.ec2_job_queue.job_queue_arn
}
