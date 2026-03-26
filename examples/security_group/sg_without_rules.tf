# Create a security group without rules
module "security_group_without_rules" {
  source = "../../shared-modules/security_group"

  name        = "example-sg-without-rules"
  description = "Example security group without rules"
  vpc_id      = data.aws_vpc.default.id
}

output "security_group_without_rules_id" {
  value = module.security_group_without_rules.security_group_id
}
