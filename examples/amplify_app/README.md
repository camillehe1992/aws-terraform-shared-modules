# Deploy Application in AWS Amplify

The example is used to deploy an application in AWS Amplify.

The example is based on the following module:

| Module      | Description                           |
| ----------- | ------------------------------------- |
| amplify_app | Deploy an application in AWS Amplify. |

The application variables are defined in `tfvar.json` file.

## Provision Resources

in the `examples/amplify_app` directory, run the following `just` commands:

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
