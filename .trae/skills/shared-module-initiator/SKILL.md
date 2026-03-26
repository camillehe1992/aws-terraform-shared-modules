---
name: "shared-module-initiator"
description: "Initializes new Terraform shared-modules with proper structure and files. Invoke when user wants to create a new shared-module directory with standard Terraform files."
---

# Shared Module Initiator

This skill helps initialize new shared-modules in the `shared-modules/` directory with the proper Terraform structure and files following the repository's conventions.

## When to Invoke

Invoke this skill when:
- User wants to create a new shared-module
- User asks to initialize a new Terraform module
- User mentions creating a new module in shared-modules
- User needs to set up the basic structure for a new AWS resource module

## Process

1. **Create Module Directory**: Creates a new directory under `shared-modules/`
2. **Generate Standard Files**: Creates the following files with proper structure:
   - `main.tf` - Main resource definitions
   - `variables.tf` - Input variables with descriptions
   - `outputs.tf` - Output definitions
   - `README.md` - Module documentation
   - `.terraform.lock.hcl` - Terraform lock file (if needed)

3. **Follow Repository Patterns**: Uses existing modules as templates to maintain consistency

## Example Usage

When user says: "Create a new module for RDS instance"

The skill will:
1. Create `shared-modules/rds_instance/` directory
2. Generate appropriate Terraform files based on RDS requirements
3. Follow the naming and structure conventions from existing modules

## File Structure Generated

```bash
shared-modules/_template
├── README.md
├── main.tf
├── outputs.tf
├── tfplan
└── variables.tf
```

## Notes

- Always check existing modules for patterns and conventions
- Ensure variables have proper descriptions and types
- Follow the repository's naming conventions
- Include comprehensive outputs for the resources created
- Generate proper documentation in README.md
