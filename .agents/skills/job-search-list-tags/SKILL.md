---
name: job-search-list-tags
description: List all tags used in job-search notes and resources with their usage counts.
allowed-tools: Bash(job-search:*)
---

# List Tags

Display all tags in use across notes and resources with their usage frequency.

## Options

- `--min-count <N>` — only show tags used at least N times (default: 1)
- `--json` — structured output

## Steps

1. Extract any min-count preference from the user's message
2. Run list-tags command
3. Display tags sorted by count (most used first)

## Command

```bash
job-search list-tags [--min-count <N>] --json
```

## Examples

```bash
# All tags
job-search list-tags --json

# Only tags used 3+ times
job-search list-tags --min-count 3 --json
```

## Output Fields

- `tag` — tag name
- `count` — number of items using this tag

Display as a ranked list. Highlight the top 5 most-used tags. This is useful for discovering which topics have the most coverage and which might need more work.
