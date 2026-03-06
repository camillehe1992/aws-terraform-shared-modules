# Repository Structure Scaffolding Documentation

## Step 1. Build directory structure

Use the following command to build the directory structure:

```bash
mkdir -p shared-modules
mkdir -p scripts
mkdir -p examples

# Create module template directory
mkdir -p shared-modules/module-template
touch shared-modules/module-template/{main.tf,variables.tf,outputs.tf,provider.tf}

mkdir -p examples/README.md
mkdir -p examples/example-template
touch examples/example-template/{main.tf,variables.tf,outputs.tf,provider.tf}

# Create markdownlint configuration file
touch .markdownlint.json
# Create terraform-docs configuration file
touch .terraform-docs.yaml
# Create justfile
touch justfile
```

## Step 2. Add below content to `.markdownlint.json` file

```json
{
  "MD013": false,
  "MD033": false,
  "MD041": false
}
```

## Step 3. Add below content to `.terraform-docs.yaml` file

```yaml
formatter: "" # this is required

version: ""

header-from: main.tf
footer-from: ""

recursive:
  enabled: false
  path: modules
  include-main: true

sections:
  hide: []
  show: []

  hide-all: false # deprecated in v0.13.0, removed in v0.15.0
  show-all: true # deprecated in v0.13.0, removed in v0.15.0

content: ""

output:
  file: ""
  mode: inject
  template: |-
    <!-- BEGIN_TF_DOCS -->
    {{ .Content }}
    <!-- END_TF_DOCS -->

output-values:
  enabled: false
  from: ""

sort:
  enabled: true
  by: name

settings:
  anchor: true
  color: true
  default: true
  description: false
  escape: true
  hide-empty: false
  html: true
  indent: 2
  lockfile: true
  read-comments: true
  required: true
  sensitive: true
  type: true
```

## Step 4. Add content to `examples/example-template/{main.tf,variables.tf,outputs.tf,provider.tf}` files

Add a sample example terraform code content in `examples/example-template` directory.

## Step 5. Add content to  `shared-modules/module-template` directory

Add a sample example terraform code content in `shared-modules/module-template/main.tf` file.
Add a sample example terraform code content in `shared-modules/module-template/variables.tf` file.
Add a sample example terraform code content in `shared-modules/module-template/outputs.tf` file.

## Step 6. Add below content to `justfile` file

```bash
# Lint markdown files
lint-markdown:
  markdownlint .

# Generate terraform-docs
generate-docs:
  terraform-docs yaml .

# Run all lint checks
lint: lint-markdown generate-docs
```

## Step 7. Add Recipes into `justfile`

Use just recipes to run terraform commands for each example in `examples/example-template` directory.
Define variable `UNIT` in `justfile` to parameterize the example name. variable `UNIT` can be passed as a just recipe parameter.
For exmaple, use `just plan example-template` to run `terraform plan` for `example-template` example.

Add a just recipe `plan` to run `terraform plan` for example `UNIT`.
Add a just recipe `apply` to run `terraform apply` for example `UNIT`.
Add a just recipe `destroy` to run `terraform destroy` for example `UNIT`.
Add a just recipe `init` to run `terraform init` for example `UNIT`.
Add a just recipe `validate` to run `terraform validate` for example `UNIT`.
Add a just recipe `fmt` to run `terraform fmt` for example `UNIT`.

Add a just recipe `fmt-module` to run `terraform fmt` for all modules in `shared-modules` directory.
Add a just recipe `fmt-all` to run `terraform fmt` for all examples in `examples` directory and all modules in `shared-modules` directory.
Add a just recipe `lint-module` to lint terraform code for all modules in `shared-modules` directory.
Add a just recipe `lint-all` to lint terraform code for all examples in `examples` directory and all modules in `shared-modules` directory.

Add a just recipe `generate-module-docs` to generate README.md file for each modules in `shared-modules` directory.
