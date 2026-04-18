---
description: Surface relevant knowledge before starting a task
---

Surface context relevant to the current task from the brain's authored layer (`knowledge/`), the synthesis layer (`graphify-out/`), and personal memory.

## Steps

1. **Ask:** "What are you about to work on?" (skip if the user already said).
2. **Read `memory/_index.md`** for the knowledge map.
3. **Read `memory/me.md`** for personal context (if it exists).
4. **Read `memory/lessons.md`** for past learnings (if it exists).
5. **Read `graphify-out/GRAPH_REPORT.md`** (if it exists) for god nodes and community clusters — this is your overview.
6. **Query the graph** for the specific topic:
   - Preferred: call the `graphify` MCP server (`query_graph`, `get_node`, `get_neighbors`) if registered in `.mcp.json`.
   - Fallback: run `.venv/bin/graphify query "{topic}" --graph graphify-out/graph.json --budget 1500` from a shell (or plain `graphify` if installed globally).
   - If `graphify-out/` doesn't exist yet (fresh brain), skip to step 7.
7. **Scan `knowledge/`** for files matching the task topic — check filenames and scan content of likely matches. These are the raw quotes the graph was built from.
8. **Follow explicit links** — for each matched source file, scan its content for outbound markdown links (`](../` pattern). Include linked files as "Related context" — one level deep only.
9. **Present a brief:**
   - Graph overview (god nodes / relevant community, if any)
   - Graph query result (subgraph around the topic, with confidence tags)
   - Relevant source files (with paths) — these give the raw quotes
   - Applicable lessons from past sessions
   - User preferences that apply
   - "Nothing found" sections are fine — don't pad.
10. **Ask:** "Want me to open any of these files?"
11. **Log:** append to `memory/log.md`: `YYYY-MM-DD HH:MM | query | "{topic}" → {N} files surfaced`.

## Git

Read-only — no changes, no branch, no PR.

## Rules

- Don't read every file — use the graph and filenames to narrow down, then scan content of likely matches.
- Keep the brief short — file paths + 1-sentence relevance, not full summaries.
- Graph edges tagged `INFERRED` or `AMBIGUOUS` are clues, not facts — label them as such in the brief.
- If nothing relevant is found, just say so.
