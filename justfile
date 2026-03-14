# justfile - Task runner for Terraform workflows
# Usage: just plan [MODULE_NAME]
# Example: just plan _template

# Project root directory (where the justfile is located)
PROJECT_ROOT := `pwd`

# Shell to use
set shell := ["bash", "-uc"]
set dotenv-load := true

# ------------------------------------------------------------------------------
# Helper functions (as recipes)
# ------------------------------------------------------------------------------
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

# Terraform module directory
tf-module-dir module-name:
    #!/usr/bin/env bash
    echo "{{PROJECT_ROOT}}/shared-modules/{{module-name}}/"

# ------------------------------------------------------------------------------
# Core commands
# ------------------------------------------------------------------------------

init-module module-name:
    #!/usr/bin/env bash
    echo "[*] Initializing - Terraform Module {{module-name}}"
    cp -r shared-modules/_template shared-modules/{{module-name}}
    cp -r examples/_template examples/{{module-name}}

remove-module module-name:
    #!/usr/bin/env bash
    echo "[*] Removing - Terraform Module {{module-name}}"
    rm -rf shared-modules/{{module-name}}
    rm -rf examples/{{module-name}}

pre-check:
    #!/usr/bin/env bash
    PROFILE=$(just aws-profile)
    echo "[*] Pre-Check - AWS Profile ${PROFILE}"
    AWS_PROFILE=${PROFILE} aws sts get-caller-identity | jq .

init module-name:
    #!/usr/bin/env bash
    PROFILE=$(just aws-profile)
    TF_DIR=$(just tf-module-dir {{module-name}})
    echo "[*] Initializing - Terraform Module ${TF_DIR}"
    cd ${TF_DIR} && AWS_PROFILE=${PROFILE} terraform init -input=false
    just validate {{module-name}}

validate module-name:
    #!/usr/bin/env bash
    echo "[*] Validating - Terraform Module {{module-name}}..."
    TF_DIR=$(just tf-module-dir {{module-name}})
    cd ${TF_DIR} && terraform validate
    echo "[*] Validation completed"

tf-options module-name:
    #!/usr/bin/env bash
    # if tfvars.json exist, use it as var-file
    TF_DIR=$(just tf-module-dir {{module-name}})
    if [ -f "${TF_DIR}/tfvars.json" ]; then
        VAR_OPTIONS="-var-file=${TF_DIR}/tfvars.json"
    else
        VAR_OPTIONS=""
    fi
    echo "${VAR_OPTIONS}"

plan module-name:
    #!/usr/bin/env bash
    just init {{module-name}}
    PROFILE=$(just aws-profile)
    TF_DIR=$(just tf-module-dir {{module-name}})
    VAR_OPTIONS=$(just tf-options {{module-name}})
    echo "[*] Planning - Terraform Module ${TF_DIR}"
    cd ${TF_DIR} && AWS_PROFILE=${PROFILE} terraform plan ${VAR_OPTIONS} -input=false -out=tfplan

plan-destroy module-name:
    #!/usr/bin/env bash
    just init {{module-name}}
    PROFILE=$(just aws-profile)
    TF_DIR=$(just tf-module-dir {{module-name}})
    VAR_OPTIONS=$(just tf-options {{module-name}})
    echo "[*] Plan Destroying - Terraform Module ${TF_DIR}"
    cd ${TF_DIR} && AWS_PROFILE=${PROFILE} terraform plan -destroy ${VAR_OPTIONS} -auto-approve -input=false

apply module-name:
    #!/usr/bin/env bash
    PROFILE=$(just aws-profile)
    TF_DIR=$(just tf-module-dir {{module-name}})
    echo "[*] Applying - Terraform Module ${TF_DIR}"
    cd ${TF_DIR} && AWS_PROFILE=${PROFILE} terraform apply -auto-approve -input=false tfplan
    just fmt-all

output module-name:
    #!/usr/bin/env bash
    TF_DIR=$(just tf-module-dir {{module-name}})
    echo "[*] Outputting - Terraform Module ${TF_DIR}"
    cd ${TF_DIR} && terraform output

plan-apply module-name:
    #!/usr/bin/env bash
    just plan {{module-name}}
    just apply {{module-name}}

destroy-apply module-name:
    #!/usr/bin/env bash
    just plan-destroy {{module-name}}
    just apply {{module-name}}

fmt-all:
    #!/usr/bin/env bash
    echo "[*] Formatting examples and shared-modules..."
    for dir in examples/*; do if [ -d "$dir" ]; then (cd "$dir" && terraform fmt -recursive); fi; done
    for dir in shared-modules/*; do if [ -d "$dir" ]; then (cd "$dir" && terraform fmt -recursive); fi; done
    echo "[*] Formatting completed"

clean:
    #!/usr/bin/env bash
    echo "[*] Cleaning up temporary files"
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
