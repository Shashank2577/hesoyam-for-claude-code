# Obsidian + Claude Code: Complete Setup Guide

> Turn your Obsidian vault into Claude Code's second brain.

## Quick Start (Recommended Path)

If you just want to get up and running, do these 5 steps:

```bash
# Step 1: Run the HESOYAM installer (creates vault, Git repo, installs skills)
cd hesoyam-for-claude-code
./install.sh --pillar knowledge

# Step 2: Open Obsidian → "Open folder as vault" → ~/Documents/obsidian-vault

# Step 3: Install obsidian-skills inside Claude Code
claude
> /plugin marketplace add kepano/obsidian-skills
> /plugin install obsidian@obsidian-skills

# Step 4 (Optional): Install Obsidian Git plugin
# In Obsidian: Settings → Community Plugins → Browse → search "Git" → Install + Enable
# Configure: auto-backup every 10 min, auto-pull on startup

# Step 5 (Phone): Install Obsidian mobile app → clone the same GitHub repo
```

**What this gives you:**
- A PARA-structured vault at `~/Documents/obsidian-vault/` with project folders, templates, and debug journals
- A private GitHub repo backing the vault (auto-created via `gh`)
- Auto-commit + push every time Claude Code writes to the vault (PostToolUse hook)
- 4 skills: `/promote-to-vault`, `/daily-standup`, `/research-sprint`, `/ecosystem-check`
- Phone access via Obsidian mobile + Git sync

**That's it.** The rest of this guide explains the details and advanced options.

---

## Why Obsidian?

1. **Markdown-native** — LLMs work best with Markdown. No proprietary formats.
2. **Local-first** — Your knowledge stays on your machine.
3. **Git-friendly** — Version control your brain.
4. **Plugin ecosystem** — Terminal, MCP, and agent integrations available.
5. **Official support** — Obsidian's CEO built agent skills specifically for this.

## Manual Setup (If Not Using install.sh)

### Step 1: Install Obsidian

Download from [obsidian.md](https://obsidian.md). Create a vault or use the Claudesidian template:

```bash
git clone https://github.com/heyitsnoah/claudesidian.git ~/Documents/obsidian-vault
cd ~/Documents/obsidian-vault
claude   # Open Claude Code inside the vault
/init-bootstrap
```

## Step 2: Install Agent Skills

### Option A: Plugin Marketplace (Recommended)

```bash
# Inside Claude Code
/plugin marketplace add kepano/obsidian-skills
/plugin install obsidian@obsidian-skills
```

### Option B: Manual Drop-In

Download the skills from [kepano/obsidian-skills](https://github.com/kepano/obsidian-skills) and place them in `.claude/skills/` inside your vault root.

## Step 3: Connect via MCP (Optional, for Real-Time Access)

Install the [Obsidian Claude Code MCP plugin](https://github.com/iansinnott/obsidian-claude-code-mcp) in Obsidian:

1. Install via BRAT or Community Plugins
2. Plugin starts an MCP server on port 22360
3. Claude Code auto-discovers the vault via WebSocket

This lets Claude Code read and write to your vault in real-time without the Terminal plugin.

## Step 4: Set Up Vault Structure

Use the PARA method (Projects, Areas, Resources, Archive):

```
~/Documents/obsidian-vault/
├── 00_Inbox/              # Quick capture, unsorted
├── 01_Projects/           # Active, time-bound work
│   ├── plc-direct/
│   ├── civi-platform/
│   └── master-crm/
├── 02_Areas/              # Ongoing responsibilities
│   ├── architecture/
│   ├── team-management/
│   └── client-relations/
├── 03_Resources/          # Reference materials
│   ├── patterns/
│   ├── tech-decisions/
│   └── debugging-journal/
├── 04_Archive/            # Completed work
├── 05_Attachments/        # Images, PDFs
├── 06_Templates/          # Note templates
└── .claude/               # Agent skills live here
    └── skills/
```

## Step 5: Create Templates

### Decision Record Template

```markdown
---
type: decision
date: {{date}}
status: accepted
---

# Decision: {{title}}

## Context
[What prompted this decision?]

## Options Considered
1. [Option A] — Pros / Cons
2. [Option B] — Pros / Cons

## Decision
[What we chose and why]

## Consequences
[What changes as a result]
```

### Debug Journal Template

```markdown
---
type: debug
date: {{date}}
project: {{project}}
severity: [low/medium/high/critical]
---

# Bug: {{title}}

## Symptoms
[What was observed]

## Root Cause
[Five Whys analysis]

## Fix
[What was changed]

## Prevention
[How to avoid this in the future]
```

## Step 6: Daily Workflow

### Morning

```bash
cd ~/Documents/obsidian-vault
claude

> Check 00_Inbox for unsorted notes. 
> Categorize them into the appropriate project or resource folder.
> Summarize what needs attention today based on my project notes.
```

### During Work

Claude Code + claude-mem captures everything automatically. For explicit captures:

```bash
> Save this architecture decision to 03_Resources/tech-decisions/
```

### End of Day

```bash
> Review today's Claude Code sessions.
> Create a daily note summarizing: what was built, decisions made, blockers hit.
> Save to 01_Projects/[current-project]/daily/{{date}}.md
```

## Obsidian Plugins That Pair Well

| Plugin | Why |
|--------|-----|
| **Terminal** | Run Claude Code directly inside Obsidian |
| **Web Clipper** | Save web research to vault for Claude to process |
| **Dataview** | Query your notes programmatically |
| **Templater** | Dynamic templates for structured notes |
| **Git** | Auto-commit vault changes |
| **Kanban** | Visual task boards from Markdown |

## Sources

- [Obsidian Skills (official)](https://github.com/kepano/obsidian-skills)
- [Claudesidian vault template](https://github.com/heyitsnoah/claudesidian)
- [Obsidian Claude Code MCP](https://github.com/iansinnott/obsidian-claude-code-mcp)
- [Claudian plugin](https://github.com/YishenTu/claudian)
- [XDA: Claude Code Inside Obsidian](https://www.xda-developers.com/claude-code-inside-obsidian-and-it-was-eye-opening/)
