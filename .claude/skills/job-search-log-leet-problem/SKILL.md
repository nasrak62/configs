---
name: job-search-log-leet-problem
description: Log a completed LeetCode problem with auto-fetched metadata and Obsidian-style template. Use when the user says they just finished a LeetCode problem and provides a URL, slug, or problem number.
allowed-tools: Bash(job-search:*)
---

# Log LeetCode Problem

Log a completed LeetCode problem using the structured template. Automatically fetches problem metadata (title, difficulty, topics) from the LeetCode API and creates a note with the user's approach and mistakes.

## Required

- `--slug` — problem slug from the URL (e.g. `add-two-numbers` from `leetcode.com/problems/add-two-numbers/`)
- `--main-idea` — the user's approach or key insight
- `--where-wrong` — what tripped them up or was difficult

## Optional

- `--extra-tags` — comma-separated tags beyond the auto-fetched topics (e.g. `dummy-node,carry`)

## Steps

1. Extract the problem slug from the URL if the user provided one (e.g. `https://leetcode.com/problems/add-two-numbers/description/` → `add-two-numbers`). If no URL or slug is given, ask for it.
2. If the user hasn't described their main idea/approach in their message, ask: "What was your main idea or approach for this problem?"
3. If the user hasn't described what was difficult, ask: "Where did you go wrong or what was hard about it?"
4. Run the add-leet-note command
5. Report back the problem title, difficulty, auto-applied topics tags, and note ID

## Command

```bash
job-search add-leet-note \
  --slug "<SLUG>" \
  --main-idea "<MAIN_IDEA>" \
  --where-wrong "<WHERE_WRONG>" \
  [--extra-tags <TAG1,TAG2>] \
  --json
```

## Examples

```bash
# User gives URL: https://leetcode.com/problems/add-two-numbers/description/
# Slug extracted: add-two-numbers
job-search add-leet-note \
  --slug "add-two-numbers" \
  --main-idea "Use a dummy node as the result list head. digit = sum % 10, carry = sum / 10. Traverse until both lists and carry are exhausted." \
  --where-wrong "Forgot the dummy node pattern. Also rusty on % for digit and integer division for carry." \
  --extra-tags "dummy-node,carry" \
  --json

# User gives slug directly
job-search add-leet-note \
  --slug "two-sum" \
  --main-idea "Precompute complement in a hash map for O(n) single pass." \
  --where-wrong "Initially tried brute force O(n^2)." \
  --json
```

## Output Fields

- `id` — note UUID
- `title` — formatted as "LeetCode #N Problem Title"
- `tags` — auto-applied from LeetCode topics + extra tags + "leetcode"
- `created_at` — timestamp
- `problem.title` — problem title from LeetCode API
- `problem.difficulty` — Easy / Medium / Hard
- `problem.topics` — topic tags from LeetCode (e.g. Linked List, Math, Recursion)

After running, report the note ID, problem title, difficulty, and which tags were auto-applied.
