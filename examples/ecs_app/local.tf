locals {
  tags = {
    Example = "ecs_app"
  }
  # Network
  network = {
    vpc_id                 = data.aws_vpc.default.id
    public_subnet_ids      = data.aws_subnets.public.ids
    private_subnet_ids     = data.aws_subnets.private.ids
    private_route_table_id = data.aws_route_table.private.id
    security_group_ids     = [data.aws_security_group.default.id]
  }
  # ECS Cluster
  fargate_only_cluster_name = "ecs-fargate-only-cluster"
  # ECS Service
  service_name = "nginx-service"
  family_name  = "nginx-task"
  cpu          = "256"
  memory       = "512"
  containers = [
    {
      name  = "nginx-container"
      image = "public.ecr.aws/nginx/nginx:alpine"
      port_mappings = [
        {
          container_port = 80
          protocol       = "tcp"
        }
      ]
    }
  ]
  # ALB
  alb_name = "nginx-alb"
  target_groups = [
    {
      name     = "nginx-tg"
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
        target_group_name = "nginx-tg"
      }
    }
  ]
}
