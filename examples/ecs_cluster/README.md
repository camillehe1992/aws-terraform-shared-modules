# examples/ecs_cluster

Deploy an **Amazon ECS cluster** configured for **Fargate & Fargate Spot** with **CloudWatch Container Insights** enabled.

---

## Quick start

1. Plan & apply:

   ```bash
   just plan ecs_cluster
   just apply ecs_cluster
   ```

2. Retrieve the output values:

   ```bash
   just output ecs_cluster
   ```

## Clean up

```bash
just destroy-apply ecs_cluster
```

---

## Module used

- Source: `../../shared-modules/ecs_cluster`
