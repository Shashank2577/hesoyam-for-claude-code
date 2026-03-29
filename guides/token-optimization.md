# Token Optimization: The Survival Guide

> Your 200K context window is not as big as you think. Here's how to protect it.

## The Problem

Claude Code's context window is 200K tokens. But with MCPs, skills, system prompts, and conversation history, your **effective** context can shrink to 70K or less before you've even started working.

## Rule 1: Audit Your MCP Load

```bash
# Check what's loaded
/mcp
```

**Target:** Under 10 MCPs enabled per project. Under 80 tools active total.

**Why:** Each MCP injects tool descriptions into context. The GitHub MCP alone can consume 5-10K tokens. Multiply by 10 MCPs and you've lost 25% of your window before typing a single prompt.

**Fix:** Convert MCPs to Skills where CLI equivalents exist:

| Instead of MCP... | Use Skill wrapping... |
|--------------------|-----------------------|
| GitHub MCP | `gh` CLI commands |
| Supabase MCP | `supabase` CLI commands |
| Docker MCP | `docker` CLI commands |

## Rule 2: Compact Strategically

Don't use auto-compact. Instead:

1. **Compact after planning, before execution.** The exploration context isn't needed for implementation.
2. **Compact after execution, before review.** The implementation details aren't needed for quality review.
3. **Compact after long debugging sessions.** The dead ends aren't needed once you've found the fix.

## Rule 3: Delegate File Reading to Subagents

When Claude reads a 2,000-line file, those lines consume YOUR context window. Instead:

```
Task(subagent_type="librarian", prompt="Summarize src/auth/service.ts")
```

The subagent's context is isolated. You get a summary. Your main context stays sharp.

## Rule 4: Inject Context Dynamically

Instead of putting everything in CLAUDE.md (which loads every session), use CLI flags:

```bash
# Only load auth context when working on auth
claude --context auth-rules.md

# Only load database patterns when doing migrations
claude --context db-patterns.md
```

## Rule 5: Model Selection Matters

| Task | Model | Why |
|------|-------|-----|
| Planning, architecture | Opus | Needs deep reasoning |
| Code generation | Sonnet | Best quality-per-token |
| File reading, summarization | Haiku | Fast, cheap, good enough |
| Security scanning | Opus (AgentShield) | Can't afford to miss vulnerabilities |

## Measuring Your Token Usage

Track your effective context usage over sessions. If you're consistently hitting compaction before completing tasks, your setup is too heavy.

**Sources:** These patterns are distilled from the [Everything Claude Code Longform Guide](https://github.com/affaan-m/everything-claude-code) by @affaanmustafa.
