# Recipe: Meeting Notes → Shipped Feature in One Session

> Granola meeting capture → Obsidian → Claude Code → Deployed code

## Ingredients

- Granola (meeting capture)
- Obsidian with obsidian-skills
- Claude Code with claude-mem + oh-my-claudecode
- 45 minutes of uninterrupted time

## Steps

### 1. Capture the Meeting (Granola)

During your planning meeting, Granola auto-transcribes. After the meeting, export structured notes to your Obsidian vault:

```
Obsidian/01_Projects/my-feature/meeting-2026-03-29.md
```

### 2. Feed Context to Claude Code

```bash
cd your-project
claude

# Claude Code picks up the Obsidian vault via MCP or skills
> Read the meeting notes in my vault for the feature we just discussed.
> Summarize the requirements and identify any ambiguities.
```

### 3. Interview & Plan

```bash
/deep-interview "Build the feature from our meeting notes"
```

Claude asks clarifying questions. You answer from memory of the meeting. The spec gets sharpened.

### 4. Execute

```bash
/autopilot
```

Claude builds it. Tests it. Reviews it. You sip coffee.

### 5. Memory Capture

claude-mem automatically captures:
- What was built
- Architecture decisions made
- Patterns discovered
- Any gotchas hit

Next session, this context is auto-injected.

## Time Breakdown

| Phase | Duration |
|-------|----------|
| Meeting | 30 min (already happening) |
| Feed context | 2 min |
| Interview | 10 min |
| Execution | 20-30 min |
| **Total new effort** | **~15 min of your attention** |

---

*This recipe works best when you've already been using claude-mem for a few sessions, so it has project context to draw from.*
