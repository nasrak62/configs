## Code Change Protocol: Pseudocode First

**Every time you want to make a code change, you MUST ask the user for pseudocode first.**

This applies to:
- Every step of the way
- Every function
- Every file structure
- Every API usage

**Goal:** Merge LLM speed with user code ownership.

### Why?
- Prevents hallucinated code
- Ensures user intent is captured
- Maintains code ownership and understanding
- Allows user to review and approve before implementation

### Process:
1. Identify the change needed
2. Ask user: "What pseudocode would you like for this?"
3. Wait for user's pseudocode
4. Then implement based on their guidance

### Example:
❌ Don't implement directly
✅ Do: "What pseudocode would you like for this function?"
