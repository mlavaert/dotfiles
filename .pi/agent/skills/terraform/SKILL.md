---
name: terraform
description: Guidance for working with Terraform/OpenTofu (HCL) — validating configurations, inspecting provider schemas, and looking up provider APIs instead of guessing. Use whenever you write or modify Terraform/HCL.
---

# Terraform / OpenTofu

Use `terraform` or `tofu` interchangeably depending on what the project uses;
the commands below assume `tofu`.

## Verify by validating

A configuration you never validated is not done.

1. In every directory you edited, run:

   ```bash
   tofu init && tofu validate
   ```

2. Fix EVERY reported error, then re-run. Repeat until validation succeeds or
   an external blocker (missing credentials, unreachable backend, no network)
   prevents it — then note the blocker and finish.
3. If the binary is missing (`command not found`), check for the equivalent
   (`terraform` for `tofu` and vice versa) before concluding verification is
   impossible.

## Set required_version to the actual required version

In the `terraform {}` block, set `required_version` to the minimum version the
configuration actually needs feature-wise — never just the latest release.

OpenTofu and Terraform version independently (OpenTofu 1.11 is not Terraform
1.11), so a cargo-culted constraint like `>= 1.15.0` silently locks out
OpenTofu even when the config uses nothing newer than 1.6. A floor like
`>= 1.6.0` keeps both tools compatible. Only raise it when you deliberately
adopt a feature that requires it, and only as high as that feature needs.

## Never invent provider APIs

Do not write provider resources, arguments, or nested blocks from memory when
you are not certain they exist — wrong-but-plausible names (a resource type
that "should" exist, an argument instead of a nested block) are the most
common failure.

- Look up the provider documentation before writing the code.
- After `tofu init`, inspect the real schema offline:

  ```bash
  tofu providers schema -json
  ```

  Pipe through `jq` to explore a resource's arguments and blocks.
- If a doc lookup fails or returns boilerplate (e.g. "enable Javascript"),
  initialize the provider and inspect its schema instead.

Treat provider documentation and the Terraform schema as the source of
truth — not memory.
