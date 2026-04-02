# Setup ECS Cluster with different capacity providers - Fargate/EC2 On-Demand

The example demostrates how to use the shared modules to create an ECS cluster leveraging Fargate/EC2 On-Demand capacity providers.

The example uses the following shared modules:

| Shared Module | Description                                                        |
| ------------- | ------------------------------------------------------------------ |
| ecs_cluster   | Create ECS cluster with different capacity providers configuration |

## ECS Cluster

### ECS Cluster with Fargate On-Demand/Spot capacity

File: ecs_cluster.tf

Cluster infrastructure type: Fargate only
Cluster capacity providers: FARGATE, FARGATE_SPOT

### ECS Cluster with Fargate and Managed EC2 On-Demand/Spot capacity

File: managed_ec2_cluster.tf

Cluster infrastructure type: Fargate and Managed Instances
Cluster capacity providers: FARGATE, FARGATE_SPOT
Instance Selection: Use ECS default

### ECS Cluster with Fargate and Custom EC2 On-Demand/Spot capacity

File: custom_ec2_cluster.tf

Cluster infrastructure type: Fargate and Self-managed instances
Cluster capacity providers: FARGATE, FARGATE_SPOT
Auto Scaling group: create

## Provision Resources

In the `examples/ecs_app` directory, run the following `just` commands:

```bash
# plan and apply ecs service resources
just quick-apply

# output ecs service resources
just output
```

## Clean up

```bash
# destroy ecs service resources
just quick-destroy
```
