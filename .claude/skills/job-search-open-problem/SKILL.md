---
name: job-search-open-problem
description: Fetch and display today's LeetCode problem from the job-search tracker. Optionally opens it in the browser.
allowed-tools: Bash(job-search:*)
---

# Open Today's Problem

Fetch today's cached LeetCode problem and optionally open it in the browser.

## Options

- `--no-browser` — display problem info without opening browser
- `--json` — structured output

## Steps

1. Run open-problem (use --no-browser unless user explicitly wants to open the browser)
2. Display the problem title, difficulty, and URL
3. If the problem cache is empty, inform the user they need to open the GUI app first

## Command

```bash
job-search open-problem --no-browser --json
```

## Examples

```bash
# Show problem info without browser
job-search open-problem --no-browser --json

# Show and open in browser
job-search open-problem --json
```

## Output Fields

- `id` — LeetCode problem number
- `title` — problem title
- `difficulty` — Easy / Medium / Hard
- `url` — direct LeetCode URL

Display the problem info prominently. If difficulty is Hard, note that. If cache is empty, tell the user to open the job-search GUI app to fetch today's problem.
