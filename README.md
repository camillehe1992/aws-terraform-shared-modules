# AWS Terraform Shared Modules

![Terraform](https://img.shields.io/badge/Terraform-1.14.0%2B-blue.svg)
![AWS](https://img.shields.io/badge/AWS-2.11.3%2B-orange.svg)
[![Release](https://img.shields.io/github/v/release/camillehe1992/aws-terraform-shared-modules)](https://github.com/camillehe1992/aws-terraform-shared-modules/releases)

The repository contains a collection of reusable Terraform modules for AWS. These modules are designed to help you create and manage AWS resources more efficiently.

## Available Shared Modules

| Module Name                                                                       | Description                                             |
| --------------------------------------------------------------------------------- | ------------------------------------------------------- |
| [amplify_app](./shared-modules/amplify_app/README.md)                             | Create Amplify app with custom config                   |
| [api_gateway](./shared-modules/api_gateway/README.md)                             | Create API Gateway with OpenAPI body [Regional or Edge] |
| [batch_compute_environment](./shared-modules/batch_compute_environment/README.md) | Create Batch compute environment with Fargate or EC2    |
| [batch_job_definition](./shared-modules/batch_job_definition/README.md)           | Create Batch job definition with container              |
| [batch_job_queue](./shared-modules/batch_job_queue/README.md)                     | Create Batch job queue with priority                    |
| [ecs_cluster](./shared-modules/ecs_cluster/README.md)                             | Create ECS cluster with Fargate or EC2                  |
| [eventbridge_rule](./shared-modules/eventbridge_rule/README.md)                   | Create eventbridge rule with targets                    |
| [iam_role](./shared-modules/iam_role/README.md)                                   | Create IAM role with policies                           |
| [lambda_function](./shared-modules/lambda_function/README.md)                     | Create Lambda function with package                     |
| [lambda_layer](./shared-modules/lambda_layer/README.md)                           | Create Lambda layer with package                        |
| [s3_static_website](./shared-modules/s3_static_website/README.md)                 | Create S3 bucket with static website hosting            |
| [secretsmanager_secret](./shared-modules/secretsmanager_secret/README.md)         | Create secret with version                              |
| [security_group](./shared-modules/security_group/README.md)                       | Create security group with rules                        |
| [sns_topic](./shared-modules/sns_topic/README.md)                                 | Create SNS topic with subscription                      |

## Module Usage

Use below code to create an IAM role in your Terraform infrastructure:

> Make sure always use semantic versioning for module source.

```hcl
module "demo" {
  source = "github.com/heyachao/aws-terraform-shared-modules//shared-modules/iam_role?ref=v0.0.1"
  role_name   = "exmaple-iam-role"
}

output "role_arn" {
  value = module.demo.role_arn
}
```

## Get Started

### Setup Development Environment

For MacOS users, you can use Homebrew to install Terraform and AWS CLI and other necessary packages using `brew` as below:

  ```bash
  brew install awscli terraform just markdownlint-cli terraform-docs pre-commit checkov trivy
  ```

Run `pre-commit install` to install pre-commit hooks on your local repository.

For Windows/Linux users, you can find installation guide for necessary packages on their official websites.

- [Terraform Installation Guide](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- [AWS CLI Installation Guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- [just Installation Guide](https://github.com/casey/just#installation)
- [markdownlint-cli Installation Guide](https://github.com/DavidAnson/markdownlint-cli#installation)
- [terraform-docs Installation Guide](https://terraform-docs.io/user-guide/installation/)
- [pre-commit Installation Guide](https://pre-commit.com/#install)
- [checkov Installation Guide](https://www.checkov.io/1.Getting%20Started/installation.html)
- [trivy Installation Guide](https://aquasecurity.github.io/trivy/v0.40/getting-started/installation/)

Then run `just versions` to verify the installation.

After installation, you need to set up AWS credentials for Terraform to use. Please follow the [Official Guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-quickstart.html).

Then run `just pre-check` to verify AWS credentials are set up correctly.

### Clone the Repository

```bash
git clone https://github.com/heyachao/aws-terraform-shared-modules.git
cd aws-terraform-shared-modules
```

You can get started on the `_template` module as below:

```bash
just init _template
just plan _template
just apply _template
just output _template
```

### Create a New Shared Module

Create a new shared module using `just init-module` recipe as below:

```bash
just init-module <new-module-name>
```

Clean up generated modules files and example files using `just remove-module` recipe as below if you are sure:

```bash
just remove-module <new-module-name>
```

### Just Recipes

We use `just` to manage common tasks. Please refer to the `justfile` for available recipes.

__Basic Recipes:__

- `just help`: Show help message for available recipes
- `just versions`: Show version information for installed tools
- `just clean`: Clean up generated files
- `just lint-md`: Lint Markdown files using `markdownlint-cli`
- `just pre-check`: Show current AWS profile

__Terraform Recipes:__

- `just init <module-name>`: Initialize Terraform module
- `just plan <module-name>`: Plan Terraform module
- `just plan-destroy <module-name>`: Plan Terraform module with -destroy
- `just apply <module-name>`: Apply Terraform module
- `just validate <module-name>`: Validate Terraform module

- `just plan-apply <module-name>`: Plan and apply Terraform module, equivalent to `just plan <module-name> && just apply <module-name>`
- `just destroy-apply <module-name>`: Plan and destroy Terraform module, equivalent to `just plan-destroy <module-name> && just apply <module-name>`

- `just fmt-all`: Format all Terraform files using `terraform fmt`
- `just gen-docs`: Generate Terraform documentation using `terraform-docs`

## Release Process

Use GitHub Actions to release new versions of the modules. Please refer to the [tag-and-release.yml](./.github/workflows/tag-and-release.yml) workflow for release process.

The workflow uses [https://github.com/mathieudutour/github-tag-action](https://github.com/mathieudutour/github-tag-action) as the core component to create tag version and release which is semantic versioning based on the commit messages.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request.

## References

- [Terraform Documentation](https://www.terraform.io/docs/index.html)
- [AWS CLI Documentation](https://docs.aws.amazon.com/cli/latest/userguide/index.html)
- [just Documentation](https://github.com/casey/just#readme)
- [markdownlint-cli Documentation](https://github.com/DavidAnson/markdownlint-cli#readme)
- [terraform-docs Documentation](https://terraform-docs.io/user-guide/installation/)
