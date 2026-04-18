---
description: Rebuild the synthesis layer (graph + wiki) via graphify
---

Thin wrapper around `graphify`. Rebuilds `graphify-out/` (markdown wiki, `graph.json`, `GRAPH_REPORT.md`) from `knowledge/`.

## Arguments

Optional topic: `/synthesize "machine learning"`. When passed, after the rebuild the command also runs `graphify query "{topic}"` and surfaces the subgraph result. No argument → just rebuild.

## Prerequisites

- `graphifyy` installed (`pipx install graphifyy==0.4.23` or version pinned in `requirements.txt`).
- `graphify install` has registered the `/graphify` skill in Claude Code.
- If missing, tell the user to run those commands and stop.

## Steps

1. **Verify install:** run `graphify --version`. If the command is not found, print install instructions from `requirements.txt` and exit.
2. **Rebuild:** run `graphify . --update --wiki` from the repo root. This uses the SHA256 cache so only changed files re-extract. Capture node/edge counts from the output.
3. **Optional query:** if `$ARGUMENTS` is non-empty, run `graphify query "$ARGUMENTS" --graph graphify-out/graph.json` and show the user the subgraph result.
4. **Log:** append to `memory/log.md`: `YYYY-MM-DD HH:MM | synthesize | graphify rebuild — {N} nodes, {M} edges`.

## Git

1. `git checkout -b synthesize-YYYY-MM-DD` (if on `main`).
2. Stage `graphify-out/` (excluding `cache/`, which is gitignored) and `memory/log.md`.
3. Commit with a short message like `synthesize: rebuild graph ({N} nodes, {M} edges)`.
4. Push and open a PR. Share the link.

## Rules

- Never hand-edit files under `graphify-out/`. This command regenerates them.
- If `graphify` fails (missing API access, corrupted cache, etc.), surface the error to the user — do not silently continue or commit partial output.
- Do not pass `--mode deep` by default; only if the user explicitly asks for aggressive INFERRED edge extraction.
