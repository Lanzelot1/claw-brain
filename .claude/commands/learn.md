---
description: Extract learnings from the current session
---

Review the current conversation and save reusable insights to `memory/lessons.md`.

## Steps

1. **Read `memory/lessons.md`** (if it exists) to see what's already saved
2. **Scan the conversation** for:
   - Workarounds or solutions discovered through trial-and-error
   - User corrections or preferences ("don't do that", "I prefer X")
   - Patterns or conventions confirmed
   - Mistakes worth avoiding next time
3. **Filter by priority:**
   - Always save: user corrections, stated preferences, confirmed conventions
   - Save if non-trivial: debugging solutions, workflow patterns, tool quirks
   - Skip: obvious facts, session-specific details, raw logs
4. **Check for duplicates** — don't add entries that overlap with existing ones. Update existing entries if the new version is better.
5. **Append new entries** to `memory/lessons.md`. Format:
   ```
   - YYYY-MM-DD: [topic] — insight text
   ```
6. **Graduation check** — Review the extracted learnings for any insight that is a **durable fact** about the domain (not a personal preference, not a debugging workaround, not session-specific). Examples: "API rate-limits at 100 req/s", "The auth service requires JWT with RS256".
   - For each durable insight, ask the user: "This looks like permanent knowledge rather than a session learning: `{insight}`. Want me to add it to `knowledge/{area}/` instead?"
   - If yes: append to the most relevant **existing** knowledge file (don't create a new file). Add `source: "session discovery, YYYY-MM-DD"` to the frontmatter if needed. Search other knowledge areas for related files and add cross-references using `[title](../area/file.md)` format under a `## Related` section.
   - If no: leave it in `lessons.md` as normal
7. **If the file exceeds 50 entries**, ask the user which older entries can be consolidated or removed
8. **Show a summary** of what was saved (or "nothing new to save" if the session was routine)

## Git

`memory/lessons.md` is gitignored — no branch or PR needed.

## Rules

- Keep entries atomic — one insight per bullet
- Be specific — "use --no-cache flag with docker build on M1" not "docker can be tricky"
- Never save: current file paths, in-progress task details, conversation fragments
- If `memory/lessons.md` doesn't exist yet, create it with a `# Lessons` header
