
Create a `tf-plan-apply.yml` workflow under `.github` directory for Terraform resource deployment to target AWS account.

The `tf-plan-apply.yml` workflow will:

- OIDC authentication (no AWS keys needed)
  - `ROLE_TO_ASSUME`: ARN of the IAM role to assume (e.g., `arn:aws:iam::123456789012:role/GitHubActionsRole`)
  - `ROLE_SESSION_NAME`: Session name for the assumed role (e.g., `github-actions-session`)
  - `AWS_REGION`: Target AWS region (e.g., `ap-southeast-1`)

- Dynamic Terraform version detection
  - terraform version is fetched from source code file `.terraform-version` dynamically
- Detailed change summaries in GitHub
  - terraform plan output is parsed and formatted as a summary in GitHub PR comments
- Automatic PR comments when changes detected
  - terraform plan output is parsed and formatted as a summary in GitHub PR comments
- Environment-specific configurations
  - `ENVIRONMENT`: Target environment for deployment (e.g., `dev`, `prod`)
