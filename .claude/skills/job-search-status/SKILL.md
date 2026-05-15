---
name: job-search-status
description: Show today's job-search streak and activity summary — notes, sessions, and resources logged today.
allowed-tools: Bash(job-search:*)
---

# Job Search Status

Run the job-search status command to display today's streak and activity summary.

## Steps

1. Run the status command with JSON output for structured display
2. Present the results clearly to the user

## Command

```bash
job-search status --json
```

## Output Fields

- `current_streak` — consecutive active days
- `longest_streak` — best streak ever
- `total_active_days` — total days with any activity
- `notes_today` — notes added today
- `sessions_today` — practice sessions logged today
- `resources_today` — resources saved today

## Example

```bash
job-search status
job-search status --json
```

After running, summarize the streak and today's activity count for the user.
