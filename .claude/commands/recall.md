---
description: Surface relevant knowledge before starting a task
---

Search across all knowledge areas and memory to find context relevant to the current task.

## Steps

1. **Ask:** "What are you about to work on?" (skip if the user already said)
2. **Read `memory/_index.md`** to get the full knowledge map
3. **Read `memory/me.md`** for personal context (if it exists)
4. **Read `memory/lessons.md`** for past learnings (if it exists)
5. **Search `knowledge/`** for files matching the task topic — check filenames and scan content
6. **Present a brief:**
   - Relevant knowledge files found (with paths)
   - Applicable lessons from past sessions
   - Any user preferences that apply
   - "Nothing found" sections are fine — don't pad
7. **Ask:** "Want me to open any of these files?"

## Git

Read-only — no changes, no branch, no PR.

## Rules

- Don't read every file — use the index and filenames to narrow down, then scan content of likely matches
- Keep the brief short — file paths + 1-sentence relevance, not full summaries
- If nothing relevant is found, just say so
