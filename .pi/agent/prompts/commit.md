---
description: Generate a conventional commit message and commit
---
Run `git diff --cached` to see staged changes. If nothing is staged, run `git diff` to see unstaged changes and suggest staging them first.

Based on the diff, generate a single conventional commit message following the [Conventional Commits](https://www.conventionalcommits.org/) spec:

```
<type>[optional scope]: <description>

[optional body]
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`, `ci`, `build`

Rules:
- Description should be concise, imperative mood, lowercase, no period at the end
- If the diff spans multiple concerns, pick the dominant type
- Only add a body if context beyond the description is necessary

Present the commit message to me for review. Do NOT commit unless I explicitly ask you to.
