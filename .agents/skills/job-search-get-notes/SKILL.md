---
name: job-search-get-notes
description: List recent job-search notes with optional tag filtering. Use when the user wants to browse or review their study notes.
allowed-tools: Bash(job-search:*)
---

# Get Notes

Retrieve and display recent notes from the job-search tracker.

## Options

- `--limit <N>` — max notes to return (default: 20)
- `--tag <TAG>` — filter by tag (repeatable for multiple tags)
- `--json` — structured output

## Steps

1. Extract any tag filters or limit from the user's message
2. Run get-notes with those filters
3. Display the notes in a readable table or list

## Command

```bash
job-search get-notes [--limit <N>] [--tag <TAG>] --json
```

## Examples

```bash
# All recent notes
job-search get-notes --json

# Limit to 50
job-search get-notes --limit 50 --json

# Filter by tag
job-search get-notes --tag dp --json

# Multiple tag filters
job-search get-notes --tag dp --tag graph --json
```

Format the output as a list with title, snippet, and tags for each note.
