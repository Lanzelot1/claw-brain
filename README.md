<div align="center">
<pre>
   ██████╗██╗      █████╗ ██╗    ██╗
  ██╔════╝██║     ██╔══██╗██║    ██║
  ██║     ██║     ███████║██║ █╗ ██║
  ██║     ██║     ██╔══██║██║███╗██║
  ╚██████╗███████╗██║  ██║╚███╔███╔╝
   ╚═════╝╚══════╝╚═╝  ╚═╝ ╚══╝╚══╝
<div>  B  R  A  I  N</div>
</pre>
</div>

[![Validate](https://github.com/Lanzelot1/claw-brain/actions/workflows/validate.yml/badge.svg)](https://github.com/Lanzelot1/claw-brain/actions/workflows/validate.yml)

A fork-and-use template for building your own **agent brain** — a knowledge management system powered by Claude Code, with slash commands, structured data validation, and a git-first workflow.

Works as a personal brain, a shared team knowledge base, a [nanoclaw](https://github.com/nicobailon/nanoclaw) group brain, or a brain for openclaw bots and agents.

## Quick Start

1. **Fork** this repo (or use as a GitHub template)
2. **Clone** and `cd` into it
3. Run `claude` to start Claude Code
4. Run `/onboard` — creates your personal profile and fills in the About section
5. Run `/new` — creates your first knowledge area
6. Drop files into `drop/`, run `/process-inbox` — auto-categorizes into knowledge areas

## Philosophy

- **Files over features** — Knowledge lives in markdown and JSON. No databases, no services, no vendor lock-in.
- **Agent-native** — Built for Claude Code. Slash commands do the work. The codebase is small enough to understand in one session.
- **Structured when you need it** — JSON files with co-located schemas give you validation without infrastructure. Your agent reads and writes them directly.
- **Personal or enterprise** — Same template works as a personal brain, a shared team knowledge base, a [nanoclaw](https://github.com/nicobailon/nanoclaw) group brain, or a brain for openclaw bots and agents.

## Folders

| Folder | Purpose |
|--------|---------|
| `memory/` | Index (`_index.md`), personal profile (`me.md`), and session learnings (`lessons.md`) — both gitignored |
| `knowledge/` | All documents — reference, raw data, strategy. Source of truth. |
| `drop/` | Inbox for new files. Processed by `/process-inbox`. |
| `output/` | Generated files. Named `YYYY-MM-DD-description.md`. |

## Slash Commands

| Command | Description |
|---------|-------------|
| `/onboard` | Create your personal profile and fill in brain metadata |
| `/new` | Create a new knowledge area (folder + index entry + CLAUDE.md update) |
| `/process-inbox` | Categorize and file everything in `drop/` |
| `/status` | Show brain overview — areas, inbox, recent output, health checks |
| `/learn` | Extract learnings from the current session into memory |
| `/recall` | Surface relevant knowledge before starting a task |

## Customization

### Adding commands

Create `.claude/commands/your-command.md` with a YAML frontmatter `description` and markdown instructions. See existing commands for the pattern.

### Structured Data

JSON files are your "databases" — no Postgres, no Airtable, just files your agent can read and write directly. Co-located schemas keep them honest.

**The convention:** place `foo.schema.json` next to `foo.json` in any directory. The pre-commit hook and CI action validate automatically — on every commit locally and on every push/PR in CI.

**Use it for anything structured:** contacts, inventory, projects, config — any data that benefits from a defined shape. Your agent works with these files natively, no connectors or ORMs needed.

### Knowledge Quality

Every `.md` file in `knowledge/` must have YAML frontmatter with a `source:` field — a URL, internal file path, or description of where the information came from. Knowledge files must contain specific facts, data, or raw information — no vague summaries or AI filler. Both rules are enforced by pre-commit hook + CI pipeline, same pattern as JSON schemas.

**One-time setup:**

```bash
pip install pre-commit check-jsonschema
pre-commit install
```

### Adding areas

Run `/new` or manually:
1. Create `knowledge/{area}/` with an initial `.md` file
2. Add entries to `memory/_index.md`
3. Add a row to the Areas table in `CLAUDE.md`

## Collaboration

External agents can write to your brain using the standard git workflow: clone → branch → write → PR. The brain owner reviews and merges.

Ask Claude to generate a contributor guide if you need one — it can tailor it to any agent or service.

Works with: nanoclaw groups, GitHub Actions, Discord/Slack bots, CI pipelines, cron jobs, or any script that can `git push`.

## NanoClaw Compatibility

To use as a brain for a [nanoclaw](https://github.com/nicobailon/nanoclaw) group:

```bash
cd groups/
git clone <your-fork> my-brain
```

The brain uses relative paths only — no container paths or IPC references. NanoClaw's own `CLAUDE.md` loads additively alongside this one.

## Built On

Derived from our internal kayba-brain — the system we use to run [Kayba](https://github.com/kayba-ai), built on the [ACE framework](https://github.com/kayba-ai/agentic-context-engine). Inspired by the [nanoclaw](https://github.com/nicobailon/nanoclaw) philosophy of lightweight, composable agent groups.

## Contributing

Contributions welcome — see [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT
