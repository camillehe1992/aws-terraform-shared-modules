# Deploy Lambda Layer in AWS

The example is used to demostrate the usage of Lambda layer shared module in AWS.

The example uses the following shared modules:

| Shared Module | Description         |
| ------------- | ------------------- |
| lambda_layer  | Create Lambda layer |

## Provision Resources

in the `examples/lambda_layer` directory, run the following `just` commands:

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
