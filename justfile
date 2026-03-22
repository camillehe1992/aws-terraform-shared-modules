# justfile - Task runner for Terraform workflows
# Usage: just plan <module-name>
# Example:
#       >> just plan iam_role
#       >> just apply iam_rol
# or only run
#       >> just plan-apply iam_role

# Project root directory (where the justfile is located)
PROJECT_ROOT := `pwd`
default_module := "_template"

# Shell to use
set shell := ["bash", "-uc"]
set dotenv-load := true

# Public recipes (as recipes)
# ------------------------------------------------------------------------------

# Help for justfile
default:
    @just --list --unsorted
    @echo "Usage: just <command> [module-name](optional)"

# Show version information for installed tools
versions:
    #!/usr/bin/env bash
    echo "Show version information for installed tools..."
    echo "Terraform version: $(terraform version)"
    echo "markdownlint-cli version: $(markdownlint --version)"
    echo "terraform-docs version: $(terraform-docs --version)"
    echo "pre-commit version: $(pre-commit -V)"
    echo "checkov version: $(checkov --version)"
    echo "trivy version: $(trivy --version)"

    echo "AWS version $(aws --version)"

# Initialize a new Terraform module
init-module module-name:
    #!/usr/bin/env bash
    echo "[*] Initializing - Terraform Module {{module-name}}"
    cp -r shared-modules/_template shared-modules/{{module-name}}
    cp -r examples/_template examples/{{module-name}}
    echo "Module {{module-name}} is created"

# Remove a Terraform module
remove-module module-name:
    #!/usr/bin/env bash
    echo "[*] Removing - Terraform Module {{module-name}}"
    rm -rf shared-modules/{{module-name}}
    rm -rf examples/{{module-name}}
    echo "Module {{module-name}} is removed"

# Show current AWS profile
aws-profile:
    #!/usr/bin/env bash
    PROFILE=$(just _aws-profile)
    echo "[*] Current AWS Profile: ${PROFILE}"

# Initialize Terraform module
init module-name=default_module:
    #!/usr/bin/env bash
    PROFILE=$(just _aws-profile)
    TF_DIR=$(just _tf-example-dir {{module-name}})
    echo "[*] Initializing - Terraform Module ${TF_DIR}"
    cd ${TF_DIR} && AWS_PROFILE=${PROFILE} terraform init -input=false

# Validate Terraform module
validate module-name=default_module:
    #!/usr/bin/env bash
    echo "[*] Validating - Terraform Module {{module-name}}..."
    TF_DIR=$(just _tf-module-dir {{module-name}})
    cd ${TF_DIR} && terraform validate
    echo "[*] Validation completed"

# Plan Terraform module
plan module-name=default_module:
    #!/usr/bin/env bash
    just init {{module-name}}
    PROFILE=$(just _aws-profile)
    TF_DIR=$(just _tf-example-dir {{module-name}})
    VAR_OPTIONS=$(just _tf-options {{module-name}})
    echo "[*] Planning - Terraform Module ${TF_DIR}"
    cd ${TF_DIR} && AWS_PROFILE=${PROFILE} terraform plan ${VAR_OPTIONS} -input=false -out=tfplan

# Plan destroy Terraform module
plan-destroy module-name=default_module:
    #!/usr/bin/env bash
    just init {{module-name}}
    PROFILE=$(just _aws-profile)
    TF_DIR=$(just _tf-example-dir {{module-name}})
    VAR_OPTIONS=$(just _tf-options {{module-name}})
    echo "[*] Plan Destroying - Terraform Module ${TF_DIR}"
    cd ${TF_DIR} && AWS_PROFILE=${PROFILE} terraform plan -destroy ${VAR_OPTIONS} -input=false -out=tfplan

# Apply Terraform module
apply module-name=default_module:
    #!/usr/bin/env bash
    PROFILE=$(just _aws-profile)
    TF_DIR=$(just _tf-example-dir {{module-name}})
    echo "[*] Applying - Terraform Module ${TF_DIR}"
    cd ${TF_DIR} && AWS_PROFILE=${PROFILE} terraform apply -auto-approve -input=false tfplan
    just fmt-all

output module-name=default_module:
    #!/usr/bin/env bash
    just init {{module-name}}
    PROFILE=$(just _aws-profile)
    TF_DIR=$(just _tf-example-dir {{module-name}})
    cd ${TF_DIR} && AWS_PROFILE=${PROFILE} terraform output -json | jq .

# Plan and apply Terraform module
plan-apply module-name=default_module:
    #!/usr/bin/env bash
    just plan {{module-name}}
    just apply {{module-name}}

# Plan and destroy Terraform module
destroy-apply module-name=default_module:
    #!/usr/bin/env bash
    just plan-destroy {{module-name}}
    just apply {{module-name}}

# Format all Terraform modules and examples
fmt-all:
    #!/usr/bin/env bash
    echo "[*] Formatting examples and shared-modules..."
    for dir in examples/*; do if [ -d "$dir" ]; then (cd "$dir" && terraform fmt -recursive); fi; done
    for dir in shared-modules/*; do if [ -d "$dir" ]; then (cd "$dir" && terraform fmt -recursive); fi; done
    echo "[*] Formatting completed"

# Clean up temporary files
clean:
    #!/usr/bin/env bash
    echo "[*] Cleaning up temporary files"
    find {{PROJECT_ROOT}} -type d -name ".terraform" -exec rm -rf {} + 2>/dev/null || true
    find {{PROJECT_ROOT}} -type f -name "*.tfstate*" -delete
    echo "[*] Cleaning up completed"

# Lint markdown files
lint-md:
    #!/usr/bin/env bash
    echo "Linting markdown files..."
    markdownlint "**/*.md"

# Generate documentation for shared-modules
gen-docs:
    #!/usr/bin/env bash
    echo "Generating documentation for shared-modules..."
    for dir in shared-modules/*; do
        if [ -d "$dir" ]; then
            (cd "$dir"
            terraform-docs markdown table --output-file README.md --output-mode inject --config ../../.terraform-docs.yaml .
            sed -i '' 's|examples/REPLACE_ME|examples/'$(basename "$dir")'|g' README.md)
        fi;
    done

# Private recipes (as recipes)
# ------------------------------------------------------------------------------

# Get AWS profile from .env or fallback to "app-deployer"
_aws-profile:
    #!/usr/bin/env bash
    # Check if running in GitHub Actions
    if [ -n "$GITHUB_ACTIONS" ]; then
        # In GitHub Actions with OIDC, we don't use named profiles
        # The credentials are already set by configure-aws-credentials
        echo ""
    elif [ -f .env ]; then
        source .env && echo "${AWS_PROFILE:-app-deployer}"
    else
        echo "app-deployer"
    fi

# Get Terraform module directory
_tf-module-dir module-name:
    #!/usr/bin/env bash
    echo "{{PROJECT_ROOT}}/shared-modules/{{module-name}}/"

_tf-example-dir module-name:
    #!/usr/bin/env bash
    echo "{{PROJECT_ROOT}}/examples/{{module-name}}/"

# Get Terraform options
_tf-options module-name=default_module:
    #!/usr/bin/env bash
    # if tfvars.json exist, use it as var-file
    TF_DIR=$(just _tf-example-dir {{module-name}})
    if [ -f "${TF_DIR}/tfvars.json" ]; then
        VAR_OPTIONS="-var-file=${TF_DIR}/tfvars.json"
    else
        VAR_OPTIONS=""
    fi
    echo "${VAR_OPTIONS}"
