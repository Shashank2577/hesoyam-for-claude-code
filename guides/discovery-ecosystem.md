# Discovery & Ecosystem Guide

> How to find, evaluate, and integrate new tools from the Claude Code ecosystem.

Pillar V is the one people skip. Don't. The ecosystem moves fast — a tool that didn't exist last month might save you 10 hours this month.

## The Catalogs

### Primary Catalogs

| Catalog | Focus | Update Frequency | Best For |
|---------|-------|-------------------|----------|
| [awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) | Everything Claude Code | Weekly | Skills, agents, MCPs, plugins, tutorials |
| [awesome-claude-code-toolkit](https://github.com/rohitg00/awesome-claude-code-toolkit) | Tools & configurations | Bi-weekly | Agent configs, commands, pre-built setups |
| [awesome-claude-code-subagents](https://github.com/VoltAgent/awesome-claude-code-subagents) | Specialized subagents | Weekly | Domain-specific subagents (K8s, iOS, ML) |
| [awesome-claude-skills](https://github.com/ComposioHQ/awesome-claude-skills) | Skills & integrations | Weekly | Composio, Playwright, MCP skills |

### Knowledge & Research Catalogs

| Catalog | Focus | Best For |
|---------|-------|----------|
| [awesome-notebooklm](https://github.com/etewiah/awesome-notebooklm) | NotebookLM ecosystem | Podcast tools, slide generators, API wrappers |
| [awesome-notebookLM-prompts](https://github.com/serenakeyitan/awesome-notebookLM-prompts) | Slide prompts | Converting research into presentations |

### System Internals

| Resource | What It Provides |
|----------|-----------------|
| [Claude Code System Prompts](https://github.com/PiebaldAI/claude-code-system-prompts) | Full system prompt dumps per version |
| [Claude Code Changelog](https://github.com/anthropics/claude-code/releases) | Official release notes, breaking changes |

## Monthly Discovery Workflow

Set a recurring calendar event: **"Tool Scout"** — 30 minutes, first Monday of each month.

### Step 1: Check the Catalogs (10 min)

```bash
# Open the main catalog and sort by recently added
# Focus on your stack's section

# In Claude Code:
> Search awesome-claude-code for new additions in the last 30 days
> Focus on: [your stack — e.g., "Next.js", "Python", "Kubernetes"]
> Summarize what's new and relevant to our project.
```

### Step 2: Evaluate New Finds (15 min)

For each promising tool, run it through this quick evaluation:

| Question | Pass | Fail |
|----------|------|------|
| Does it solve a problem I actually have? | Specific pain point identified | "Might be useful someday" |
| Is it actively maintained? (commit in last 30 days) | Yes | Last commit > 90 days ago |
| Does it have documentation? | README + examples | Just source code |
| What's the token cost? (MCPs eat context) | Fits within my budget | Would push me over 10 MCPs |
| Does it conflict with existing tools? | Clean integration | Overlaps with something I already have |
| Can I test it in 5 minutes? | Quick install + demo | Complex setup required |

### Step 3: Trial Integration (5 min)

If a tool passes evaluation:

```bash
# Install in a test project first
# Never install directly in production workflow

# Test project:
cd ~/test-project
claude

> Install [tool] and run a quick smoke test.
> Does it work? Does it conflict with anything?
> What's the token overhead? (check HUD before and after)
```

### Step 4: Document the Decision

Whether you adopt or skip, log it:

```bash
# In your Obsidian vault or CLAUDE.md:
# "Evaluated [tool] on [date]. Decision: [adopted/skipped]. Reason: [why]."
```

This prevents re-evaluating the same tool next month.

## Tool Categories & Recommendations

### Skills & Commands

Skills are the lightest-weight additions — no MCP overhead, just instructions loaded on demand.

**Where to find:**
- [awesome-claude-skills](https://github.com/ComposioHQ/awesome-claude-skills) — Cross-platform skills
- [everything-claude-code](https://github.com/affaan-m/everything-claude-code) — 125 battle-tested skills
- [oh-my-claudecode](https://github.com/Yeachan-Heo/oh-my-claudecode) — 31+ orchestration skills
- [obsidian-skills](https://github.com/kepano/obsidian-skills) — Knowledge management

**Evaluation tip:** A skill costs ~500-2000 tokens when loaded. An MCP costs 2000-10000+ tokens always. Prefer skills over MCPs for the same functionality.

### Agents & Subagents

Agents are heavier — they consume context for their system prompt and instructions.

**Where to find:**
- [awesome-claude-code-subagents](https://github.com/VoltAgent/awesome-claude-code-subagents) — 100+ specialized subagents
- [everything-claude-code](https://github.com/affaan-m/everything-claude-code) — 28 core agents

**Evaluation tip:** Only install agents for tasks you do at least weekly. A dormant agent is wasted context. Use ECC's selective install (`install-plan.js`) to audit what you actually use.

### MCP Servers

MCPs are the heaviest integration — they load tool definitions into every session.

**The MCP budget rule:** Keep under 10 active MCPs and under 80 tools total. Each MCP adds 2K-10K tokens of tool definitions to your context window.

**Where to find:**
- [MCP Hub](https://github.com/modelcontextprotocol) — Official MCP servers
- [awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) — Community MCP recommendations

**Evaluation tip:** Before adding an MCP, check if you can achieve the same thing with a CLI-wrapping skill. Example: Instead of the GitHub MCP (~5K tokens), create a skill that calls `gh` commands (~500 tokens when loaded).

### Memory & Persistence

**The memory landscape:**

| Tool | Approach | Best For |
|------|----------|----------|
| [claude-mem](https://github.com/thedotmack/claude-mem) | Auto-capture + SQLite | Comprehensive session memory |
| [claude-brain](https://github.com/memvid/claude-brain) | Single .mv2 file | Portable, zero-dependency memory |
| [claude-supermemory](https://github.com/supermemoryai/claude-supermemory) | Cloud-backed | Team memory, shared across projects |
| [claude-memory-extractor](https://github.com/obra/claude-memory-extractor) | Multi-dimensional extraction | Deep debugging pattern analysis |

**Evaluation tip:** Pick one primary memory system. Running multiple creates conflicts and redundant captures. See [memory-strategies.md](memory-strategies.md) for a detailed comparison.

## Staying Current

### Automated Updates

```bash
# Add to your .claude/commands/ as a slash command:
# /ecosystem-check

# Prompt:
# Check the latest releases and stars for:
# - oh-my-claudecode
# - everything-claude-code
# - claude-mem
# - obsidian-skills
# Compare against our installed versions.
# Flag any breaking changes or major new features.
```

### Community Channels

| Channel | What You'll Find |
|---------|-----------------|
| [Claude Code GitHub Discussions](https://github.com/anthropics/claude-code/discussions) | Official announcements, feature requests |
| r/ClaudeAI | Community experiments, workflow sharing |
| X/Twitter `#ClaudeCode` | Real-time tips and discoveries |
| Discord (various Claude communities) | Quick help, plugin recommendations |

### Version Pinning

When you find a tool that works, pin the version:

```bash
# In CLAUDE.md or your install notes:
# oh-my-claudecode: v4.1.7 (tested, stable)
# everything-claude-code: v1.9.0 (tested, stable)
# claude-mem: v2.3.1 (tested, stable)
```

Only upgrade when you have time to test. Upgrades during active sprint work cause surprise breakages.

## Anti-Patterns

1. **"Install everything" syndrome.** More tools does not equal more productive. Each tool costs context and cognitive overhead. Be surgical.

2. **Skipping the monthly scout.** The ecosystem doubled in 6 months. If you're not looking, you're missing tools that solve problems you're working around manually.

3. **No evaluation criteria.** "This looks cool" is not a reason to install something. Use the evaluation table above.

4. **Ignoring token costs.** That shiny new MCP might add 8K tokens to every session. Multiply by 50 sessions/month. That's real money and real context pressure.

5. **Never removing tools.** Audit quarterly. If you haven't used a tool in 30 days, remove it. You can always reinstall.
