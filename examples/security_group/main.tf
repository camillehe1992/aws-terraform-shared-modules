data "aws_vpc" "default" {
  default = true
}

data "aws_ec2_managed_prefix_lists" "this" {
  filter {
    name   = "prefix-list-name"
    values = ["com.amazonaws.ap-southeast-1.s3"]
  }
}

data "aws_security_groups" "default" {
  filter {
    name   = "group-name"
    values = ["default"]
  }
}


module "security_group_without_rules" {
  source = "../../shared-modules/security_group"

  name        = "example-sg-without-rules"
  description = "Example security group without rules"
  vpc_id      = data.aws_vpc.default.id
}

output "security_group_without_rules" {
  value = module.security_group_without_rules.security_group
}

# Create a security group with rules
module "security_group_with_rules" {
  source = "../../shared-modules/security_group"
  depends_on = [
    module.security_group_without_rules
  ]

  name        = "example-sg-with-rules"
  description = "Example security group with rules"
  vpc_id      = data.aws_vpc.default.id

  # Allow inbound traffic from all prefix lists
  ingress_prefix_lists = data.aws_ec2_managed_prefix_lists.this.ids

  # Allow inbound traffic from the default security group
  ingress_referenced_sg_ids = data.aws_security_groups.default.ids

  ingress_cidrs = [
    {
      description = "Allow HTTPS from VPC"
      cidr_ipv4   = "172.31.0.0/16"
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"
    },
    {
      description = "Allow HTTP from VPC"
      cidr_ipv4   = "172.31.0.0/16"
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
    }
  ]

  egress_cidrs = [
    {
      description = "Allow all outbound IPv4 traffic"
      cidr_ipv4   = "0.0.0.0/0"
      from_port   = null
      to_port     = null
      ip_protocol = "-1"
    },
    {
      description = "Allow all outbound IPv6 traffic"
      cidr_ipv6   = "::/0"
      from_port   = null
      to_port     = null
      ip_protocol = "-1"
    }
  ]
}

output "security_group_with_rules" {
  value = module.security_group_with_rules.security_group
}
