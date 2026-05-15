---
name: job-search-log-session
description: Log a LeetCode practice session using the job-search CLI. Use when the user finishes working on a problem and wants to record the outcome.
allowed-tools: Bash(job-search:*)
---

# Log Session

Record a practice session for a LeetCode problem.

## Required

- `--problem-id <ID>` — LeetCode problem ID

## Optional

- `--duration <MINUTES>` — time spent in minutes
- `--outcome <OUTCOME>` — result: `attempted`, `solved`, or `reviewed` (default: attempted)
- `--approach <TEXT>` — description of the approach used
- `--note-id <ID>` — associate with an existing note UUID
- `--json` — structured output

## Steps

1. If problem ID not provided, ask the user which problem they worked on
2. Ask for outcome if not mentioned (solved / attempted / reviewed)
3. Gather duration and approach if mentioned
4. Run the log-session command
5. Confirm the session was logged

## Command

```bash
job-search log-session --problem-id <ID> [--duration <MINUTES>] [--outcome <OUTCOME>] [--approach "<TEXT>"] --json
```

## Examples

```bash
# Solved in 30 minutes with two-pointer approach
job-search log-session --problem-id 15 --duration 30 --outcome solved --approach "two pointers" --json

# Just attempted
job-search log-session --problem-id 42 --outcome attempted --json

# Reviewed a solution
job-search log-session --problem-id 1 --outcome reviewed --duration 15 --json
```

After logging, confirm the session ID and update the user on their current streak via `job-search status`.
