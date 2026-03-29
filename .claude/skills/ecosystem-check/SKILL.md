---
name: ecosystem-check
description: Check for updates and new additions across the Claude Code ecosystem
---

**$VAULT_PATH** defaults to `~/Documents/obsidian-vault`. Override by setting `VAULT_PATH` in your environment or passing `--vault-path` during install.

Run a monthly ecosystem check across the HESOYAM dependency stack.

**Step 1: Check upstream versions.**

For each core dependency, check the latest release:
- oh-my-claudecode (npm: oh-my-claude-sisyphus)
- everything-claude-code
- claude-mem
- obsidian-skills
- claudesidian
- notebooklm-py

Report: current version vs latest, changelog highlights, breaking changes.

**Step 2: Scan ecosystem catalogs.**

Check these catalogs for new additions relevant to the user's stack:
- awesome-claude-code — new skills, agents, MCPs
- awesome-claude-code-subagents — new specialized subagents
- awesome-claude-skills — new cross-platform skills

**Step 3: Evaluate new finds.**

For each promising new tool, quick-evaluate:
| Question | Answer |
|----------|--------|
| Does it solve a real problem? | |
| Actively maintained? (commit < 30 days) | |
| Has documentation? | |
| Token cost estimate? | |
| Conflicts with existing tools? | |

**Step 4: Report.**

```markdown
## Ecosystem Check — [date]

### Version Updates
| Tool | Installed | Latest | Action |
|------|-----------|--------|--------|
| ... | ... | ... | Update / Skip / Breaking |

### New Discoveries
- [Tool name] — [one-line description] — [recommended / skip / evaluate later]

### Recommended Actions
1. [Specific action items]
```

Save the report to Obsidian vault if configured (`$VAULT_PATH/03_Resources/ecosystem/[date].md`).
