# AWS Terraform Shared Modules

A overview description for the repository

## Available Shared Modules

| Module Name                                                               | Example                                                             | Description                          |
| ------------------------------------------------------------------------- | ------------------------------------------------------------------- | ------------------------------------ |
| [eventbridge_rule](./shared-modules/eventbridge_rule/README.md)           | [eventbridge_rule](./examples/eventbridge_rule/README.md)           | Create eventbridge rule with targets |
| [iam_role](./shared-modules/iam_role/README.md)                           | [iam_role](./examples/iam_role/README.md)                           | Create IAM role with policies        |
| [secretsmanager_secret](./shared-modules/secretsmanager_secret/README.md) | [secretsmanager_secret](./examples/secretsmanager_secret/README.md) | Create secret with version           |
| [security_group](./shared-modules/security_group/README.md)               | [security_group](./examples/security_group/README.md)               | Create security group with rules     |
| [sns_topic](./shared-modules/sns_topic/README.md)                         |                                                                     | Create SNS topic with subscriptions  |

## Module Usage

Use below code to include the module-template in your Terraform configuration:

```hcl
module "demo" {
  source = "github.com/heyachao/aws-terraform-shared-modules//shared-modules/module-template"
  name   = "world"
}

output "greeting" {
  value = module.demo.greeting
}
```

## Get Started

### Setup Development Environment

For local development, you need to install the following tools:

- Terraform: [Official Installation Guide](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- AWS CLI: [Official Installation Guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- just: [Official Installation Guide](https://github.com/casey/just#installation)
- markdownlint-cli: [Official Installation Guide](https://github.com/DavidAnson/markdownlint-cli#installation)
- terraform-docs: [Official Installation Guide](https://terraform-docs.io/user-guide/installation/)
- pre-commit: [Official Installation Guide](https://pre-commit.com/#install)

For MacOS users, you can use Homebrew to install Terraform and AWS CLI and other necessary packages using `brew` as below:

  ```bash
  brew install awscli terraform just markdownlint-cli terraform-docs pre-commit checkov trivy
  ```

Then run `just version` to verify the installation.

After installation, you need to set up AWS credentials for Terraform to use. Please follow the [Official Guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-quickstart.html).

### Clone the Repository

```bash
git clone https://github.com/heyachao/aws-terraform-shared-modules.git
cd aws-terraform-shared-modules
```

Init a new module using `just init-module` recipe as below:

```bash
just init-module <module-name>
```

Clean up generated modules files and example files using `just remove-module` recipe as below:

```bash
just remove-module <module-name>
```

### Just Recipes

We use `just` to manage common tasks. Please refer to the `justfile` for available recipes.

Basic Recipes:

- `just help`: Show help message for available recipes
- `just version`: Show version information for installed tools
- `just clean`: Clean up generated files

Terraform Commands:

- `just test`: Run Terraform tests using `terraform validate`
- `just docs`: Generate Terraform documentation using `terraform-docs`
- `just lint`: Lint Terraform code using `terraform fmt` and lint README.md using `markdownlint`
- `just validate <unit-name>`: Validate Terraform code using `terraform validate`
- `just init <unit-name>`: Initialize Terraform in the `unit-name` directory
- `just plan <unit-name>`: Show Terraform plan for the `unit-name` directory
- `just apply <unit-name>`: Apply Terraform configuration in the `unit-name` directory
- `just destroy <unit-name>`: Destroy Terraform resources in the `unit-name` directory

## Contributing

Contributions are welcome! Please open an issue or submit a pull request.

## References

- [Terraform Documentation](https://www.terraform.io/docs/index.html)
- [AWS CLI Documentation](https://docs.aws.amazon.com/cli/latest/userguide/index.html)
- [just Documentation](https://github.com/casey/just#readme)
- [markdownlint-cli Documentation](https://github.com/DavidAnson/markdownlint-cli#readme)
- [terraform-docs Documentation](https://terraform-docs.io/user-guide/installation/)
