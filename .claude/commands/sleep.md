---
description: Autonomous improvement loop — let the brain grow overnight
---

Run an autonomous improvement loop. Four phases: queued tasks, exploration & research, maintenance, context building.

## Arguments

Optional task descriptions: `/sleep "research topic X" "deep-dive into Y"`

## Setup

1. Read `memory/_index.md`, `memory/me.md`, and `memory/lessons.md` for full context
2. `git checkout -b sleep-YYYY-MM-DD`
3. Calculate starting health score (same formula as `/status`)

## Phase 1: Queued Tasks

If arguments were provided, execute each one:
- Research, analyze, or create content as described
- Save results to `knowledge/` with `source:` frontmatter
- Update `_index.md` if new files are created
- Commit each task separately

If no arguments, skip to Phase 2.

## Phase 2: Exploration & Research

Read through the brain and actively grow it. This is the creative phase — not just maintenance, but discovery.

1. **Map the brain** — Read `_index.md` and scan all knowledge files. Build a mental model of what the brain knows, where the depth is, and where the gaps are.

2. **Find threads to pull** — Look for:
   - Topics mentioned in passing across multiple files but never explored in depth
   - Questions or unknowns flagged in existing knowledge files
   - Areas where the user's `me.md` interests intersect with existing knowledge
   - Connections between different knowledge areas that haven't been made explicit
   - Claims that could be verified, updated, or expanded with web research
   - Entities (people, companies, concepts) that appear in 3+ files but lack their own page

3. **Research and deepen** — For the most promising threads (max 5):
   - Do web searches to find current, relevant information
   - Read and extract key facts — specific data, quotes, developments
   - Create new source files in `knowledge/` with `source:` frontmatter pointing to the URLs found
   - Set `type: source` — these are raw facts, not synthesis

4. **Strengthen connections** — For any new or updated source files:
   - Add cross-references (explicit markdown links) to related files in other areas
   - Add reciprocal links in those related files
   - Graphify will pick up inferred connections automatically on the next rebuild; focus your explicit links on the obvious ones

5. **Rebuild the graph** — After adding new sources, run `.venv/bin/graphify . --update --wiki` to refresh `graphify-out/`. This regenerates the synthesis layer (wiki + graph) from the new corpus. Skip if no source files changed this cycle.

Commit each research topic separately. Max 5 research threads per sleep cycle.

## Phase 3: Maintenance

Work through in order. Skip any that score 100%.

1. **Inbox** — Process files in `drop/` (follow /process-inbox logic, including `raw/` archival)
2. **Orphaned files** — Knowledge files not in `_index.md` → add entries
3. **Missing sources** — Research provenance, add `source:` frontmatter
4. **Stale knowledge** — Files >90 days old → web search for updates. If new information is found, update the file with new facts and note what changed. Update the `source:` field if a newer URL is available.
5. **Cross-references** — Add links between related knowledge files
6. **Contradiction check** — Use `graphify-out/GRAPH_REPORT.md` (if it exists) and `graph.json` to find `AMBIGUOUS` edges — these are graphify's flags for conflicting or weak signals. For each, read the implicated source files. If a clear resolution exists (e.g. newer source supersedes older), note it in the sleep log as a suggestion — do NOT edit source files automatically. If ambiguous, flag for human review.
7. **Graph rebuild** — If any source file changed during this cycle (Phases 1–3 added or modified files), run `.venv/bin/graphify . --update --wiki` at the end to refresh `graphify-out/`.
8. **Rework candidates** — Look for knowledge files that could be restructured:
   - Large files that cover multiple distinct topics → suggest splitting
   - Multiple small files on the same topic → suggest merging
   - Files in the wrong area → suggest moving
   - Don't act on these — log them as suggestions for human review

One fix per commit. Max 10 fixes. Skip anything needing human judgment.

## Phase 4: Context Building

Write a morning brief covering:
- What was done (summary of commits)
- What was explored and researched (Phase 2 summary)
- Health score before → after
- Interesting findings and connections discovered
- Threads worth pursuing further (questions the brain can't answer yet)
- Rework suggestions (from Phase 3 step 8)
- What needs human attention

## Output

Write sleep log to `output/YYYY-MM-DD-sleep-log.md` with: morning brief, health delta, exploration findings, cycle table (phase/task/files/commit), and items needing human attention.

## Wrap Up

1. Commit the sleep log
2. Push and open a PR summarizing what was done
3. Append to `memory/log.md`: `YYYY-MM-DD HH:MM | sleep | {N} commits, health {before} → {after}, explored {N} threads`
4. Share the PR link

## Safety

- Never modify `CLAUDE.md`, `memory/me.md`, or `.claude/`
- Never delete existing knowledge files
- Never modify files in `raw/`
- Skip anything requiring human judgment — log it instead
- When researching: only use reputable sources, always record the URL in `source:` frontmatter
- Don't hallucinate facts — if a web search doesn't return useful results, note the gap instead of making things up
