# Daily Standup Automation

> Auto-generate standups from Claude Code session history and claude-mem observations.

## The Idea

Instead of manually writing "Yesterday I worked on X, today I'll work on Y", let claude-mem + Obsidian generate it for you.

## Setup

Requires: claude-mem running, Obsidian vault connected.

## Daily Standup Command

Create a Claude Code slash command at `.claude/commands/standup.md`:

```markdown
---
name: standup
description: Generate daily standup from session history
---

Review claude-mem observations from the last 24 hours.
Also check any Obsidian daily notes from yesterday.

Generate a standup in this format:

## Yesterday
- [Completed items with brief context]

## Today
- [Planned items based on open tasks and sprint plan]

## Blockers
- [Any identified blockers from yesterday's session]

Keep it concise. No more than 3 bullets per section.
Save to vault/01_Projects/standups/{{date}}.md
```

## Usage

```bash
claude
/standup
```

Claude reads your session memory, identifies what was accomplished, what's pending, and surfaces any blockers. Takes 10 seconds instead of 10 minutes.

## Automation (Advanced)

Add a SessionStart hook that runs `/standup` automatically at the beginning of each day's first session:

```json
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "",
        "hooks": [{ "type": "command", "command": "auto-standup.sh" }]
      }
    ]
  }
}
```

> Note: `first_session_of_day` logic must be handled inside `auto-standup.sh` itself (e.g., check a timestamp file).

## Team Aggregation

If the team uses a shared Obsidian vault:

```
vault/01_Projects/standups/
├── 2026-03-29/
│   ├── dev-1.md
│   ├── dev-2.md
│   └── dev-3.md
```

A weekly slash command can aggregate individual standups into a team summary:

```bash
/team-weekly

> Aggregate all standups from this week.
> Identify: completed features, active blockers, cross-team dependencies.
> Save to vault/01_Projects/standups/weekly/week-13.md
```
