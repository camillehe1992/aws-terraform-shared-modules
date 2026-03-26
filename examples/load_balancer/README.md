# examples/load_balancer

Deploy **AWS Load Balancers** (ALB, NLB) with various configurations via Terraform.

This example demonstrates:
- Basic Application Load Balancer with HTTP
- Path-based routing ALB
- Network Load Balancer (NLB)
- Target groups with health checks
- Listener rules for advanced routing

---

## Quick start
```bash
just plan load_balancer
just apply load_balancer
```

## Show outputs
```bash
just output load_balancer
```

## Clean up
```bash
just destroy-apply load_balancer
```

---

## Module used
- Source: `../../shared-modules/load_balancer`

## Examples Demonstrated

### 1. Basic ALB with HTTP
- Simple internet-facing ALB
- Single target group
- HTTP listener on port 80
- Health checks on root path

### 2. Path-based Routing ALB
- Multiple target groups
- Listener rules for path-based routing
- `/api/*` routes to API target group
- Default route to web target group

### 3. Network Load Balancer (NLB)
- TCP listener on port 80
- TCP health checks
- High performance for TCP traffic

## Accessing Your Load Balancers

After deployment, you can access your load balancers:

```bash
# Get ALB DNS names
terraform output basic_alb_endpoint
terraform output path_based_alb_endpoint

# Get NLB endpoint
terraform output nlb_endpoint
```

## Architecture
Internet → ALB/NLB → Target Groups → Backend Services

## Security Features
- Security groups controlling ingress/egress
- Health checks to ensure only healthy targets receive traffic
- Support for HTTPS with SSL certificates (configure in your setup)
