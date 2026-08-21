---
name: makefile
description: Opinionated guidance for writing GNU Makefiles — sensible defaults, real file targets with prerequisites, and sentinel files. Use when writing or modifying Makefiles.
---

# Makefile

Distilled from <https://tech.davis-hansson.com/p/make/>. Guidelines, not dogma.

## Core model: Make builds files

Every rule is `<output-file>: <input files>` plus a recipe that creates the
output from the inputs. Make rebuilds only when a prerequisite is newer than
the target. Don't fight the file system — work with it.

- Targets that produce no file MUST be declared `.PHONY` — otherwise a stray
  file named like the target silently skips the recipe (a file named `test`
  means `make test` runs nothing).
- Declare real prerequisites; ask the file system instead of maintaining lists
  by hand: `$(shell find src -type f)`.
- Rules yielding many files (webpack, npm install, ...) get a single sentinel
  file as target, touched at the end of the recipe:

```make
tmp/.packed.sentinel: $(shell find src -type f)
	mkdir -p $(@D)
	webpack ..
	touch $@
```

- `$@` (the target) and `$(@D)` (its directory) are fine; avoid other magic
  variables. Use `$$` for bash variables/subshells inside recipes.

## Sensible defaults

Start every Makefile with this preamble:

```make
SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules
```

Recipes keep the standard leading tab. Guard it with an `.editorconfig` entry
(`indent_style = tab` for Makefiles) so editors don't convert tabs to spaces —
the failure is loud (`missing separator`) but annoying.

## Verify

Run `make <target>` and assert the expected output files exist. Run it again:
unchanged targets must NOT rebuild. After `make clean`, everything rebuilds.
