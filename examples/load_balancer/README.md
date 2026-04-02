# Setup Load Balancers in AWS

The example is used to demostrate the usage of Load Balancer shared module in AWS.

The example uses the following shared modules:

| Shared Module | Description          |
| ------------- | -------------------- |
| load_balancer | Create Load Balancer |

**Architecture**:
Internet → ALB/NLB → Target Groups → Backend Services

## Examples Demonstrated

### 1. Basic ALB with HTTP (basic_alb.tf)

- Simple internet-facing ALB
- Single target group
- HTTP listener on port 80
- Health checks on root path

### 2. Path-based Routing ALB (path_based_alb.tf)

- Multiple target groups
- Listener rules for path-based routing
- `/api/*` routes to API target group
- Default route to web target group

### 3. Network Load Balancer (NLB) (nlb.tf)

- TCP listener on port 80
- TCP health checks
- High performance for TCP traffic

## Security Features

- Security groups controlling ingress/egress
- Health checks to ensure only healthy targets receive traffic
- Support for HTTPS with SSL certificates (configure in your setup)

## Provision Resources

in the `examples/lambda_layer` directory, run the following `just` commands:

```bash
# plan and apply resources
just quick-apply

# output resources
just output
```

## Clean up Resources

For cost saving, please clean up the resources after the demo.

```bash
just quick-destroy
```
