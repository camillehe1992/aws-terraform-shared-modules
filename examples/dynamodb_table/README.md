# DynamoDB Table Example Title

The example demostrates how to use the shared modules to create a DynamoDB table in AWS with optional global secondary indexes.

The example uses the following shared modules:

| Shared Module  | Description                                                    |
| -------------- | -------------------------------------------------------------- |
| dynamodb_table | Create a DynamoDB table with optional global secondary indexes |

## Network Resources

DynamoDB Table don't require any network resources to be created.

## Provision Resources

in the `examples/dynamodb_table` directory, run the following `just` commands:

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
