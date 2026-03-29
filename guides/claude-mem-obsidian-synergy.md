# 🔗 claude-mem + Obsidian: The Synergy Guide

> Auto-captured session memory meets hand-curated knowledge base. Together, they cover everything.

## Why Both?

**claude-mem** captures everything automatically — every tool call, every decision, every bug fix. It's comprehensive but unstructured. Think of it as your **raw memory**.

**Obsidian** is structured, curated, and organized. You control what goes in and how it's categorized. Think of it as your **refined knowledge**.

Together:

```
claude-mem  = "What happened in that session 3 weeks ago?" (auto-captured)
Obsidian    = "What's our architecture decision about auth?" (hand-curated)
Both        = Complete institutional memory with zero gaps
```

## Architecture

```
┌─────────────────────────────────┐
│        Claude Code Session       │
│                                  │
│  ┌───────────┐  ┌────────────┐  │
│  │ claude-mem │  │  Obsidian   │  │
│  │  (auto)    │  │  Skills     │  │
│  │            │  │  (manual)   │  │
│  └─────┬─────┘  └─────┬──────┘  │
│        │               │         │
│        ▼               ▼         │
│  ~/.claude-mem/    ~/Documents/obsidian-vault/      │
│  claude-mem.db     *.md files    │
│  (SQLite)          (Git-backed)  │
└──────┬──────────────┬────────────┘
       │              │
       ▼              ▼
  "What happened?"  "What do we know?"
  (temporal)        (structural)
```

## Setup

### 1. Install Both

```bash
# claude-mem
/plugin marketplace add thedotmack/claude-mem
/plugin install claude-mem

# Obsidian Skills  
/plugin marketplace add kepano/obsidian-skills
/plugin install obsidian@obsidian-skills
```

### 2. Configure claude-mem Signal Extraction

Edit `~/.claude-mem/settings.json` to capture high-signal events:

```json
{
  "signalExtraction": true,
  "signalKeywords": [
    "decided", "architecture", "decision", "bug", "fix", 
    "pattern", "tradeoff", "migration", "security", "performance"
  ],
  "signalTurnsBefore": 3,
  "includeTools": ["Edit", "Write", "Bash"]
}
```

This ensures claude-mem pays extra attention to architectural and debugging moments.

### 3. Set Up the Promotion Pipeline

Not everything in claude-mem deserves to be in Obsidian. Create a weekly promotion workflow:

**Skill: `.claude/skills/promote-to-vault/SKILL.md`**

```markdown
---
name: promote-to-vault
description: Review recent claude-mem observations and promote important ones to Obsidian
---

Review claude-mem observations from the last 7 days.
Identify observations that represent:
1. Architecture decisions (→ save as decision record)
2. Debugging patterns (→ save as debug journal entry)
3. Reusable patterns (→ save as resource)
4. Project milestones (→ update project notes)

For each identified observation:
- Create a properly formatted Obsidian note using the appropriate template
- Save to the correct vault folder (03_Resources, 01_Projects, etc.)
- Add frontmatter with date, type, and tags
- Link to related existing notes if applicable

Skip routine/trivial observations. Only promote knowledge with lasting value.
```

### 4. Usage

```bash
# Daily: claude-mem auto-captures everything. You do nothing.

# During work: Use Obsidian for intentional capture
> Save this architecture decision to the vault as a decision record.

# Weekly: Run the promotion pipeline
/promote-to-vault

# Querying: Use the right tool for the right question
> /mind search "what error did we hit with the payment module?"   # claude-mem
> Check the vault for our auth architecture decision.              # Obsidian
```

## The Two-Layer Query Pattern

When starting a new session, Claude Code now has two context sources:

**Layer 1 — claude-mem (auto-injected at SessionStart):**
- Recent session context
- Temporal continuity ("last time we were working on X")
- Bug fixes and implementation details

**Layer 2 — Obsidian (accessed via Skills or MCP):**
- Architecture decisions
- Project conventions
- Debug journals (curated from past bugs)
- Meeting notes and client context

```bash
# Claude Code naturally queries both layers:
> "What's our auth approach and did we hit any bugs implementing it?"
#   ├── Obsidian: "We use JWT with refresh tokens (ADR-007)"
#   └── claude-mem: "Last session, we fixed a token expiry race condition"
```

## Sync Strategy

### claude-mem → Obsidian (Weekly Promotion)

```
claude-mem observations → /promote-to-vault → Obsidian vault → Git commit
```

### Obsidian → Git (Continuous)

```
Obsidian vault → Git auto-commit (every 10 min) → Remote repo → Team access
```

### Team Workflow

```
Dev A: Works in Claude Code → claude-mem captures → promotes to Obsidian → pushes to Git
Dev B: Pulls from Git → Obsidian updated → Claude Code reads vault → has team context
```

## Anti-Patterns

1. **Don't duplicate everything.** claude-mem captures the session. Obsidian captures the knowledge. Don't copy raw session logs into your vault.

2. **Don't skip the promotion step.** If you never promote from claude-mem to Obsidian, you have memory but not knowledge. Memory fades (gets buried). Knowledge persists.

3. **Don't use Obsidian as a replacement for claude-mem.** Manual note-taking during coding sessions breaks flow. Let claude-mem handle the capture. Use Obsidian for synthesis after the fact.

4. **Don't over-tag.** A few well-chosen tags beat a hundred random ones. Tag by: project, type (decision/bug/pattern), and status (active/resolved/archived).

## Timeline

| Week 1 | Install both. Let claude-mem auto-capture. Use Obsidian for manual notes when you feel like it. |
|--------|---|
| **Week 2** | Run `/promote-to-vault` for the first time. See what claude-mem caught that you forgot. |
| **Week 3** | Refine signal keywords based on what's useful vs. noise. Adjust templates. |
| **Week 4** | Share your vault with the team via Git. You now have institutional memory. |
