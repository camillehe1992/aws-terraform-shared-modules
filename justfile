# justfile - Task runner for Terraform workflows
# Usage: just plan [UNIT]
# Example: just plan <example-name>

# Project root directory (where the justfile is located)
PROJECT_ROOT := `pwd`

# Shell to use
set shell := ["bash", "-uc"]

#export TF_PLUGIN_CACHE_DIR := "~/.terraform.d/plugin-cache"

# ------------------------------------------------------------------------------
# Helper functions (as recipes)
# ------------------------------------------------------------------------------
version:
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

# Pre-check - Verify AWS credentials
pre-check:
    #!/usr/bin/env bash
    PROFILE=$(just aws-profile)
    echo "[*] Pre-Check - AWS Profile ${PROFILE}"
    AWS_PROFILE=${PROFILE} aws sts get-caller-identity | jq .

plan UNIT:
    #!/usr/bin/env bash
    PROFILE=$(just aws-profile)
    TF_DIR=$(just tf-unit-dir {{UNIT}})
    echo "[*] Planning - Terraform Unit ${TF_DIR}"
    AWS_PROFILE=${PROFILE} terraform -chdir=${TF_DIR} init -input=false && terraform -chdir=${TF_DIR} plan -input=false

apply UNIT:
    #!/usr/bin/env bash
    PROFILE=$(just aws-profile)
    TF_DIR=$(just tf-unit-dir {{UNIT}})
    echo "[*] Applying - Terraform Unit ${TF_DIR}"
    AWS_PROFILE=${PROFILE} terraform -chdir=${TF_DIR} apply -auto-approve -input=false

plan-apply UNIT:
    #!/usr/bin/env bash
    PROFILE=$(just aws-profile)
    TF_DIR=$(just tf-unit-dir {{UNIT}})
    just plan {{UNIT}}
    echo "[*] Planning and Applying - Terraform Unit ${TF_DIR}"
    AWS_PROFILE=${PROFILE} terraform -chdir=${TF_DIR} apply -auto-approve -input=false

destroy UNIT:
    #!/usr/bin/env bash
    PROFILE=$(just aws-profile)
    TF_DIR=$(just tf-unit-dir {{UNIT}})
    echo "[*] Destroying - Terraform Unit ${TF_DIR}"
    AWS_PROFILE=${PROFILE} terraform -chdir=${TF_DIR} destroy -auto-approve -input=false

tf-validate UNIT:
  echo "Validating examples/{{UNIT}}..."
  cd examples/{{UNIT}} && terraform validate

tf-fmt:
  echo "Formatting examples..."
  for dir in examples/*; do if [ -d "$dir" ]; then (cd "$dir" && terraform fmt -recursive); fi; done
  echo "Formatting shared-modules..."
  for dir in shared-modules/*; do if [ -d "$dir" ]; then (cd "$dir" && terraform fmt -recursive); fi; done

tf-lint:
  echo "Linting examples..."
  for dir in examples/*; do if [ -d "$dir" ]; then (cd "$dir" && terraform fmt -check -recursive && terraform init -backend=false -input=false && terraform validate); fi; done
  echo "Linting shared-modules..."
  for dir in shared-modules/*; do if [ -d "$dir" ]; then (cd "$dir" && terraform fmt -check -recursive && terraform init -backend=false -input=false && terraform validate); fi; done

clean:
  echo "[*] Cleaning up temporary files"
  find {{PROJECT_ROOT}} -type d -name ".terragrunt-cache" -exec rm -rf {} + 2>/dev/null || true
  find {{PROJECT_ROOT}} -type d -name ".terraform" -exec rm -rf {} + 2>/dev/null || true
  find {{PROJECT_ROOT}} -type f -name "*.tfstate*" -delete
  echo "[*] Cleaning up completed"


md-lint:
  echo "Linting markdown files..."
  markdownlint "**/*.md"


generate-module-docs:
  echo "Generating documentation for shared-modules..."
  for dir in shared-modules/*; do if [ -d "$dir" ]; then (cd "$dir" && terraform-docs markdown table --output-file README.md --output-mode inject --config ../../.terraform-docs.yaml .); fi; done
