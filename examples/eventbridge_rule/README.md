# Deploy EventBridge Rules in AWS

The example is used to demostrate the usage of EventBridge rules in AWS.

The example uses the following shared modules:

| Shared Module    | Description              |
| ---------------- | ------------------------ |
| eventbridge_rule | Create EventBridge rules |

## Provision Resources

in the `examples/eventbridge_rule` directory, run the following `just` commands:

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
