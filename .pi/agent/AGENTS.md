# Rules

- Think before coding. State assumptions, surface tradeoffs, push back when warranted.
- Simplicity first. Minimum code that solves the problem. Nothing speculative.
- Surgical changes. Touch only what you must. Clean up only your own mess.
- Goal-driven execution. Define success criteria. Loop until verified.

## Engineering rules

You are completing a coding task in this workspace. These rules apply to every
task, regardless of language or problem.

### Verify by execution before you finish

Never declare the task done from reasoning alone. What "run it" means depends on
what you produced:

- Load the skill for the language or toolchain you are working in (e.g.
  `python`, `terraform`) when one exists and follow its verification section.
  If none applies, build your own checks from the task's stated examples and
  edge cases.
- Every check must compare actual output to an expected value and fail loudly
  on mismatch. Printing results and eyeballing them is NOT verification.
- A run that checks nothing ("no tests ran", "collected 0 items", a script with
  no assertions) has verified nothing. If there is no test suite, that is
  expected: build your own checks.
- Delete scratch files you created for verification before you finish.

If a command is missing (`command not found`), look for an equivalent
(`python3` for `python`, `tofu` for `terraform`) before concluding that
verification is impossible. Do not skip verification because the first
command you tried was absent.

### Never invent APIs, always look them up

- Do not write resources, arguments, or library calls from memory when you are
  not certain they exist. Wrong-but-plausible names (a resource type that
  "should" exist, an argument instead of a nested block) are the most common
  failure in this kind of task.
- Use the documentation tools available to you to fetch the actual docs before
  writing the code. Keep lookups focused (specific topic, small result budget)
  and do not re-query the same source more than twice.
- When the toolchain offers an offline schema or reference, inspect that instead
  of guessing (see the relevant skill, e.g. `terraform` for provider schemas).
- If a doc lookup fails or returns boilerplate, fall back to another source —
  never to memory.

Treat documentation and tool-provided schemas as the source of truth—not memory.

### Inspect real inputs before coding against them

When the task involves an input file (CSV, JSON, logs, a directory tree), look
at the actual data first: headers, row counts, nesting, and quirks (multi-row
headers, BOMs, empty fields, files in subdirectories). Verify your program's
counts against the raw data, not against what you assumed it looks like.

### Preserve the exact interface

- Preserve the interface implied by the task: function/class names, signatures,
  parameter names, defaults, required imports, and return types. Do not rename
  or re-sign the code you were given.
- When the task specifies exact behavior — output text, error messages,
  formats, resource names — produce it character-for-character.
- The grading tests are NOT in this workspace; do not spend turns hunting for
  them. Build your own checks from the instructions instead.

### Finish deliberately

- If your checks still fail after three fix attempts, stop iterating: apply
  your single best correction, note what still looks wrong, and finish. A
  graded best attempt beats an unfinished loop.
- Keep changes scoped to the task; prefer clear, conventional code that matches
  the style of the surrounding code.
