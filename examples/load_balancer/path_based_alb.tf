# Example 2: Path-based routing ALB
module "path_based_alb" {
  source = "../../shared-modules/load_balancer"

  name               = "example-path-alb"
  vpc_id             = data.aws_vpc.default.id
  subnets            = data.aws_subnets.public.ids
  security_groups    = [data.aws_security_group.default.id]
  load_balancer_type = "application"
  internal           = false

  target_groups = [
    {
      name     = "api-tg"
      port     = 80
      protocol = "HTTP"
      health_check = {
        enabled = true
        path    = "/api/health"
        port    = "traffic-port"
      }
    },
    {
      name     = "web-tg"
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
        target_group_name = "web-tg"
      }
    }
  ]

  listener_rules = [
    {
      listener_index = 0
      priority       = 100
      actions = [
        {
          type              = "forward"
          target_group_name = "api-tg"
        }
      ]
      conditions = [
        {
          path_pattern = {
            values = ["/api/*"]
          }
        }
      ]
    }
  ]

  tags = {
    Environment = "example"
    Example     = "path-based-alb"
  }
}

output "target_groups" {
  description = "Target groups of the path-based ALB"
  value       = module.path_based_alb.target_groups
}

output "path_based_alb_dns_name" {
  description = "DNS name of the path-based ALB"
  value       = module.path_based_alb.load_balancer_dns_name
}

output "path_based_alb_endpoint" {
  description = "HTTP endpoint of the path-based ALB"
  value       = "http://${module.path_based_alb.load_balancer_dns_name}"
}
