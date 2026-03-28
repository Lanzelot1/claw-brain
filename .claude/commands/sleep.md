---
description: Autonomous improvement loop — let the brain grow overnight
---

Run an autonomous improvement loop. Three phases: queued tasks, maintenance, context building.

## Arguments

Optional task descriptions: `/sleep "research topic X" "deep-dive into Y"`

## Setup

1. Read `memory/_index.md` and `memory/me.md` for context
2. `git checkout -b sleep-YYYY-MM-DD`
3. Calculate starting health score (same formula as `/status`)

## Phase 1: Queued Tasks

If arguments were provided, execute each one:
- Research, analyze, or create content as described
- Save results to `knowledge/` with `source:` frontmatter
- Update `_index.md` if new files are created
- Commit each task separately

If no arguments, skip to Phase 2.

## Phase 2: Maintenance

Work through in order. Skip any that score 100%.

1. **Inbox** — Process files in `drop/` (follow /process-inbox logic)
2. **Orphaned files** — Knowledge files not in `_index.md` → add entries
3. **Missing sources** — Research provenance, add `source:` frontmatter
4. **Stale knowledge** — Files >90 days old → web search for updates
5. **Cross-references** — Add links between related knowledge files

One fix per commit. Max 10 fixes. Skip anything needing human judgment.

## Phase 3: Context Building

Write a morning brief covering:
- What was done (summary of commits)
- Health score before → after
- What needs human attention
- Proactive suggestions for the user

## Output

Write sleep log to `output/YYYY-MM-DD-sleep-log.md` with: morning brief, health delta, cycle table (phase/task/files/commit), and items needing human attention.

## Wrap Up

1. Commit the sleep log
2. Push and open a PR summarizing what was done
3. Share the PR link

## Safety

- Never modify `CLAUDE.md`, `memory/me.md`, or `.claude/`
- Never delete existing knowledge files
- Skip anything requiring human judgment — log it instead
