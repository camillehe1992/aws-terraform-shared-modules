# Setup AWS Batch - Fargate/EC2 On-Demand and Spot

The example demostrates how to use the shared modules to create a batch application leveraging AWS Batch service.

The example uses the following shared modules:

| Shared Module             | Description                                                                                          |
| ------------------------- | ---------------------------------------------------------------------------------------------------- |
| batch_compute_environment | Create Batch compute environments (1 EC2 On-Demand, 1 EC2 Spot, 1 Fargate On-Demand, 1 Fargate Spot) |
| batch_job Batch job queue | Batch job queue (1 EC2, 1 Fargate)                                                                   |
| batch_job_definition      | Create Batch job definition (1 EC2, 1 Fargate)                                                       |
| batch_iam_role            | Create Batch Instance role, execution role (1 instance-role, 1 execution-role)                       |

## Network Resources

In order to create a batch application, we need to setup a proper network configuration. The example uses the following network resource that already exists.

- Default VPC
- Default subnets - Public attached with Internet Gateway
- Default security group - Allow SSH, HTTP, HTTPS, and ICMP traffic
- Default route table - Route to Internet Gateway
- Custom subnets - Private attached with NAT Gateway
- Custom route table - Route to NAT Gateway

Besides, in `network.tf`, below resources are created to allow outbound traffic from the private subnets.

- NAT Gateway
- NAT IP
- A new route is added to the custom route table

## Provision Resources

In the `examples/batch_app` directory, run the following `just` commands:

```bash
# plan and apply batch resources
just plan-apply

# output batch resources
just output
```

## Submit a Job to Job Queue

```bash
# submit a job to ec2 job queue
just submit ec2-job

# submit a job to fargate job queue
just submit fargate-job
```

## Clean up Resources

```bash
just destroy-apply
```
