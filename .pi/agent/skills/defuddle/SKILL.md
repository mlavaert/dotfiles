---
name: defuddle
description: Extract readable content from a web page or HTML as markdown via the defuddle CLI (npx). Use when you have a specific URL or HTML to read — articles, docs, blog posts.
---

# Defuddle

[Defuddle](https://github.com/kepano/defuddle) extracts the main content of a web page, stripping clutter (nav, sidebars, comments, footers). Readability.js successor from Obsidian Web Clipper.

Runs via `npx defuddle` — no install (cached by npx after first run). Requires Node/npm on PATH.

## Usage

```bash
npx defuddle parse <url> --markdown                 # URL → markdown (most common)
npx defuddle parse page.html --markdown             # local HTML file
curl -sL <url> | npx defuddle parse - --markdown    # HTML from stdin
```

Default output (without `--markdown`) is cleaned HTML. Useful flags:

- `--json` — metadata (title, author, published, domain, …) + content as JSON; pipe through jq
- `--property title` — extract a single metadata field, no content
- `--frontmatter` — prepend YAML frontmatter (title, author, source) to the output
- `--user-agent "Mozilla/5.0 …"` — retry with a browser UA on 403/FORBIDDEN
- `-o file.md` — write output to a file instead of stdout

## When to Use

- Reading a specific known URL (from the user, search results, a code comment) → `parse <url> --markdown`
- Need page metadata without the content → `--property title` or `--json | jq`
- 403/blocked by bot detection → retry with `--user-agent` (browser UA string)
- Pages requiring JavaScript rendering won't work — the CLI fetches static HTML, no browser.
