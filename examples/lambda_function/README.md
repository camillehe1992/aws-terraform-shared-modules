# Deploy Lambda Function in AWS

The example is used to demostrate the usage of Lambda function shared module in AWS.

The example uses the following shared modules:

| Shared Module   | Description            |
| --------------- | ---------------------- |
| lambda_function | Create Lambda function |

## Provision Resources

in the `examples/lambda_function` directory, run the following `just` commands:

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
