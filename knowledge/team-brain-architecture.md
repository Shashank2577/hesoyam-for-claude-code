# Team Brain Architecture

> An AI-powered people management and knowledge system using Claude Code, Obsidian, and Granola.

## The Vision

Every engineering team has tribal knowledge — architecture decisions, debugging patterns, client preferences, sprint learnings — that lives in people's heads and dies when they switch contexts, go on vacation, or leave the team.

The Team Brain captures this knowledge automatically and makes it queryable by both humans and agents.

## Architecture

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│    Granola       │     │   Claude Code    │     │   NotebookLM    │
│  (Meetings)      │     │  (Dev Sessions)  │     │  (Research)     │
└────────┬────────┘     └────────┬────────┘     └────────┬────────┘
         │                       │                        │
         ▼                       ▼                        ▼
┌──────────────────────────────────────────────────────────────────┐
│                    Obsidian Vault (Shared)                        │
│                                                                  │
│  00_Inbox/          ← Raw captures land here                     │
│  01_Projects/       ← Active project context                     │
│  02_Areas/          ← Ongoing team responsibilities              │
│  03_Resources/      ← Patterns, decisions, lessons               │
│  04_Archive/        ← Completed work for reference               │
│  05_People/         ← Team member context & preferences          │
│  06_Clients/        ← Client-specific knowledge                  │
└──────────────────────────────────────────────────────────────────┘
         │
         ▼
┌──────────────────────────────────────────────────────────────────┐
│                    claude-mem (Session Memory)                    │
│  Captures: decisions, patterns, bugs, fixes, architecture        │
│  Queryable: "What did we decide about auth last sprint?"         │
└──────────────────────────────────────────────────────────────────┘
```

## Implementation Options

### Option A: Internal Tool (Recommended for small teams)

Build it as a set of Claude Code slash commands + Obsidian vault:
- `/team-standup` — Generate standup from session history
- `/team-retro` — Surface patterns across last N sessions
- `/team-onboard [person]` — Generate onboarding context from vault
- `/team-handoff [project]` — Create handoff document from project memory

### Option B: Productized Work OS Feature

Extract the shared services into a reusable Work OS layer:
- Meeting transcription processing pipeline
- Semantic search across team knowledge
- Role-based access to different knowledge domains
- Integration with existing CRM/project management

### Option C: Standalone Product

Package as a SaaS offering:
- Multi-tenant vault management
- Team-level memory with access controls
- Granola/Zoom/Meet integration out of the box
- Dashboard for knowledge health metrics

## Getting Started

1. Set up a shared Obsidian vault (Git-backed)
2. Install obsidian-skills + claude-mem
3. Create the folder structure above
4. Start with `/team-standup` automation
5. Iterate based on what your team actually queries

## Key Design Decisions

- **Local-first:** All knowledge stays on your infrastructure
- **Agent-agnostic:** Works with Claude Code today, portable to other agents tomorrow
- **Human-readable:** Everything is Markdown. No proprietary formats.
- **Incrementally adoptable:** Start with one slash command. Add complexity as value is proven.
