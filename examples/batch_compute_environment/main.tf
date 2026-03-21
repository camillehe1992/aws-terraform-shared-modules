data "aws_partition" "this" {}

data "aws_caller_identity" "this" {}

data "aws_availability_zones" "current" {
  state = "available"
}

# Only be added into states since default VPC exists in the account
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

# Only be added into states since default subnets exist in the default VPC
resource "aws_default_subnet" "default" {
  for_each          = toset(data.aws_availability_zones.current.names)
  availability_zone = each.value
}

module "batch_security_group" {
  source = "../../shared-modules/security_group"

  name        = "batch-security-group"
  description = "The security group for the Batch compute environment"
  vpc_id      = local.vpc_id

  ingress_cidrs = [
    {
      description = "Allow all inbound traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  tags = local.tags
}

locals {
  aws_partition          = data.aws_partition.this.partition
  aws_account_id         = data.aws_caller_identity.this.account_id
  vpc_id                 = aws_default_vpc.default.id
  subnet_ids             = [for key, value in aws_default_subnet.default : value.id]
  batch_service_role_arn = "arn:${local.aws_partition}:iam::${local.aws_account_id}:role/aws-service-role/batch.amazonaws.com/AWSServiceRoleForBatch"
  tags = {
    "Project" = "BatchComputeEnvironment"
  }
}

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
  tags                     = local.tags
}

module "standard_batch_compute_environment" {
  source = "../../shared-modules/batch_compute_environment"

  resource_prefix           = "standard-"
  instance_role_profile_arn = module.batch_instance_role.instance_profile_arn
  service_role_arn          = local.batch_service_role_arn
  vpc_id                    = local.vpc_id
  subnet_ids                = local.subnet_ids
  security_group_ids        = [module.batch_security_group.security_group_id]

  tags = local.tags
}

output "standard_batch_ce_arn" {
  value = module.standard_batch_compute_environment.compute_environment_arn
}

# Create Fargate compute environment
module "fargate_batch_compute_environment" {
  source = "../../shared-modules/batch_compute_environment"

  resource_prefix        = "fargate-"
  compute_resources_type = "FARGATE"

  service_role_arn   = local.batch_service_role_arn
  vpc_id             = local.vpc_id
  subnet_ids         = local.subnet_ids
  security_group_ids = [module.batch_security_group.security_group_id]

  tags = local.tags
}

output "fargate_batch_ce_arn" {
  value = module.fargate_batch_compute_environment.compute_environment_arn
}
