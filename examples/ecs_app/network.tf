# I want to use my existing network structure for the ECS service with task definition
# VPC - Default VPC (IPv4 CIDR and IPv6 CIDR)
# - Public Subnets (Default)
# - Private Subnets (Custom)

# Route Table (Default): Assoicated with public subnets, which allow Internet access via Internet Gateway
# Route Table (Custom): Assoicated with private subnets, with IPv6 traffic enabled via Egress-only Internet Gateway

# In network bootstrap, for security reasons, a few resources will be created:
# - A security group for ECS tasks
# - ECR API Endpoint: Allow HTTPS traffic from ECS Security Group to ECR API Endpoint
# - ECR DKR Endpoint: Allow HTTPS traffic from ECS Security Group to ECR DKR Endpoint
# - CloudWatch Logs Endpoint: Allow HTTPS traffic from ECS Security Group to CloudWatch Logs Endpoint

locals {
  tags = {
    Module = "ecs_service_with_task_def"
  }
  ecr_endpoints = {
    api = {
      service_name = "com.amazonaws.${data.aws_region.current.id}.ecr.api"
      name         = "ecr-api-endpoint"
    }
    dkr = {
      service_name = "com.amazonaws.${data.aws_region.current.id}.ecr.dkr"
      name         = "ecr-dkr-endpoint"
    }
    cloudwatch_logs = {
      service_name = "com.amazonaws.${data.aws_region.current.id}.logs"
      name         = "cloudwatch-logs-endpoint"
    }
  }
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

# Data sources for existing infrastructure
data "aws_vpc" "default" {
  default = true
}

data "aws_availability_zones" "available" {
  state = "available"
}

# Data source for public subnets
data "aws_subnets" "public" {
  filter {
    name   = "tag:Type"
    values = ["public"]
  }
}

# Data source for private subnets
data "aws_subnets" "private" {
  filter {
    name   = "tag:Type"
    values = ["private"]
  }
}

# Data source for default security group
data "aws_security_group" "default" {
  name   = "default"
  vpc_id = data.aws_vpc.default.id
}

# Security Group
module "ecs_security_group" {
  source = "../../shared-modules/security_group"

  name   = "ecs-security-group"
  vpc_id = data.aws_vpc.default.id

  ingress_referenced_sgs = {
    "web" = {
      security_group_id = data.aws_security_group.default.id
      from_port         = 8080
      to_port           = 8080
      protocol          = "tcp"
      description       = "Allow inbound traffic from web SG"
    }
  }

  tags = merge({
    Name = "ecs-security-group"
  }, local.tags)
}

# Elastic IP for NAT Gateway
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "nat-eip"
  }
}

# NAT Gateway in public subnet
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = data.aws_subnets.public.ids[0]

  tags = {
    Name = "main-nat-gateway"
  }
}

data "aws_route_table" "private" {
  filter {
    name   = "tag:Type"
    values = ["private"]
  }
}

# # Add route to Private Route Table for NAT Gateway
resource "aws_route" "private" {
  route_table_id         = data.aws_route_table.private.id
  gateway_id             = aws_nat_gateway.main.id
  destination_cidr_block = "0.0.0.0/0"
}

output "network" {
  value = {
    private_subnet_ids    = data.aws_subnets.private.ids
    public_subnet_ids     = data.aws_subnets.public.ids
    ecs_security_group_id = module.ecs_security_group.security_group_id
  }
}
