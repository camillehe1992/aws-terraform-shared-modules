data "aws_vpc" "default" {
  default = true
}

data "aws_ec2_managed_prefix_lists" "this" {
  filter {
    name   = "prefix-list-name"
    values = ["com.amazonaws.ap-southeast-1.s3"]
  }
}

# Create a security group with rules
module "web_sg" {
  source = "../../shared-modules/security_group"

  name        = "example-web-sg-with-rules"
  description = "Example security group with rules"
  vpc_id      = data.aws_vpc.default.id

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
}

module "app_sg" {
  source = "../../shared-modules/security_group"

  name        = "example-app-sg-with-rules"
  description = "Example application security group with rules"
  vpc_id      = data.aws_vpc.default.id

  # Allow inbound traffic from S3 prefix lists
  ingress_prefix_lists = data.aws_ec2_managed_prefix_lists.this.ids

  # Allow inbound traffic from the web security group
  ingress_referenced_sgs = {
    "web" = {
      security_group_id = module.web_sg.security_group_id
      from_port         = 8080
      to_port           = 8080
      protocol          = "tcp"
      description       = "Allow inbound traffic from web SG"
    }
  }
}

output "web_sg_id" {
  value = module.web_sg.security_group_id
}

output "app_sg_id" {
  value = module.app_sg.security_group_id
}
