---
description: Autonomous improvement loop — let the brain grow overnight
---

Run an autonomous improvement loop. Three phases: queued tasks, maintenance, context building.

## Arguments

Optional task descriptions passed after the command:
`/sleep "research topic X" "deep-dive into Y"`

These are Phase 1 tasks — intensive work the user wants done overnight.

## Setup

1. Read `memory/_index.md` and `memory/me.md` for context
2. `git checkout -b sleep-YYYY-MM-DD` (use today's date)
3. Calculate starting health score

## Health Score (0-100)

| Metric | Weight | How |
|--------|--------|-----|
| Freshness | 25% | % of knowledge `.md` files with git commit <30 days |
| Source coverage | 25% | % with `source:` in YAML frontmatter |
| Index coverage | 20% | % referenced in `memory/_index.md` |
| Cross-references | 15% | % with ≥1 markdown link to another knowledge file |
| Inbox clear | 15% | 100 if `drop/` is empty, 0 otherwise |

## Phase 1: Queued Tasks

If arguments were provided, execute each one:
- Research, analyze, or create content as described
- Save results to appropriate `knowledge/` files (with `source:` frontmatter)
- Update `_index.md` if new files are created
- Commit each task separately with a descriptive message

If no arguments, skip to Phase 2.

## Phase 2: Maintenance

Work through this list in order. Skip any that score 100%.

1. **Inbox** — Process files in `drop/` (follow /process-inbox logic)
2. **Orphaned files** — Knowledge files not in `_index.md` → add entries
3. **Missing sources** — Research provenance, add `source:` frontmatter
4. **Stale knowledge** — Files >90 days old → web search for updates, refresh if outdated
5. **Cross-references** — Add links between related knowledge files

Rules:
- One fix per commit. Keep diffs small and reviewable.
- Max 10 maintenance fixes. Don't go forever.
- Skip anything that needs human judgment — log it instead.

## Phase 3: Context Building

Read through the brain's current state and write a morning brief:
- What was done tonight (summary of commits)
- Health score before → after
- What needs human attention (items skipped, decisions needed)
- Proactive suggestions (patterns noticed, gaps spotted, ideas for the user)

Include the morning brief at the top of the sleep log.

## Output

Write `output/YYYY-MM-DD-sleep-log.md`:

```
# Sleep Log — YYYY-MM-DD

## Morning Brief
[Context building output — what happened, what needs attention, proactive suggestions]

## Health
- **Before:** X/100
- **After:** Y/100 (+Z)

| Metric | Before | After |
|--------|--------|-------|
| Freshness | ... | ... |
| Source coverage | ... | ... |
| Index coverage | ... | ... |
| Cross-references | ... | ... |
| Inbox clear | ... | ... |

## Cycles

| # | Phase | Task | File(s) | Commit |
|---|-------|------|---------|--------|
| 1 | Queued | Research topic X | knowledge/area/topic-x.md | abc1234 |
| 2 | Maintenance | Missing source | knowledge/area/file.md | def5678 |
| ... | ... | ... | ... | ... |

## Needs Human Attention
- [Items that couldn't be resolved autonomously]
```

## Wrap Up

1. Commit the sleep log
2. `git push -u origin sleep-YYYY-MM-DD`
3. `gh pr create` with summary of what was done
4. Share the PR link

## Safety

- **Never modify** `CLAUDE.md`, `memory/me.md`, or `.claude/`
- **Never delete** existing knowledge files — only update or add
- **Skip** anything requiring human judgment — log it for morning review
- **Max cycles** prevent runaway loops
