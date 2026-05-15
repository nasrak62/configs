---
name: append-system
description: How to append structured content to the `APPEND_SYSTEM.md` file. Make sure to use this skill whenever the user wants to add, update, or append content to the global system instructions file, even if they don't explicitly mention "append" or "APPEND_SYSTEM.md".
---

# append-system

This skill manages the system-level protocol file that defines how code changes should be handled. Use it for:
- Adding new protocol sections or rules
- Updating existing protocol instructions
- Appending best practices or guidelines
- Modifying the pseudocode-first workflow rules

## What this skill does

This skill reads the current `APPEND_SYSTEM.md` file, appends new content in a structured format with proper headers and timestamps, and saves the updated file. It ensures the file remains organized and easy to navigate.

## File location

The file is located at: `/home/nasrak62/.pi/agent/APPEND_SYSTEM.md`

## Output format

The skill appends content with the following structure:

```markdown
---
section: [section-name]
timestamp: YYYY-MM-DD HH:MM:SS
---

[Content goes here]
```

## Example usage

**Example 1: Adding a new protocol rule**

Input: "Add a rule to the system that says before any code change, ask the user for pseudocode"
Output: New section appended to APPEND_SYSTEM.md with timestamp and content

**Example 2: Updating existing protocol**

Input: "Update the pseudocode requirement to apply to API usage as well"
Output: Existing section updated with the expanded scope

**Example 3: Adding a best practice**

Input: "Add a note about reviewing code before implementation"
Output: New best practices section appended to the file

## Workflow

1. **Read current file**: Load the existing `APPEND_SYSTEM.md` content
2. **Parse existing sections**: Identify existing protocols and structure
3. **Append new content**: Add the new section with proper formatting
4. **Save file**: Write the updated content back to the file
5. **Confirm completion**: Report what was added/updated

## Important notes

- Always preserve existing content when appending
- Use clear section headers for organization
- Include timestamps for tracking changes
- Format content consistently with existing sections
- Don't overwrite existing protocols unless explicitly requested
