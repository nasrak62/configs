---
name: job-search-get-resources
description: List saved learning resources from the job-search tracker with optional category or keyword filtering.
allowed-tools: Bash(job-search:*)
---

# Get Resources

Retrieve and display saved learning resources.

## Options

- `--category <CATEGORY>` — filter by: `article`, `video`, `course`, `tutorial`
- `--search <QUERY>` — search in title and URL
- `--limit <N>` — max results (default: 20)
- `--json` — structured output

## Steps

1. Extract any category filter, search query, or limit from the user's message
2. Run get-resources with those filters
3. Display resources in a readable list with title, category, URL, and tags

## Command

```bash
job-search get-resources [--category <CATEGORY>] [--search "<QUERY>"] [--limit <N>] --json
```

## Examples

```bash
# All resources
job-search get-resources --json

# Only videos
job-search get-resources --category video --json

# Search by keyword
job-search get-resources --search "dynamic programming" --json

# Filtered and limited
job-search get-resources --category article --search "graph" --limit 10 --json
```

Format the output as a list. Group by category if no filter is applied and there are multiple categories.
