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

A fork-and-use template for building your own **agent brain** - a knowledge management system powered by Claude Code, with slash commands, structured data validation, and a git-first workflow.

Works as a personal brain, a shared team knowledge base, a [nanoclaw](https://github.com/nicobailon/nanoclaw) group brain, or a brain for openclaw bots and agents.

## Quick Start

1. **Fork** this repo (or use as a GitHub template)
2. **Clone** and `cd` into it
3. Run `claude` to start Claude Code
4. Run `/onboard` - creates your personal profile and fills in the About section
5. Run `/new` - creates your first knowledge area
6. Drop files into `drop/`, run `/process-inbox` - auto-categorizes into knowledge areas

## Philosophy

- **Files over features** - Knowledge lives in markdown and JSON. No databases, no services, no vendor lock-in.
- **Agent-native** - Built for Claude Code. Slash commands do the work. The codebase is small enough to understand in one session.
- **Structured when you need it** - JSON files with co-located schemas give you validation without infrastructure. Your agent reads and writes them directly.
- **Personal or enterprise** - Same template works as a personal brain, a shared team knowledge base, a [nanoclaw](https://github.com/nicobailon/nanoclaw) group brain, or a brain for openclaw bots and agents.
- **Connected when relevant** — Related knowledge files link to each other using standard markdown links. Connections grow organically through commands, not forced upfront. The index navigates; links connect.

## Folders

| Folder | Purpose |
|--------|---------|
| `memory/` | Index (`_index.md`), personal profile (`me.md`), session learnings (`lessons.md`), and activity log (`log.md`) - all gitignored except index |
| `knowledge/` | All documents — source files (raw facts) and wiki pages (synthesized). Source of truth. |
| `raw/` | Immutable source document archive. Originals preserved here during inbox processing. Gitignored by default. |
| `drop/` | Inbox for new files. Processed by `/process-inbox`. |
| `output/` | Generated files. Named `YYYY-MM-DD-description.md`. |

## Slash Commands

| Command | Description |
|---------|-------------|
| `/onboard` | Create your personal profile and fill in brain metadata |
| `/new` | Create a new knowledge area (folder + index entry + CLAUDE.md update) |
| `/process-inbox` | Categorize and file everything in `drop/` |
| `/status` | Show brain overview - areas, inbox, recent output, health checks |
| `/learn` | Extract learnings from the current session into memory |
| `/recall` | Surface relevant knowledge before starting a task |
| `/synthesize` | Create or update wiki pages that synthesize across multiple sources |
| `/sleep` | Autonomous improvement loop — explore, research, synthesize, clean up |

## Wiki Pattern (Optional)

Inspired by [Karpathy's LLM Wiki](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f) pattern. Instead of re-deriving knowledge on every query, the LLM incrementally compiles sources into a structured, interlinked wiki that compounds over time.

### The flow

```
drop/                    You put files here (articles, PDFs, notes)
  │
  ├──→ raw/              Original archived immutably (never modified)
  │
  └──→ knowledge/
        ├── source files   Extracted facts, data, quotes (type: source)
        │     │
        │     └──→ wiki pages   Synthesized pages weaving multiple
        │           (type: wiki)  sources together, with cross-links
        │
        └── ## Related     Cross-references between files build up
              links        the knowledge graph organically
```

### Three layers

1. **`raw/`** — Immutable archive. Originals land here during `/process-inbox`. Never touched again.
2. **Source files** (`type: source`) — Extracted facts from raw documents. Each points back to its raw original via `source:` frontmatter. This is the ground truth.
3. **Wiki pages** (`type: wiki`) — Created by `/synthesize` or `/sleep`. Weave together multiple source files into coherent pages about concepts, entities, or comparisons. Every wiki page has a `## Sources` section citing its constituent files and `## Related` links to other pages. Can be deleted and regenerated from source files.

### How it grows

- `/process-inbox` — Ingest new sources. Archives originals to `raw/`, extracts facts to `knowledge/`, updates existing wiki pages that relate to the new material.
- `/synthesize` — Explicitly create wiki pages from 2+ source files on a topic.
- `/sleep` — Autonomously explores the brain, finds threads to research, does web searches, creates new source files, synthesizes wiki pages, and strengthens cross-references. The brain grows while you sleep.
- `/recall` — Query the brain. Wiki pages are surfaced first (they're pre-synthesized). Good answers can be filed back into the wiki.

Wiki pages are optional — the system works perfectly fine with only source files. The `type:` field defaults to `source` when omitted, so no migration is needed.

## Customization

### Adding commands

Create `.claude/commands/your-command.md` with a YAML frontmatter `description` and markdown instructions. See existing commands for the pattern.

### Structured Data

JSON files are your "databases" - no Postgres, no Airtable, just files your agent can read and write directly. Co-located schemas keep them honest.

**The convention:** place `foo.schema.json` next to `foo.json` in any directory. The pre-commit hook and CI action validate automatically - on every commit locally and on every push/PR in CI.

**Use it for anything structured:** contacts, inventory, projects, config - any data that benefits from a defined shape. Your agent works with these files natively, no connectors or ORMs needed.

### Knowledge Quality

Every `.md` file in `knowledge/` must have YAML frontmatter with a `source:` field - a URL, internal file path, or description of where the information came from. Knowledge files must contain specific facts, data, or raw information - no vague summaries or AI filler. Both rules are enforced by pre-commit hook + CI pipeline, same pattern as JSON schemas.

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

Ask Claude to generate a contributor guide if you need one - it can tailor it to any agent or service.

Works with: nanoclaw groups, GitHub Actions, Discord/Slack bots, CI pipelines, cron jobs, or any script that can `git push`.

## NanoClaw Compatibility

To use as a brain for a [nanoclaw](https://github.com/nicobailon/nanoclaw) group:

```bash
cd groups/
git clone <your-fork> my-brain
```

The brain uses relative paths only - no container paths or IPC references. NanoClaw's own `CLAUDE.md` loads additively alongside this one.

## Built On

Derived from our internal kayba-brain - the system we use to run [Kayba](https://github.com/kayba-ai), built on the [ACE framework](https://github.com/kayba-ai/agentic-context-engine). Inspired by the [nanoclaw](https://github.com/nicobailon/nanoclaw) philosophy of lightweight, composable agent groups.

## Contributing

Contributions welcome - see [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT
