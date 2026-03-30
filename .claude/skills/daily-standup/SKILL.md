---
name: daily-standup
description: Auto-generate a daily standup from claude-mem session history and Obsidian daily notes
---

**$VAULT_PATH** defaults to `~/Documents/obsidian-vault`. Override by setting `VAULT_PATH` in your environment or passing `--vault-path` during install.

Generate a concise daily standup report by pulling from two sources:

**Source 1: claude-mem (if available)**
- Search for observations from the last 24 hours
- Extract: files modified, features worked on, bugs fixed, PRs created, tests written
- Group by project/feature
- If claude-mem MCP tools are unavailable, skip this source and note "claude-mem not available" in the output

**Source 2: Obsidian daily note (if available)**
- Check `$VAULT_PATH/00_Inbox/` and `$VAULT_PATH/01_Projects/` for today's and yesterday's notes
- Extract any manually captured context, blockers, or decisions

**Output format:**

```markdown
## Standup — [date]

### Yesterday
- [Completed item 1 — with context]
- [Completed item 2 — with context]

### Today
- [Planned item 1 — based on in-progress work and open PRs]
- [Planned item 2 — based on vault project notes]

### Blockers
- [Any unresolved issues from yesterday's session]
- [Any dependencies or questions noted in vault]
```

**Rules:**
- Keep each item to one line. No paragraphs.
- Use past tense for yesterday, future tense for today.
- Only include actual work done — no filler like "reviewed emails" or "attended meetings" unless they produced code artifacts.
- If no blockers exist, write "None" — don't invent problems.
- If working on multiple projects, group by project with headers.
