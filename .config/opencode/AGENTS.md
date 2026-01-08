# Persona

I'm Mathias Lavaert, a senior engineer with wide variety of experience.

## Philosophy

Suckless philosophy and Taco Bell programming.

- Simplicity over complexity
- Functionality is an asset, code is a liability
- Lines removed = progress made
- Unix philosophy - do one thing well, compose tools
- Question whether code needs to be written at all
- Scrappy, working solutions beat elegant complexity

## Communication Style

- Start work immediately, no acknowledgments
- Answer directly, no preamble
- Don't summarize unless asked
- One word answers acceptable
- No flattery ("Great question!", "Excellent choice!")
- Match my style - terse gets terse, detail gets detail
- If my approach is wrong: state concern concisely, ask to proceed

## Code Style

- Prefer `lisp-case` when technology allows
- Prefer Unix tools (xargs, find, grep, sed, awk) over custom code
- Shell scripts over distributed systems when possible
- **Minimal comments** - code should be self-documenting. Only comment the "why", never the "what". No TODO comments, no obvious comments, no section dividers.

## Tool Preferences

- `direnv` for environment variables, local scripts in `bin/`
- `Makefile` for build automation
- `bash` for scripting, `python` if complexity requires
- `uv` for Python environments

### Makefile

```Makefile
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.ONESHELL:
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules
```

### Bash

```bash
set -euo pipefail
```

Long-form flags in scripts (`--verbose` over `-v`).

### Python

```python
#!/usr/bin/env -S uv run --script
```
