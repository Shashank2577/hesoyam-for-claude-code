# Memory Strategies: Making Claude Remember

> Choose the right memory system for your workflow.

## The Memory Landscape

| System | Storage | Search | Team Support | Setup Effort | Best For |
|--------|---------|--------|-------------|--------------|----------|
| **claude-mem** | SQLite local | Full-text + semantic | Via OpenClaw | Plugin install | Full-time Claude Code users |
| **claude-brain** | Single .mv2 file | Sub-ms Rust core | Git-shareable | Plugin install | Minimalists, portable setups |
| **claude-supermemory** | Cloud (Supermemory) | Semantic | Built-in team memory | API key required | Teams with budget |
| **Obsidian vault** | Markdown files | File search + MCP | Git-shared vault | Manual setup | Knowledge workers |
| **CLAUDE.md** | Text file | None (always loaded) | Per-repo | Zero | Project-specific context |

## Strategy 1: The Minimalist

```
CLAUDE.md (project context) + claude-brain (session memory)
```

One file for project context. One file for session memory. Both git-committable. Zero dependencies beyond Claude Code.

**When:** Solo developer, single project, wants simplicity.

## Strategy 2: The Professional

```
claude-mem (auto-capture) + Obsidian (structured knowledge) + CLAUDE.md (project rules)
```

Auto-capture everything. Structure the important stuff in Obsidian. Keep project-specific rules in CLAUDE.md.

**When:** Daily Claude Code user, multiple projects, wants searchable history.

## Strategy 3: The Team

```
claude-mem (individual memory) + Obsidian shared vault (team knowledge) + claude-supermemory (team memory) + Granola (meeting capture)
```

Individual memories stay personal. Team knowledge is shared via Obsidian. Supermemory bridges the gap. Meetings feed into the knowledge loop.

**When:** Engineering team, client projects, need shared context.

## Anti-Patterns

1. **Don't store everything.** Memory without curation is noise. Use signal extraction keywords.
2. **Don't rely only on CLAUDE.md.** It loads every session and eats context. Keep it under 2K tokens.
3. **Don't mix project memory across repos.** Each project should have isolated memory contexts.
4. **Don't skip memory for "quick" sessions.** Quick sessions produce insights too. Let auto-capture do its job.

## Memory Hygiene

### Weekly

- Review claude-mem observations for accuracy
- Archive completed project notes in Obsidian
- Prune CLAUDE.md of outdated rules

### Monthly

- Search for conflicting memories (decisions that were later reversed)
- Update team brain with cross-project patterns
- Generate a timeline report for project retrospectives:

```bash
# claude-mem timeline report
/timeline-report
```

## Sources

- [claude-mem documentation](https://github.com/thedotmack/claude-mem)
- [claude-brain README](https://github.com/memvid/claude-brain)
- [ECC Longform Guide — Memory Section](https://github.com/affaan-m/everything-claude-code)
