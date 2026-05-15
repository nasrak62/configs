---
name: job-search-add-note
description: Add a study note using the job-search CLI. Use when the user wants to save a note, thought, or solution for a LeetCode problem or DS&A topic.
allowed-tools: Bash(job-search:*)
---

# Add Note

Add a note to the job-search tracker. Ask the user for required fields if not provided.

## Required

- `--title` — note title

## Optional

- `--content` — note body text
- `--tags` — comma-separated tags (e.g. `dp,array,graph`)
- `--problem-id` — associate with a LeetCode problem ID
- `--stdin` — read content from stdin instead of --content

## Steps

1. If the user hasn't provided a title, ask for one
2. Gather any optional content, tags, and problem ID from the user's message
3. Run the add-note command
4. Confirm the note was created with its ID

## Command

```bash
job-search add-note --title "<TITLE>" [--content "<CONTENT>"] [--tags <TAG1,TAG2>] [--problem-id <ID>] --json
```

## Examples

```bash
job-search add-note --title "Two Pointers Template" --content "Use two pointers when..." --tags array,two-pointers --json

job-search add-note --title "DP Knapsack" --tags dp --json

# From stdin
echo "Sliding window keeps O(n) by shrinking left ptr" | job-search add-note --title "Sliding Window" --stdin --tags array
```

After running, report the created note's ID and title to the user.
