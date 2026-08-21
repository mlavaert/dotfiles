---
name: python
description: Guidance for working with Python code — verification by execution, tooling, and conventions. Use whenever you write or modify Python code.
---

# Python

## Verify by execution

Verification means running the code and asserting expected outcomes. Printing
results and eyeballing them is NOT verification.

1. Write a small scratch script that imports and calls the code you produced.
2. Cover the examples from the task plus edge cases (empty input, boundary
   values, error cases).
3. Every check must **assert** the expected value — each check compares actual
   output to an expected value and fails loudly on mismatch.
4. Run it, fix what fails, re-run. Repeat until green.
5. Delete scratch files before you finish.

Rules:

- A run that checks nothing ("no tests ran", "collected 0 items", a script with
  no assertions) has verified nothing.
- If the project has a real test suite (pytest, unittest), run it — but still
  write your own assertions for the task's stated examples when the suite does
  not cover them. No test suite is expected in many tasks: build your own
  checks from the instructions.
- If the interpreter is missing (`command not found`), look for an equivalent
  (`python3` for `python`, a project venv, `uv run`, `poetry run`) before
  concluding verification is impossible. Do not skip verification because the
  first command you tried was absent.
