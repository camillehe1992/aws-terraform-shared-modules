---
name: "generate-example-readme"
description: "Generates a standard README.md for any example in examples/ folder. Invoke when user asks to create or update example documentation."
---

# Generate Example README

## When to invoke
- User says “create README for examples/XYZ”
- User asks to “document an example”
- Any request to auto-generate example docs with a fixed template

## Template used
The skill produces a README.md with these sections:

1. Title (example name)
2. One-sentence purpose
3. Quick-start copy-paste commands (using just recipes)
4. Clean-up command (using just recipes)
5. Link back to the shared module used

## Usage inside Trae
1. Detect which example folder the user wants documented
2. Render the template below into `examples/<folder>/README.md`
3. Show the generated file to the user for review

## Template (Jinja2-style placeholders)

```markdown
# {{ example_name }}

{{ short_description }}

## Quick start

```bash
just init {{ example_name }}
just plan {{ example_name }}
just apply {{ example_name }}
```

## Clean up

```bash
just destroy-apply {{ example_name }}
```

## Module used
- Source: `{{ module_source }}`
```

Fill placeholders by scanning the example’s `main.tf`, `variables.tf`, `outputs.tf` and the module’s source path.
