---
name: promote-to-vault
description: Review recent claude-mem observations and promote high-signal ones to Obsidian vault
---

**$VAULT_PATH** defaults to `~/Documents/obsidian-vault`. Override by setting `VAULT_PATH` in your environment or passing `--vault-path` during install.

Review claude-mem observations from the last 7 days using the claude-mem MCP search tools.

> **If claude-mem is not available:** Inform the user that claude-mem is required for this skill (`npm install -g claude-mem`), then exit gracefully. Do not attempt to proceed without a data source.

For each observation, classify it:

1. **Architecture decisions** — Save as a decision record in `$VAULT_PATH/03_Resources/tech-decisions/`
   - Use the ADR template format (Context, Options, Decision, Rationale, Consequences)
   - Add frontmatter: type: decision, date, status: accepted, tags

2. **Debugging breakthroughs** — Save as a debug journal entry in `$VAULT_PATH/03_Resources/debugging-journal/`
   - Use the Five Whys format (Symptoms, Root Cause, Fix, Prevention)
   - Add frontmatter: type: debug, date, severity, resolved: true, tags

3. **Reusable patterns** — Save as a resource in `$VAULT_PATH/03_Resources/patterns/`
   - Include: pattern name, when to use, example code, gotchas
   - Add frontmatter: type: pattern, date, language, tags

4. **Project milestones** — Update existing project notes in `$VAULT_PATH/01_Projects/`
   - Append to the project's progress log
   - Link to related decision records or debug journals

**Skip criteria:**
- Routine file edits with no architectural significance
- Test runs that passed without issues
- Simple typo fixes or formatting changes
- Anything already captured in the vault

**For each promoted observation:**
- Create a properly formatted Obsidian note using the appropriate template
- Add `[[links]]` to related existing notes where applicable
- Add appropriate tags for discoverability
- Commit the new notes to Git

**Output:** Summary of what was promoted, what was skipped, and why.
