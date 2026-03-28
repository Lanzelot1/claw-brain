---
description: Show the current state of your brain
---

Give the user a quick overview of the brain's current state.

## Steps

1. Read `memory/_index.md` and count:
   - Number of knowledge areas
   - Number of indexed files per area
   - Any entries under "Recently Added"
2. Check `drop/` for unprocessed files
3. List the 5 most recent files in `output/`
4. Present a clean, concise summary

## Health Score

Calculate a health score (0-100) from these metrics. Skip this section entirely if there are no `.md` files in `knowledge/`.

| Metric | Weight | How |
|--------|--------|-----|
| Freshness | 25% | % of knowledge `.md` files with git commit <30 days |
| Source coverage | 25% | % with `source:` in YAML frontmatter |
| Index coverage | 20% | % referenced in `memory/_index.md` |
| Cross-references | 15% | % with ≥1 markdown link to another knowledge file |
| Inbox clear | 15% | 100 if `drop/` is empty, 0 otherwise |

Display as: **Brain Health: X/100** with a breakdown table showing each metric's score.

## Health Checks

After the score, run detailed health checks:

| Check | How |
|-------|-----|
| Freshness | Run `git log -1 --format="%ai"` per knowledge `.md` file. Label: **fresh** (<30 days), **aging** (30-90 days), **stale** (>90 days) |
| Missing sources | Check each `.md` file in `knowledge/` for `source:` in YAML frontmatter. List any files missing it. |
| Orphaned files | Find `.md` files in `knowledge/` that are not referenced in `memory/_index.md` |
| Index coverage | Compare file count in `knowledge/` vs entries in `_index.md` |
| Cross-references | Find knowledge files with no markdown links to other knowledge files |

Present health results as a compact table or list. Only highlight problems — don't list every file if everything is healthy.
