---
description: Generate a contributor guide for an external agent
---

An external agent or service wants to write to this brain. Generate a tailored contributor guide they can follow.

## Steps

1. **Ask:** "What agent or service will write to this brain?" — Get a name and short description (e.g. "discord-bot — a Discord bot that saves bookmarked links", "ci-reporter — GitHub Action that posts test coverage reports").
2. **Ask:** "What kind of content will it contribute?" — Understand the format and frequency (e.g. markdown notes, JSON data, links, reports).
3. **Check `memory/_index.md`** for matching areas:
   - If a matching area exists, suggest it as the write target (`knowledge/{area}/`)
   - If no match, ask: "No matching area found. Want to create one with `/new`, or should it write to `drop/` for manual processing?"
4. **Determine the write target:**
   - `knowledge/{area}/` — if there's a clear match and the content fits
   - `drop/` — if unsure, if the content needs human review first, or if the user prefers it
5. **Get the repo URL:** Run `git remote get-url origin` to get the repo URL.
6. **Generate the contributor guide** → save to `output/YYYY-MM-DD-contributor-guide-{agent-name}.md`

## Contributor Guide Template

The generated file should include:

```
# Contributor Guide: {agent-name}

## About
{description of what this agent does and what it contributes}

## Repository
- **URL:** {repo URL}
- **Write target:** `{target path}`

## Workflow

1. Clone the repo (once):
   ```bash
   git clone {repo URL}
   ```

2. Before each contribution:
   ```bash
   git checkout main && git pull origin main
   git checkout -b {agent-name}/YYYY-MM-DD-description
   ```

3. Write your file(s) to `{target path}`:
   - Format: Markdown (`.md`) or JSON (`.json`)
   - Naming: `YYYY-MM-DD-description.ext`
   - One topic per file

4. Commit and push:
   ```bash
   git add {target path}
   git commit -m "add: short description of content"
   git push -u origin HEAD
   ```

5. Open a PR:
   ```bash
   gh pr create --title "add: short description" --body "From {agent-name}"
   ```

## Rules

- **Only write to** `{target path}` — nothing else
- **Never modify:** `memory/`, `CLAUDE.md`, `_index.md`, `.claude/`, `output/`
- **File format:** Markdown or JSON. If JSON, include a co-located `.schema.json`
- **Commit messages:** Short, lowercase, prefixed with `add:`, `update:`, or `fix:`
- **One PR per contribution** — keep changes small and focused
- **Branch naming:** `{agent-name}/YYYY-MM-DD-description`
```

## Git

After generating the guide:
1. Commit on a new branch (e.g. `connect-{agent-name}`)
2. Push and open a PR
3. Share the PR link with the user

## Guidelines

- The guide should be self-contained — paste-able into a system prompt or CI config
- Keep it minimal and actionable, no fluff
- If the user wants to connect multiple agents, run `/connect` once per agent
