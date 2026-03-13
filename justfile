# justfile - Task runner for Terraform workflows
# Usage: just plan [UNIT]
# Example: just plan unit-name

# Project root directory (where the justfile is located)
PROJECT_ROOT := `pwd`

# Shell to use
set shell := ["bash", "-uc"]

# ------------------------------------------------------------------------------
# Helper functions (as recipes)
# ------------------------------------------------------------------------------
versions:
    #!/usr/bin/env bash
    echo "Show version information for installed tools..."
    echo "Terraform version: $(terraform version)"
    echo "AWS Version $(aws --version)"
    which terraform
    echo "markdownlint-cli version: $(markdownlint --version)"
    echo "terraform-docs version: $(terraform-docs --version)"
    echo "pre-commit version: $(pre-commit -V)"

# Get AWS profile from .env or fallback to "app-deployer"
aws-profile:
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

# ------------------------------------------------------------------------------
# Path helpers (as recipes)
# ------------------------------------------------------------------------------

# Terraform unit directory
tf-unit-dir UNIT:
    #!/usr/bin/env bash
    echo "{{PROJECT_ROOT}}/examples/{{UNIT}}/"

# ------------------------------------------------------------------------------
# Core commands
# ------------------------------------------------------------------------------

init-module UNIT:
    #!/usr/bin/env bash
    echo "[*] Initializing - New Terraform Module"
    cp -r shared-modules/_module_template shared-modules/{{UNIT}}
    cp -r examples/_example_template examples/{{UNIT}}

remove-module UNIT:
    #!/usr/bin/env bash
    echo "[*] Removing - Terraform Module {{UNIT}}"
    rm -rf shared-modules/{{UNIT}}
    rm -rf examples/{{UNIT}}

# Pre-check - Verify AWS credentials
pre-check:
    #!/usr/bin/env bash
    PROFILE=$(just aws-profile)
    echo "[*] Pre-Check - AWS Profile ${PROFILE}"
    AWS_PROFILE=${PROFILE} aws sts get-caller-identity | jq .

init UNIT:
    #!/usr/bin/env bash
    PROFILE=$(just aws-profile)
    TF_DIR=$(just tf-unit-dir {{UNIT}})
    echo "[*] Initializing - Terraform Unit ${TF_DIR}"
    cd ${TF_DIR} && AWS_PROFILE=${PROFILE} terraform init -input=false

plan UNIT:
    #!/usr/bin/env bash
    just init {{UNIT}}
    PROFILE=$(just aws-profile)
    TF_DIR=$(just tf-unit-dir {{UNIT}})
    echo "[*] Planning - Terraform Unit ${TF_DIR}"
    cd ${TF_DIR} && AWS_PROFILE=${PROFILE} terraform plan -input=false -out=tfplan

apply UNIT:
    #!/usr/bin/env bash
    PROFILE=$(just aws-profile)
    TF_DIR=$(just tf-unit-dir {{UNIT}})
    echo "[*] Applying - Terraform Unit ${TF_DIR}"
    cd ${TF_DIR} && AWS_PROFILE=${PROFILE} terraform apply -auto-approve -input=false tfplan

destroy UNIT:
    #!/usr/bin/env bash
    just init {{UNIT}}
    PROFILE=$(just aws-profile)
    TF_DIR=$(just tf-unit-dir {{UNIT}})
    echo "[*] Destroying - Terraform Unit ${TF_DIR}"
    cd ${TF_DIR} && AWS_PROFILE=${PROFILE} terraform destroy -auto-approve -input=false

plan-apply UNIT:
    #!/usr/bin/env bash
    just plan {{UNIT}}
    PROFILE=$(just aws-profile)
    TF_DIR=$(just tf-unit-dir {{UNIT}})
    echo "[*] Planning and Applying - Terraform Unit ${TF_DIR}"
    cd ${TF_DIR} && AWS_PROFILE=${PROFILE} terraform apply -auto-approve -input=false tfplan

validate UNIT:
    #!/usr/bin/env bash
    echo "Validating examples/{{UNIT}}..."
    cd examples/{{UNIT}} && terraform validate

fmt:
    #!/usr/bin/env bash
    echo "Formatting examples..."
    for dir in examples/*; do if [ -d "$dir" ]; then (cd "$dir" && terraform fmt -recursive); fi; done
    echo "Formatting shared-modules..."
    for dir in shared-modules/*; do if [ -d "$dir" ]; then (cd "$dir" && terraform fmt -recursive); fi; done

lint:
    #!/usr/bin/env bash
    echo "Linting examples..."
    for dir in examples/*; do if [ -d "$dir" ]; then (cd "$dir" && terraform fmt -check -recursive && terraform init -backend=false -input=false && terraform validate); fi; done
    echo "Linting shared-modules..."
    for dir in shared-modules/*; do if [ -d "$dir" ]; then (cd "$dir" && terraform fmt -check -recursive && terraform init -backend=false -input=false && terraform validate); fi; done

clean:
    #!/usr/bin/env bash
    echo "[*] Cleaning up temporary files"
    find {{PROJECT_ROOT}} -type d -name ".terragrunt-cache" -exec rm -rf {} + 2>/dev/null || true
    find {{PROJECT_ROOT}} -type d -name ".terraform" -exec rm -rf {} + 2>/dev/null || true
    find {{PROJECT_ROOT}} -type f -name "*.tfstate*" -delete
    echo "[*] Cleaning up completed"

lint-md:
    #!/usr/bin/env bash
    echo "Linting markdown files..."
    markdownlint "**/*.md"

gen-docs:
    #!/usr/bin/env bash
    echo "Generating documentation for shared-modules..."
    for dir in shared-modules/*; do if [ -d "$dir" ]; then (cd "$dir" && terraform-docs markdown table --output-file README.md --output-mode inject --config ../../.terraform-docs.yaml .); fi; done
