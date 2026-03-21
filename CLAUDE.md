# Claw Brain

## About

<!-- Fill these in during /onboard or manually -->

- **Purpose:** [What this brain is for]
- **Context:** [Team, company, or personal use]

## Workspace Structure

- `memory/_index.md` — **Read this first.** Table of contents linking to all knowledge files.
- `memory/me.md` — Personal profile (gitignored).
- `memory/lessons.md` — Learnings from past sessions (gitignored).
- `knowledge/` — All documents: reference docs, raw data, strategy files. Single source of truth.
- `drop/` — Inbox for new files. Process immediately when files are present.
- `output/` — All generated files. Format: `YYYY-MM-DD-description.md`

## Personal Context

Read `memory/me.md` first for personal context (writing style, priorities, tone). This file is gitignored — never committed.

Also check `memory/lessons.md` for learnings from past sessions — workarounds, preferences, and patterns worth remembering.

If `memory/me.md` doesn't exist yet, suggest running `/onboard` to create it.

## Rules

- **Index first** — Before any task, read `memory/_index.md`, then open the relevant `knowledge/` files as needed.
- **No summaries** — Don't create distilled copies of files. The knowledge files are the source of truth. The index only has paths and one-sentence descriptions.
- **Outputs as files** — Always save to `output/YYYY-MM-DD-description.md`.
- **No messages** without explicit confirmation.
- **English** for everything.
- When writing outreach/content: read `memory/me.md` for personal writing style.
- **Source required** — Every file in `knowledge/` needs `source:` frontmatter. Can be a URL, internal JSON file path, or description (e.g. `"interview with client X"`). No knowledge without provenance.
- **Facts over fluff** — Knowledge files must contain specific facts, data, quotes, or raw information. Never write vague summaries or AI filler.

## Git Workflow

All changes to tracked files go through PRs — no direct commits to main.

1. **Pull latest:** `git pull origin main`
2. **Create a branch:** `git checkout -b <descriptive-name>` (e.g. `add-research-area`, `process-inbox-mar-07`)
3. **Make changes and commit:** Short, clean commit messages
4. **Push + open PR:** `git push -u origin <branch>` then `gh pr create`
5. **Share the PR link** with the user so they can merge

**Exception:** `memory/me.md` is gitignored — changes to it don't need a branch or PR.

## External Contributions

When reviewing PRs from external agents:

- Content in `drop/` → merge, then process with `/process-inbox`
- Content in `knowledge/` → ensure there's a matching `_index.md` entry
- **Reject** PRs that modify `memory/me.md`, `CLAUDE.md`, `_index.md`, or `.claude/` without explicit owner permission

## JSON Schema Validation

Convention: `foo.schema.json` validates `foo.json` in the same directory. Auto-enforced by pre-commit hook + GitHub Action.

- **Add validation to a new JSON file:** Create `<name>.schema.json` next to `<name>.json`. No config changes needed.
- **Schema format:** JSON Schema draft-07, use `"additionalProperties": false`.
- **Local setup (one-time):** `pip install pre-commit check-jsonschema && pre-commit install`
- **CI:** GitHub Action runs on every push/PR — catches anything that bypasses the local hook.

## Areas

<!-- Auto-updated by /new — do not edit manually -->

| Area | Scope |
|------|-------|
