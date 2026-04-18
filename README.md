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

- **Files over features** - Knowledge lives in markdown and JSON. The authored layer (`knowledge/`) is tool-independent; the synthesis layer (`graphify-out/`) is generated and regenerable.
- **Agent-native** - Built for Claude Code. Slash commands do the work. The codebase is small enough to understand in one session.
- **Structured when you need it** - JSON files with co-located schemas give you validation without infrastructure. Your agent reads and writes them directly.
- **Personal or enterprise** - Same template works as a personal brain, a shared team knowledge base, a [nanoclaw](https://github.com/nicobailon/nanoclaw) group brain, or a brain for openclaw bots and agents.
- **Connected when relevant** — Related knowledge files link to each other using standard markdown links. Connections grow organically through commands, not forced upfront. The index navigates; links connect.

## Folders

| Folder | Purpose |
|--------|---------|
| `memory/` | Index (`_index.md`), personal profile (`me.md`), session learnings (`lessons.md`), and activity log (`log.md`) - all gitignored except index |
| `knowledge/` | Authored source files (raw facts, data, quotes). The only layer you write by hand. Ground truth. |
| `raw/` | Immutable source document archive. Originals preserved here during inbox processing. Gitignored by default. |
| `drop/` | Inbox for new files. Processed by `/process-inbox`. |
| `graphify-out/` | Generated synthesis layer (wiki, graph, report) built by [graphify](https://github.com/safishamsi/graphify). Committed except `cache/`. Never hand-edited. |
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
| `/synthesize` | Rebuild the synthesis layer (graph + wiki) via graphify |
| `/graphify` | Underlying graph skill (installed separately — see Synthesis Layer below) |
| `/sleep` | Autonomous improvement loop — explore, research, synthesize, clean up |

## Synthesis Layer

Inspired by [Karpathy's LLM Wiki](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f) pattern. Instead of re-deriving knowledge on every query, the brain compiles sources into a structured, interlinked graph + wiki that compounds over time.

Claw-brain owns the **authored layer**: `drop/` → `raw/` → `knowledge/`. Synthesis is delegated to [graphify](https://github.com/safishamsi/graphify), a separate MIT-licensed tool that turns a folder of mixed content into a queryable knowledge graph.

### The flow

```
drop/                    You put files here (articles, PDFs, notes, code, images)
  │
  ├──→ raw/              Original archived immutably (never modified)
  │
  └──→ knowledge/        Extracted facts, data, quotes (type: source). Ground truth.
        │
        └──→ graphify-out/    Generated synthesis layer: wiki, graph, report
              ├── wiki/              per-community markdown articles
              ├── graph.json         queryable NetworkX graph
              └── GRAPH_REPORT.md    god nodes, communities, surprising connections
```

### Two layers, one direction

1. **Authored (you write this)** — `raw/` (immutable originals) and `knowledge/` (extracted facts with `source:` frontmatter). Tool-independent.
2. **Generated (graphify writes this)** — `graphify-out/` with wiki, graph, and report. Every edge is tagged `EXTRACTED` / `INFERRED` / `AMBIGUOUS` with source-file provenance. Regenerable from `knowledge/` at any time.

Graphify only reads `knowledge/` and `raw/`. It never modifies them.

### How it grows

- `/process-inbox` — Ingest new sources. Archives originals to `raw/`, extracts facts to `knowledge/` with `source:` frontmatter.
- `/synthesize` — Thin wrapper that runs `graphify . --update --wiki` to rebuild `graphify-out/`. Commits the refreshed synthesis layer.
- `/sleep` — Autonomously explores the brain, finds threads to research, does web searches, creates new source files, and rebuilds the graph. The brain grows while you sleep.
- `/recall` — Query the brain. Reads `graphify-out/GRAPH_REPORT.md` for overview, queries the graph for the specific topic, then falls back to raw source files for quotes.

### Install graphify

Graphify is a separate tool. One-time setup per clone — installs into a project-local `.venv/` (gitignored) so the pinned version travels with the repo and the MCP config in `.mcp.json` stays portable:

```bash
python3 -m venv .venv
.venv/bin/pip install -r requirements.txt   # pins graphifyy[mcp]
.venv/bin/graphify install                  # register /graphify slash command
.venv/bin/graphify claude install           # enable always-on PreToolUse hook
.venv/bin/graphify hook install             # rebuild graph on every commit
```

The `.mcp.json` in this repo points to `.venv/bin/python3`, exposing graphify as an MCP server so Claude Code sessions can call `query_graph`, `get_node`, `get_neighbors`, and `shortest_path` directly.

If you prefer a global install via `pipx install graphifyy[mcp]==0.4.23`, edit `.mcp.json` to point at your pipx venv path (e.g. `~/.local/pipx/venvs/graphifyy/bin/python`) — the default here assumes the local `.venv/` flow.

### Swap path

If graphify stagnates, migration targets are [Microsoft GraphRAG](https://github.com/microsoft/graphrag) or [LightRAG](https://github.com/HKUDS/LightRAG) — both consume the same input (a folder of source files). The authored layer in `knowledge/` is tool-independent; only incremental rebuilds are tied to graphify.

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
