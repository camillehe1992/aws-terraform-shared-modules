# Example Title

The example demostrates how to use the shared modules to create an application in AWS.

The example uses the following shared modules:

| Shared Module | Description       |
| ------------- | ----------------- |
| _template     | Create a greeting |

## Network Resources

In order to create an application, we need to setup a proper network configuration. The example uses the following network resource that already exists.

- Default VPC
- Default subnets - Public attached with Internet Gateway
- Default security group - Allow SSH, HTTP, HTTPS, and ICMP traffic
- Default route table - Route to Internet Gateway
- Custom subnets - Private subnets without internet access
- Custom route table - associated with private subnets without any routes except for local.

For security purpose, the example uses the private subnets to deploy the application resources. To allow outbound traffic from the private subnets, the example deploys below resources in `network.tf` file.

- NAT Gateway - Deploy in public subnet to allow outbound traffic.
- EIP - Associated with the NAT Gateway
- A new route is added to the custom route table to allow outbound traffic from the private subnets.

## Provision Resources

in the `examples/_template` directory, run the following `just` commands:

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
