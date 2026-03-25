---
description: Create a new area in the brain
---

The user wants to create a new area in the brain. An area is a knowledge domain (e.g. research, projects, notes, reading, health, recipes — anything).

## Steps

1. **Ask:** "What area do you want to create?" — Get a short name (lowercase, no spaces) and a one-line description.
2. **Ask:** "What should be tracked in this area?" — Understand what kind of information goes here (e.g. reading list, project log, weekly notes, reference links).
3. **Create the knowledge file:**
   - Create `knowledge/{area}/` folder
   - Write an initial `.md` file (named after the primary concern, e.g. `reading-list.md`, `log.md`, `notes.md`) with `source:` frontmatter and sections based on what they described
   - The `source:` field should describe where the initial content came from (e.g. `"user input"`, `"onboarding"`)
   - **Cross-reference:** Search existing knowledge areas for related content. If found, suggest adding a `## Related` section in the new file with standard markdown links using `[title](../other-area/file.md)` format, and add reciprocal links in the related file(s)
4. **Update `memory/_index.md`:**
   - Add a new section header for the area
   - Add a link to the main file with a 1-sentence description
   - Add an entry under "Recently Added"
5. **Update `CLAUDE.md`:**
   - Add the new area to the Areas table (between the `<!-- Auto-updated by /new -->` comment and the end of the table)

## Git

After all file changes are done:
1. Commit everything on a new branch (e.g. `add-{area}-area`)
2. Push and open a PR titled "Add {area} area"
3. Share the PR link with the user

## Guidelines

- Keep area names lowercase, short, and descriptive
- The knowledge file should have useful section headers based on what the user described — not empty boilerplate
- If an area with that name already exists, tell the user and ask if they want to update it instead
