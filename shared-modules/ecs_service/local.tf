locals {
  container_definitions = [
    for container in var.containers : {
      name  = container.name
      image = container.image

      cpu       = container.cpu
      memory    = container.memory
      essential = container.essential

      environment = [
        for key, value in container.environment : {
          name  = key
          value = value
        }
      ]

      secrets = [
        for secret in container.secrets : {
          name      = secret.name
          valueFrom = secret.value_from
        }
      ]

      portMappings = [
        for port_mapping in container.port_mappings : {
          containerPort = port_mapping.container_port
          hostPort      = port_mapping.host_port
          protocol      = port_mapping.protocol
        }
      ]

      mountPoints = [
        for mount_point in container.mount_points : {
          sourceVolume  = mount_point.source_volume
          containerPath = mount_point.container_path
          readOnly      = mount_point.read_only
        }
      ]

      logConfiguration = container.log_configuration != null ? {
        logDriver = container.log_configuration.log_driver
        options   = container.log_configuration.options
        secretOptions = container.log_configuration.secret_options != null ? [
          for secret_option in container.log_configuration.secret_options : {
            name      = secret_option.name
            valueFrom = secret_option.value_from
          }
        ] : []
      } : null

      healthCheck = container.health_check != null ? {
        command     = container.health_check.command
        interval    = container.health_check.interval
        timeout     = container.health_check.timeout
        retries     = container.health_check.retries
        startPeriod = container.health_check.start_period
      } : null

      workingDirectory       = container.working_directory
      user                   = container.user
      readonlyRootFilesystem = container.readonly_root_filesystem
      privileged             = container.privileged
      linuxParameters        = container.linux_parameters
    }
  ]
}
