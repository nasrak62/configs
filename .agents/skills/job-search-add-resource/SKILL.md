---
name: job-search-add-resource
description: Save a learning resource (article, video, course, tutorial) to the job-search tracker.
allowed-tools: Bash(job-search:*)
---

# Add Resource

Save a learning resource URL to the job-search tracker.

## Required

- `--url <URL>` — resource URL
- `--title <TEXT>` — resource title

## Optional

- `--description <TEXT>` — short description
- `--category <CATEGORY>` — `article`, `video`, `course`, `tutorial` (default: article)
- `--tags <TAG1,TAG2>` — comma-separated tags
- `--json` — structured output

## Steps

1. Extract URL and title from the user's message
2. If URL or title missing, ask for them
3. Infer category from context if possible (YouTube → video, Coursera → course, etc.)
4. Run add-resource command
5. Confirm the resource was saved with its ID

## Command

```bash
job-search add-resource --url "<URL>" --title "<TITLE>" [--category <CATEGORY>] [--tags <TAG1,TAG2>] [--description "<TEXT>"] --json
```

## Examples

```bash
job-search add-resource --url "https://neetcode.io/roadmap" --title "NeetCode Roadmap" --category tutorial --tags roadmap,leetcode --json

job-search add-resource --url "https://youtu.be/abc" --title "DP Patterns" --category video --tags dp --json

job-search add-resource --url "https://cp-algorithms.com/graph/dfs.html" --title "DFS Reference" --category article --tags graph,dfs --json
```

After saving, report the resource ID, title, and category to the user.
