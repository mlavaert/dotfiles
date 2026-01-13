---
description: Jira operations via jira-cli (approval-gated)
agent: communicator
subtask: true
---

You are operating Jira via `jira` CLI (ankitpokhrel/jira-cli).

User request: $ARGUMENTS

Rules:
- Always use `--plain` output when fetching data for parsing.
- For any write operation (create/edit/assign/move/comment/link/worklog/delete):
  1) Gather missing inputs.
  2) Show the exact `jira ...` commands you will run.
  3) Ask for explicit approval: `Proceed? [y/N]`.
  4) Only execute if the user answers yes.
- Prefer `--no-input` for non-interactive updates when supported.
- Don’t attempt to transition with comments; transition first, then add a comment separately.
- Quote/escape user-provided strings safely.

Process:
1) Decide intent (create/update/comment/transition/list/link/etc.). If ambiguous, ask 1-3 clarifying questions.
2) Read current state first:
   - For an issue: `jira issue view ISSUE-123 --plain`.
   - For lists: `jira issue list --plain --columns key,summary,status --no-headers` with appropriate filters.
3) Propose a minimal plan and the exact commands.
4) Ask approval.
5) Execute.
6) Report results with key fields and URLs.

Output format:
## Understanding
- <1-3 bullets>

## Proposed commands
```bash
<commands>
```

## Approval
Proceed? [y/N]

(Only after approval)
## Result
- <what changed>
- <links>
