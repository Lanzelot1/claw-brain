---
description: Process new files from the drop/ inbox
---

Process all new files in the `drop/` folder.

## Steps

1. **Read `memory/_index.md`** to discover all available areas
2. **For each file in `drop/`:**
   a. Read the content and understand what it's about
   b. **Categorize:** Match it to an existing area from the index
   c. **Check `source:` frontmatter:** If the file is `.md` and missing `source:` in its YAML frontmatter, ask the user: "Where did this file come from?" and add the appropriate `source:` field before moving it.
   d. **Move the file** to `knowledge/{area}/`
   e. **Add an entry** to `memory/_index.md` under the matching area section (path + 1-sentence description)
   f. **Add an entry** under "Recently Added" at the bottom
3. **If a file doesn't fit any existing area:**
   - Ask the user: "This file doesn't fit any existing area. Want to create a new one?"
   - If yes, run the `/new` workflow first, then process the file into the new area

## Git

After processing all files:
1. Commit everything on a new branch (e.g. `process-inbox-YYYY-MM-DD`)
2. Push and open a PR summarizing what was processed
3. Share the PR link with the user

## Rules

- Do NOT create summaries or distilled copies — the knowledge files are the source of truth
- The index only gets the file path and a max 1-sentence description
- Ask before deleting anything
- Show a summary of what was processed when done
- If `drop/` is empty, just say so
