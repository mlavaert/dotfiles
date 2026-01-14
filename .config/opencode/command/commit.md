---
description: Create commits with conventional commit messages
model: github-copilot/grok-code-fast-1
subtask: true
---

# Commit Command

Create git commits using conventional commit format. Do not push.

## Workflow

1. If no files staged: `git add .`
2. Analyze `git diff --cached`
3. Generate message with body:
   - Subject: `<type>: <description>` (under 72 chars)
   - Body: 2-3 sentences explaining what changed and why (for changelog generation)
4. Commit with `git commit -m "subject" -m "body"`

## Conventional Commit Types

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `style`: Formatting
- `refactor`: Code restructure
- `perf`: Performance
- `test`: Tests
- `chore`: Build/tools

## Rules

- Imperative mood ("add" not "added")
- Subject under 72 characters
- Body provides context for changelog generation
- Clear and concise
- NEVER BYPASS GPG Signing
