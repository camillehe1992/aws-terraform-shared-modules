# Example 1: Basic Application Load Balancer with HTTP
module "basic_alb" {
  source = "../../shared-modules/load_balancer"

  name               = "example-basic-alb"
  vpc_id             = data.aws_vpc.default.id
  subnets            = data.aws_subnets.public.ids
  security_groups    = [data.aws_security_group.default.id]
  load_balancer_type = "application"
  internal           = false

  target_groups = [
    {
      name     = "basic-web-tg"
      port     = 80
      protocol = "HTTP"
      health_check = {
        enabled = true
        path    = "/"
        port    = "traffic-port"
      }
    }
  ]

  listeners = [
    {
      port     = 80
      protocol = "HTTP"
      default_action = {
        type              = "forward"
        target_group_name = "basic-web-tg"
      }
    }
  ]

  tags = {
    Environment = "example"
    Example     = "basic-alb"
  }
}

# # Outputs
output "basic_alb_dns_name" {
  description = "DNS name of the basic ALB"
  value       = module.basic_alb.load_balancer_dns_name
}

output "basic_alb_endpoint" {
  description = "HTTP endpoint of the basic ALB"
  value       = "http://${module.basic_alb.load_balancer_dns_name}"
}
