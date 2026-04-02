# SecretsManager Secrets in AWS

The example is used to demostrate the usage of SecretsManager shared module in AWS.

The example uses the following shared modules:

| Shared Module          | Description                   |
| ---------------------- | ----------------------------- |
| secretsmanager_secrets | Create SecretsManager Secrets |

## Provision Resources

in the `examples/secretsmanager_secrets` directory, run the following `just` commands:

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
