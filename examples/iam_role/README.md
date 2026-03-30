# Deploy IAM Role in AWS

The example is used to demostrate the usage of IAM role shared module in AWS.

The example uses the following shared modules:

| Shared Module | Description     |
| ------------- | --------------- |
| iam_role      | Create IAM role |

## Provision Resources

in the `examples/iam_role` directory, run the following `just` commands:

```bash
# plan and apply resources
just plan-apply

# output resources
just output
```

## Clean up Resources

For cost saving, please clean up the resources after the demo.

```bash
just destroy-apply
```
