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
- `knowledge/` — Authored source files (raw facts, data, quotes). The only layer you write by hand. Ground truth.
- `raw/` — Immutable source document archive. Originals from `drop/` land here during processing. Never modify files in `raw/`.
- `drop/` — Inbox for new files. Process immediately when files are present.
- `graphify-out/` — Generated synthesis layer (wiki, graph, report). Rebuilt by `graphify`. Committed to git except `cache/`. Never edit by hand.
- `output/` — All generated files. Format: `YYYY-MM-DD-description.md`

### Knowledge flow

`drop/` → originals archived to `raw/` (immutable) → facts extracted to `knowledge/` as source files (`type: source`) → `graphify` reads `knowledge/` and writes `graphify-out/` (markdown wiki, `graph.json`, `GRAPH_REPORT.md`). Source files are the ground truth. The graph layer is a derived view — it can be deleted and regenerated at any time.

### Graph layer (graphify)

Synthesis is owned by [graphify](https://github.com/safishamsi/graphify), installed as the `/graphify` slash command. It extracts entities and relationships from `knowledge/`, builds a NetworkX graph, auto-generates a wiki per community, and tags every edge `EXTRACTED` / `INFERRED` / `AMBIGUOUS` with source-file provenance.

- **Rebuild:** `/synthesize` (wrapper around `graphify . --update --wiki`), or automatic via the post-commit hook after `graphify hook install`.
- **Query:** `/graphify query "..."` or the `graphify` MCP server (`.mcp.json`) exposing `query_graph`, `get_node`, `get_neighbors`, `shortest_path`.
- **Always-on:** when `graphify claude install` has been run, Claude reads `graphify-out/GRAPH_REPORT.md` before every Glob/Grep, so navigation happens via graph structure, not keyword search.
- **Write boundary:** graphify only reads `knowledge/` and `raw/`. It never modifies them. All graphify output lives under `graphify-out/`.

#### Swap path

Graphify's outputs are plain files (markdown wiki, NetworkX `graph.json`). If the project stagnates, the committed artifacts keep working. Migration targets are [Microsoft GraphRAG](https://github.com/microsoft/graphrag) or [LightRAG](https://github.com/HKUDS/LightRAG) — both consume the same input (a folder of source files). The authored layer in `knowledge/` is tool-independent; only incremental rebuilds are tied to graphify.

## Personal Context

Read `memory/me.md` first for personal context (writing style, priorities, tone). This file is gitignored — never committed.

Also check `memory/lessons.md` for learnings from past sessions — workarounds, preferences, and patterns worth remembering.

If `memory/me.md` doesn't exist yet, suggest running `/onboard` to create it.

## Rules

- **Index first** — Before any task, read `memory/_index.md` and `graphify-out/GRAPH_REPORT.md` (if it exists), then open the relevant `knowledge/` files as needed.
- **No summaries of individual sources** — Source files contain raw facts, data, quotes. Don't create a distilled copy of a single source file. Synthesis across multiple sources is handled by graphify in `graphify-out/`, not by hand in `knowledge/`.
- **knowledge/ is source-only** — Every file in `knowledge/` is an authored source file. Frontmatter can set `type: source` explicitly or omit `type:` (same thing). Don't hand-write synthesized pages inside `knowledge/`; that's graphify's job.
- **graphify-out/ is generated** — Never hand-edit files under `graphify-out/`. Regenerate via `/synthesize` or `graphify . --update --wiki` if something looks wrong.
- **Outputs as files** — Always save ad-hoc outputs to `output/YYYY-MM-DD-description.md`.
- **No messages** without explicit confirmation.
- **English** for everything.
- When writing outreach/content: read `memory/me.md` for personal writing style.
- **Source required** — Every file in `knowledge/` needs `source:` frontmatter. Can be a URL, internal JSON file path, or description (e.g. `"interview with client X"`). No knowledge without provenance.
- **Facts over fluff** — Knowledge files must contain specific facts, data, quotes, or raw information. Never write vague summaries or AI filler.
- **Raw is immutable** — Never modify, rename, or delete files in `raw/`. It's the archive of original source documents.
- **Log activity** — After ingestions, synthesis rebuilds, queries that change the graph, and lint passes, append an entry to `memory/log.md`.
- **Cross-reference when substantive** — When creating or updating knowledge files, add standard markdown links to related source files. Use `[title](../area/file.md)` format. Don't force connections — only link when the relationship is genuinely useful. (Graphify will pick up inferred connections automatically; your explicit links surface the obvious ones.)

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

<!-- Updated by /new -->

| Area | Scope |
|------|-------|
