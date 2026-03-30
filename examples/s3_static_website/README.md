# S3 Static Website in AWS

The example is used to demostrate the usage of S3 Static Website shared module in AWS.

The example uses the following shared modules:

| Shared Module     | Description              |
| ----------------- | ------------------------ |
| s3_static_website | Create S3 Static Website |

Note: The example enables public access to the website, which is not a recommended practice in production. You need to setup a security tier in front of the S3 bucket to restrict access.

## Provision Resources

in the `examples/s3_static_website` directory, run the following `just` commands:

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
