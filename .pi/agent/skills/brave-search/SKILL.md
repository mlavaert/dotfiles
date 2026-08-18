---
name: brave-search
description: Web search via the official bx CLI and page content extraction via defuddle (npx). Use for searching documentation, facts, or any web content. No browser required.
---

# Brave Search

Web search and content extraction using the Brave Search API.

Two tools:

- **`bx`** — the official [brave-search-cli](https://github.com/brave/brave-search-cli) (installed at `~/.local/bin/bx`). Handles all search: web, news, images, RAG grounding, AI answers.
- **`{baseDir}/content`** — small bash script. Fetches a specific URL and extracts readable content as markdown via [defuddle](https://github.com/kepano/defuddle) (`npx defuddle parse <url> --markdown`; cached by npx after first use). Something `bx` cannot do.

## Setup

Requires a Brave Search API account. A credit card is required to create the free subscription (you won't be charged).

1. Create an account at https://api-dashboard.search.brave.com/register
2. Create a "Free AI" subscription and an API key for it
3. Configure bx (one-time):
   ```bash
   bx config set-key YOUR_API_KEY
   ```
4. Requires Node/npm on PATH (for `bx` and `npx defuddle`). First run of `{baseDir}/content` downloads defuddle into the npx cache.

## Search (bx)

**Default to `bx context`** — it returns pre-extracted, token-budgeted web content from multiple pages in a single API call:

```bash
bx context "query" --max-tokens 4096            # RAG grounding (recommended default)
bx web "query" --count 5                        # Raw search results (use jq to filter)
bx web "site:docs.rs axum middleware"           # site: scoping
bx news "query" --freshness pd                  # News: past day (pw/pm/py also work)
bx answers "question" --no-stream               # AI-generated answer (may need a paid plan)
```

Useful flags: `--include-site docs.rs`, `--exclude-site medium.com`, `--goggles '<rules>'` for domain/path re-ranking, `--country DE`, `--freshness pd|pw|pm|py|YYYY-MM-DDtoYYYY-MM-DD`.

Note: `bx web` outputs full JSON (very verbose). Pipe through jq, e.g.:
```bash
bx web "query" | jq -r '.web.results[] | "\(.title)\n\(.url)\n\(.description)\n"'
```

## Extract Page Content

```bash
{baseDir}/content https://example.com/article
```

Fetches a URL and extracts readable content as markdown. Use this when you already have a URL (from search results, the user, or a code comment) — `bx` has no equivalent command.

## When to Use

- Searching docs, facts, or current info → `bx context` (one call, content included)
- Site-scoped or operator searches → `bx web`
- Fresh news/versions → `bx news --freshness pd` or `bx context`
- Reading a specific known URL → `{baseDir}/content <url>`
