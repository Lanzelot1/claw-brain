# Claw Brain

## About

<!-- Fill these in during /onboard or manually -->

- **Purpose:** [What this brain is for]
- **Context:** [Team, company, or personal use]

## Workspace Structure

- `memory/_index.md` — **Read this first.** Table of contents linking to all knowledge files.
- `memory/me.md` — Personal profile (gitignored).
- `memory/lessons.md` — Learnings from past sessions (gitignored).
- `memory/log.md` — Chronological activity log (gitignored). Append here after ingestions, queries, synthesis, lint.
- `knowledge/` — All knowledge documents. Two types: **source files** (raw facts, data, quotes) and **wiki pages** (synthesized entity/concept/comparison pages). Single source of truth.
- `raw/` — Immutable source document archive. Originals from `drop/` land here during processing. Never modify files in `raw/`.
- `drop/` — Inbox for new files. Process immediately when files are present.
- `output/` — All generated files. Format: `YYYY-MM-DD-description.md`

## Personal Context

Read `memory/me.md` first for personal context (writing style, priorities, tone). This file is gitignored — never committed.

Also check `memory/lessons.md` for learnings from past sessions — workarounds, preferences, and patterns worth remembering.

If `memory/me.md` doesn't exist yet, suggest running `/onboard` to create it.

## Rules

- **Index first** — Before any task, read `memory/_index.md`, then open the relevant `knowledge/` files as needed.
- **No summaries of individual sources** — Source files (`type: source`) contain raw facts, data, quotes. Don't create a distilled copy of a single source file. Wiki pages (`type: wiki`) are the exception: they synthesize across multiple sources and must link back to all of them.
- **Two knowledge types** — Files in `knowledge/` have a `type:` field in frontmatter: `source` (default, raw facts) or `wiki` (synthesized page). Omitted `type:` is treated as `source`.
- **Wiki pages must cite sources** — Every wiki page needs a `## Sources` section at the bottom listing the knowledge files it synthesizes from, using standard markdown links.
- **Outputs as files** — Always save to `output/YYYY-MM-DD-description.md`.
- **No messages** without explicit confirmation.
- **English** for everything.
- When writing outreach/content: read `memory/me.md` for personal writing style.
- **Source required** — Every file in `knowledge/` needs `source:` frontmatter. Can be a URL, internal JSON file path, or description (e.g. `"interview with client X"`). No knowledge without provenance.
- **Facts over fluff** — Knowledge files must contain specific facts, data, quotes, or raw information. Never write vague summaries or AI filler.
- **Raw is immutable** — Never modify, rename, or delete files in `raw/`. It's the archive of original source documents.
- **Log activity** — After ingestions, synthesis, queries that produce wiki updates, and lint passes, append an entry to `memory/log.md`.
- **Cross-reference when substantive** — When creating or updating knowledge files, add standard markdown links to related files in other areas. Use `[title](../area/file.md)` format. Don't force connections — only link when the relationship is genuinely useful.

## Git Workflow

All changes to tracked files go through PRs — no direct commits to main.

1. **Pull latest:** `git pull origin main`
2. **Create a branch:** `git checkout -b <descriptive-name>` (e.g. `add-research-area`, `process-inbox-mar-07`)
3. **Make changes and commit:** Short, clean commit messages
4. **Push + open PR:** `git push -u origin <branch>` then `gh pr create`
5. **Share the PR link** with the user so they can merge

**Role overrides:** Git permissions vary by agent role (e.g. orchestrators commit directly to main). See `memory/roles.md` for details.

**Exception:** Gitignored files (memory/me.md, memory/roles.md, etc.) don't need commits.

## External Contributions

When reviewing PRs from external agents:

- Content in `drop/` → merge, then process with `/process-inbox`
- Content in `knowledge/` → ensure there's a matching `_index.md` entry
- Content in `raw/` → never modify; merge if it's a new source document
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
