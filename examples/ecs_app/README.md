# examples/ecs_service_with_task_def

Deploy **ECS Service with Task Definition** resources via Terraform.

This example creates a complete ECS service with task definition, including:
- ECS cluster
- Task execution IAM role
- CloudWatch log group
- Security group with proper ingress/egress rules
- Conditional subnet creation (creates subnet if no private subnets exist)
- Nginx web server container

---

## Quick start
```bash
just plan ecs_service_with_task_def
just apply ecs_service_with_task_def
```

## Show outputs
```bash
just output ecs_service_with_task_def
```

## Clean up
```bash
just destroy-apply ecs_service_with_task_def
```

---

## Module used
- Source: `../../shared-modules/ecs_service_with_task_def`

## Features Demonstrated
- **Conditional Infrastructure**: Automatically creates subnet if no private subnets exist
- **Complete ECS Setup**: Cluster, service, task definition, IAM roles, and networking
- **Container Configuration**: Nginx container with port mapping and CloudWatch logging
- **Security**: Proper security group configuration for web traffic
- **High Availability**: Uses multiple availability zones when available
