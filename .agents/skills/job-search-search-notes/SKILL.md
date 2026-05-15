---
name: job-search-search-notes
description: Full-text search through job-search notes. Use when the user wants to find notes matching a keyword or phrase.
allowed-tools: Bash(job-search:*)
---

# Search Notes

Full-text search through stored notes using the job-search CLI.

## Required

- `<QUERY>` — positional search query string

## Optional

- `--tag <TAG>` — filter results by tag (repeatable)
- `--limit <N>` — max results (default: 10)
- `--json` — structured output

## Steps

1. Extract the search query from the user's message
2. If no query provided, ask the user what to search for
3. Run search-notes with the query and any filters
4. Display matching notes with title, snippet, and tags

## Command

```bash
job-search search-notes "<QUERY>" [--tag <TAG>] [--limit <N>] --json
```

## Examples

```bash
job-search search-notes "two pointers" --json

job-search search-notes "dynamic programming" --limit 20 --json

job-search search-notes "BFS" --tag graph --json
```

Show each result with its title, snippet, and tags. If no results found, say so clearly.
