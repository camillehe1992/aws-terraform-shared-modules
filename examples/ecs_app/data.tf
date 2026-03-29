data "aws_partition" "this" {}

data "aws_region" "current" {}

data "aws_caller_identity" "this" {}

data "aws_availability_zones" "current" {
  state = "available"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
  tags = {
    Type = "public"
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
  tags = {
    Type = "private"
  }
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = data.aws_vpc.default.id
}

data "aws_route_table" "private" {
  vpc_id = data.aws_vpc.default.id

  # filter by tag Type=private
  filter {
    name   = "tag:Type"
    values = ["private"]
  }
}
