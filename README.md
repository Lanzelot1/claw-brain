# Claw Brain

A fork-and-use template for building your own **agent brain** — a Claude Code-powered knowledge management system with slash commands, git-first workflow, and structured data validation.

Derived from our internal kayba-brain — the system we use to run [Kayba](https://github.com/kayba-ai), built on the [ACE framework](https://github.com/kayba-ai/agentic-context-engine). We love the [nanoclaw](https://github.com/nicobailon/nanoclaw) philosophy of lightweight, composable agent groups, so we made this template work seamlessly as a nanoclaw brain too.

Made by and for Claude Code. ♥

## Quick Start

1. **Fork** this repo (or use as a GitHub template)
2. **Clone** and `cd` into it
3. Run `claude` to start Claude Code
4. Run `/onboard` — creates your personal profile and fills in the About section
5. Run `/new` — creates your first knowledge area
6. Drop files into `drop/`, run `/process-inbox` — auto-categorizes into knowledge areas

## Folders

| Folder | Purpose |
|--------|---------|
| `memory/` | Index (`_index.md`) and personal profile (`me.md`, gitignored) |
| `knowledge/` | All documents — reference docs, raw data, strategy files. Source of truth. |
| `drop/` | Inbox for new files. Processed by `/process-inbox`. |
| `output/` | Generated files. Named `YYYY-MM-DD-description.md`. |

## Slash Commands

| Command | Description |
|---------|-------------|
| `/onboard` | Create your personal profile and fill in brain metadata |
| `/new` | Create a new knowledge area (folder + index entry + CLAUDE.md update) |
| `/process-inbox` | Categorize and file everything in `drop/` |
| `/status` | Show brain overview — areas, inbox, recent output |

## Customization

### Adding commands

Create `.claude/commands/your-command.md` with a YAML frontmatter `description` and markdown instructions. See existing commands for the pattern.

### Adding schemas

Place `foo.schema.json` next to `foo.json` in any directory. The pre-commit hook and CI action will auto-validate.

### Adding areas

Run `/new` or manually:
1. Create `knowledge/{area}/` with an initial `.md` file
2. Add entries to `memory/_index.md`
3. Add a row to the Areas table in `CLAUDE.md`

## NanoClaw Compatibility

To use as a brain for a [nanoclaw](https://github.com/nicobailon/nanoclaw) group:

```bash
cd groups/
git clone <your-fork> my-brain
```

The brain uses relative paths only — no container paths or IPC references. NanoClaw's own `CLAUDE.md` loads additively alongside this one.

## Setup

### JSON Schema Validation (optional)

```bash
pip install pre-commit check-jsonschema
pre-commit install
```

This enables automatic JSON schema validation on commit. CI also runs validation on every push/PR.

## Contributing

Contributions are welcome! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

MIT
