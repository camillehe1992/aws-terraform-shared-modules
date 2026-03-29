resource "aws_ecs_capacity_provider" "auto_scaling_group_provider" {
  count = var.auto_scaling_group_provider != null ? 1 : 0

  name = "auto-scaling-group-provider"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = var.auto_scaling_group_provider.auto_scaling_group_arn
    managed_termination_protection = var.auto_scaling_group_provider.managed_termination_protection
    managed_draining               = var.auto_scaling_group_provider.managed_draining

    managed_scaling {
      instance_warmup_period    = var.auto_scaling_group_provider.instance_warmup_period
      maximum_scaling_step_size = var.auto_scaling_group_provider.maximum_scaling_step_size
      minimum_scaling_step_size = var.auto_scaling_group_provider.minimum_scaling_step_size
      status                    = var.auto_scaling_group_provider.status
      target_capacity           = var.auto_scaling_group_provider.target_capacity
    }
  }

  tags = var.tags
}

resource "aws_ecs_capacity_provider" "managed_instances_provider" {
  count = var.managed_instances_provider != null ? 1 : 0

  name    = "managed-instances-provider"
  cluster = aws_ecs_cluster.this.name

  managed_instances_provider {
    infrastructure_role_arn = var.managed_instances_provider.infrastructure_role_arn
    propagate_tags          = "CAPACITY_PROVIDER"

    instance_launch_template {
      ec2_instance_profile_arn = var.managed_instances_provider.instance_launch_template.ec2_instance_profile_arn
      monitoring               = var.managed_instances_provider.instance_launch_template.monitoring

      network_configuration {
        subnets         = var.managed_instances_provider.instance_launch_template.subnets
        security_groups = var.managed_instances_provider.instance_launch_template.security_groups
      }

      storage_configuration {
        storage_size_gib = var.managed_instances_provider.instance_launch_template.storage_size_gib
      }

      instance_requirements {
        memory_mib {
          min = var.managed_instances_provider.instance_launch_template.min_meory_mib
          max = var.managed_instances_provider.instance_launch_template.max_meory_mib
        }

        vcpu_count {
          min = var.managed_instances_provider.instance_launch_template.min_vcpu_count
          max = var.managed_instances_provider.instance_launch_template.max_vcpu_count
        }

        instance_generations = var.managed_instances_provider.instance_launch_template.instance_generations
        cpu_manufacturers    = var.managed_instances_provider.instance_launch_template.cpu_manufacturers
      }
    }
  }

  tags = var.tags
}
