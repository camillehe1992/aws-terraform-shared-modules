# Create compute environment - Fargate platform
module "fargate_batch_compute_environment" {
  source = "../../shared-modules/batch_compute_environment"

  name                   = "batch-fargate-ce-1"
  compute_resources_type = "FARGATE"

  instance_role_profile_arn = local.batch_instance_role_profile_arn
  vpc_id                    = local.network.vpc_id
  subnet_ids                = local.network.private_subnet_ids
  security_group_ids        = local.network.security_group_ids

  tags = merge(local.tags, {
    "Module"      = "batch_compute_environment"
    "ComputeType" = "FARGATE"
  })
}

module "fargate_spot_batch_compute_environment" {
  source = "../../shared-modules/batch_compute_environment"

  name                   = "batch-fargate-spot-ce"
  compute_resources_type = "FARGATE_SPOT"

  instance_role_profile_arn = local.batch_instance_role_profile_arn
  vpc_id                    = local.network.vpc_id
  subnet_ids                = local.network.private_subnet_ids
  security_group_ids        = local.network.security_group_ids

  tags = merge(local.tags, {
    "Module"      = "batch_compute_environment"
    "ComputeType" = "FARGATE_SPOT"
  })
}

# Create job definition - Fargate platform
module "fargate_job_definition" {
  source = "../../shared-modules/batch_job_definition"

  name                  = "busybox-fargate-jd"
  command               = ["/bin/sh", "-c", "echo 'Hello World!'"]
  container_image       = "busybox:latest"
  container_memory      = 512
  container_vcpu        = 0.25
  platform_capabilities = ["FARGATE"]
  job_role_arn          = module.batch_execution_role.role_arn
  execution_role_arn    = module.batch_execution_role.role_arn

  timeout_minutes = 1

  environment = {
    ENV = "demo"
  }

  tags = merge(local.tags, {
    "Module" = "batch_job_definition"
  })
}

module "fargate_job_queue" {
  source = "../../shared-modules/batch_job_queue"

  name     = "busybox-fargate-jq"
  priority = local.priority
  compute_environments = [{
    order               = 1
    compute_environment = module.fargate_spot_batch_compute_environment.compute_environment_arn
    }, {
    order               = 2
    compute_environment = module.fargate_batch_compute_environment.compute_environment_arn
  }]

  tags = merge(local.tags, {
    "Module" = "batch_job_queue"
  })
}

# Outputs

output "fargate_compute_environment_arn" {
  description = "ARN of the Batch compute environment"
  value       = module.fargate_batch_compute_environment.compute_environment_arn
}

output "fargate_spot_compute_environment_arn" {
  description = "ARN of the Batch compute environment - spot"
  value       = module.fargate_spot_batch_compute_environment.compute_environment_arn
}

output "fargate_job_definition_arn" {
  description = "ARN of the Batch job definition"
  value       = module.fargate_job_definition.job_definition_arn
}

output "fargate_job_queue_arn" {
  description = "ARN of the Batch job queue"
  value       = module.fargate_job_queue.job_queue_arn
}
