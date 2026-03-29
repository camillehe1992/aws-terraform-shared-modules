# Example 1: Basic Application Load Balancer with HTTP
module "nginx_alb" {
  source = "../../shared-modules/load_balancer"

  name               = local.alb_name
  vpc_id             = local.network.vpc_id
  subnets            = local.network.public_subnet_ids
  security_groups    = local.network.security_group_ids
  load_balancer_type = "application"
  internal           = false
  target_groups      = local.target_groups
  listeners          = local.listeners

  tags = local.tags
}

# # Outputs
output "nginx_alb_endpoint" {
  description = "HTTP endpoint of the nginx ALB"
  value       = "http://${module.nginx_alb.load_balancer_dns_name}"
}

output "target_group_arns" {
  description = "ARNs of the target groups"
  value       = module.nginx_alb.target_group_arns
}
