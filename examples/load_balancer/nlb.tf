# Example 3: Network Load Balancer (NLB)
module "nlb" {
  source = "../../shared-modules/load_balancer"

  name               = "example-nlb"
  vpc_id             = data.aws_vpc.default.id
  subnets            = data.aws_subnets.public.ids
  load_balancer_type = "network"
  internal           = false

  target_groups = [
    {
      name     = "tcp-tg"
      port     = 80
      protocol = "TCP"
      health_check = {
        enabled  = true
        protocol = "TCP"
        port     = "traffic-port"
      }
    }
  ]

  security_groups = [data.aws_security_group.default.id]

  listeners = [
    {
      port     = 80
      protocol = "TCP"
      default_action = {
        type              = "forward"
        target_group_name = "tcp-tg"
      }
    }
  ]

  tags = {
    Environment = "example"
    Example     = "nlb"
  }
}

output "nlb_dns_name" {
  description = "DNS name of the NLB"
  value       = module.nlb.load_balancer_dns_name
}

output "nlb_endpoint" {
  description = "TCP endpoint of the NLB"
  value       = "tcp://${module.nlb.load_balancer_dns_name}:80"
}
