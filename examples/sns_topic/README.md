# SNS Topic in AWS

The example is used to demostrate the usage of SNS Topic shared module in AWS.

The example uses the following shared modules:

| Shared Module | Description      |
| ------------- | ---------------- |
| sns_topic     | Create SNS Topic |

## Provision Resources

in the `examples/sns_topic` directory, run the following `just` commands:

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
