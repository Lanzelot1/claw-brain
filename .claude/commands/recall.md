---
description: Surface relevant knowledge before starting a task
---

Search across all knowledge areas and memory to find context relevant to the current task.

## Steps

1. **Ask:** "What are you about to work on?" (skip if the user already said)
2. **Read `memory/_index.md`** to get the full knowledge map
3. **Read `memory/me.md`** for personal context (if it exists)
4. **Read `memory/lessons.md`** for past learnings (if it exists)
5. **Search `knowledge/`** for files matching the task topic — check filenames and scan content. Check both source files and wiki pages.
6. **Prioritize wiki pages** — if a wiki page (`type: wiki`) exists on the topic, surface it first (it's already a synthesis). Then list the underlying source files.
7. **Follow links** — For each matched file, scan its content for outbound markdown links (`](../` pattern). Include linked files as "Related context" in the brief — one level deep only, don't follow links from linked files.
8. **Present a brief:**
   - Relevant wiki pages found (with paths) — these give the best overview
   - Relevant source files found (with paths)
   - Applicable lessons from past sessions
   - Any user preferences that apply
   - Related context surfaced via cross-references (with paths)
   - "Nothing found" sections are fine — don't pad
9. **Ask:** "Want me to open any of these files?"
10. **After the task** (if the conversation continues): Ask "Did this produce insights worth filing back? I can update an existing wiki page or create a new one." If yes, follow the `/synthesize` workflow for the relevant content.
11. **Log:** Append to `memory/log.md`: `YYYY-MM-DD HH:MM | query | "{topic}" → {N} files surfaced`

## Git

Read-only for the recall itself — no changes, no branch, no PR.
If the user opts to file insights back (step 10), follow the `/synthesize` git workflow.

## Rules

- Don't read every file — use the index and filenames to narrow down, then scan content of likely matches
- Keep the brief short — file paths + 1-sentence relevance, not full summaries
- If nothing relevant is found, just say so
- Step 10 is optional — don't push it if the user just wanted context
