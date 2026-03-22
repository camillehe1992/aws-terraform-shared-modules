---
name: "generate-example-readme"
description: "Creates a concise README.md for any example in examples/ using just commands. Invoke when user asks to document an example."
---

# Generate Example README

## Template (copy into `examples/<name>/README.md`)

```markdown
# examples/{{ EXAMPLE_NAME }}

{{ SHORT_PURPOSE }}

## Quick start

```bash
just plan {{ EXAMPLE_NAME }}
just apply {{ EXAMPLE_NAME }}
```

## Show outputs

```bash
just output {{ EXAMPLE_NAME }}
```

## Clean up

```bash
just destroy-apply {{ EXAMPLE_NAME }}
```

## Module used

- Source: `../../shared-modules/{{ MODULE_NAME }}`
```

## How to use inside Trae

1. Detect which example folder the user wants documented
2. Replace placeholders:
   - `{{ EXAMPLE_NAME }}` → folder name (`basename $(pwd)` inside example)
   - `{{ SHORT_PURPOSE }}` → one-sentence purpose (scan main.tf or ask user)
   - `{{ MODULE_NAME }}` → folder name of the shared-module used in `source = "../<module>"`
3. Write the file and show it to the user for review
