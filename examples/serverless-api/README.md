# Setup a Serverless API based on AWS API Gateway and Lambda Function

The example demostrates how to use the shared modules to create an application in AWS.

The example uses the following shared modules:

| Shared Module   | Description                                   |
| --------------- | --------------------------------------------- |
| lambda_function | Create a Lambda Function with CloudWatch Logs |
| api_gateway     | Create an API Gateway with CloudWatch Logs    |

Lambda source code dir: `function/src`
Lambda Layer: [Powertools for AWS Lambda (Python)](https://docs.aws.amazon.com/powertools/python/latest/) is a developer toolkit
API Gateway schema: `openapi.yaml`

## Network Resources

In the demostration, we deploy a REGIONAL type API Gateway, which is publically accessible. SO we do not need to setup any network resources. In a real world scenario, we need to setup a proper network configuration.

## Provision Resources

in the `examples/_template` directory, run the following `just` commands:

```bash
# plan and apply resources
just quick-apply

# output resources
just output

# get invoke URL
just get-invoke-url

#[*]  Get invoke URL...
# https://xxxxxx.execute-api.<region>.amazonaws.com/dev
```

Open the invoke URL with path `/hello` in browser to test the API. You should see the response `hello from AWS Powertools`.

## Clean up Resources

For cost saving, please clean up the resources after the demo.

```bash
just quick-destroy
```
