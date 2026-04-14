---
description: Create or update wiki pages that synthesize across multiple knowledge sources
---

Create or update synthesized wiki pages (entity pages, concept pages, or comparison pages) from existing knowledge source files.

## Arguments

Optional: specific topic, entity, or concept name. E.g. `/synthesize "machine learning"` or `/synthesize "Company X vs Company Y"`

## Steps

1. **Read `memory/_index.md`** to understand all available knowledge
2. **Determine what to synthesize:**
   - If an argument was given: focus on that topic/entity/concept
   - If no argument: scan knowledge files to suggest candidates. Look for:
     - Entities (people, companies, products, tools) mentioned in 3+ source files
     - Concepts that span multiple areas
     - Topics where information is scattered across files
   - Present candidates and ask: "Which would you like me to synthesize?"
3. **Gather source material:** Read all relevant source files (`type: source` or no type field). Note the specific facts, data, and quotes from each.
4. **Check for existing wiki page:** Search `knowledge/` for an existing wiki page on this topic (`type: wiki` in frontmatter).
5. **Create or update the wiki page:**
   - **Location:** `knowledge/{most-relevant-area}/` or `knowledge/wiki/` if cross-cutting
   - **Frontmatter:**
     ```yaml
     ---
     type: wiki
     source: "synthesized from knowledge sources"
     created: YYYY-MM-DD
     updated: YYYY-MM-DD
     ---
     ```
   - **Content:** Weave together facts from the source files into a coherent page. Use specific facts, data, and quotes — not vague summaries. Organize with clear headings.
   - **If sources contradict:** Note the contradiction explicitly rather than silently picking one.
   - **Required `## Sources` section** at the bottom: list every source file used, with markdown links and a brief note on what each contributed.
   - **Cross-references:** Add `## Related` section linking to related wiki pages and source files.
6. **Update index:** Add the wiki page to the "Wiki Pages" section in `memory/_index.md`
7. **Update source files:** In each source file that was used, add a cross-reference back to the new wiki page (in their `## Related` section).
8. **Log:** Append to `memory/log.md`: `YYYY-MM-DD HH:MM | synthesize | created/updated {wiki-page-path} from {N} sources`

## Git

1. Commit on a new branch (e.g. `synthesize-{topic}-YYYY-MM-DD`)
2. Push and open a PR
3. Share the PR link

## Rules

- Wiki pages must contain specific facts traced back to sources — no AI filler
- Every claim should be traceable to a source file via the ## Sources section
- Don't create a wiki page from a single source — minimum 2 source files to justify synthesis
- If updating an existing wiki page, update the `updated:` date in frontmatter
