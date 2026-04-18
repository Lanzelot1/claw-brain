---
description: Process new files from the drop/ inbox
---

Process all new files in the `drop/` folder.

## Steps

1. **Read `memory/_index.md`** to discover all available areas
2. **For each file in `drop/`:**
   a. Read the content and understand what it's about
   b. **Archive original:** Copy the file to `raw/` (prepend `YYYY-MM-DD-` if no date prefix exists). Never overwrite — if a file with that name exists in `raw/`, append a counter.
   c. **Categorize:** Match it to an existing area from the index
   d. **Prepare knowledge file:**
      - If the file is already a well-structured `.md` with frontmatter: move it to `knowledge/{area}/`, ensure `source:` frontmatter exists, add `type: source` if no `type:` field.
      - If the file is a PDF, image, data file, or unstructured text: create a new `.md` file in `knowledge/{area}/` that extracts the key facts, data, and quotes. Set `source:` to the `raw/` path. Set `type: source`. The raw file stays in `raw/` only.
   e. **Check `source:` frontmatter:** If the source is unclear, ask the user: "Where did this file come from?"
   f. **Cross-reference:** Search other knowledge areas for substantively related files. If found, ask: "I found these related files — should I add cross-references?" If yes, add `## Related` sections with reciprocal links.
   g. **Add entries** to `memory/_index.md` (area section + Recently Added)
   h. **Log:** Append to `memory/log.md`: `YYYY-MM-DD HH:MM | ingest | {filename} → knowledge/{area}/{filename}`
3. **If a file doesn't fit any existing area:**
   - Ask the user: "This file doesn't fit any existing area. Want to create a new one?"
   - If yes, run the `/new` workflow first, then process the file into the new area
4. **Remove processed files from `drop/`**

## Git

After processing all files:
1. Commit everything on a new branch (e.g. `process-inbox-YYYY-MM-DD`)
2. Push and open a PR summarizing what was processed
3. Share the PR link with the user

## Rules

- Source files contain raw facts — no AI filler, no vague summaries
- The index only gets the file path and a max 1-sentence description
- Ask before deleting anything
- Show a summary of what was processed when done
- If `drop/` is empty, just say so
- Never modify files already in `raw/`
