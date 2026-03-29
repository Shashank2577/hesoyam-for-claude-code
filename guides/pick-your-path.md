# 🛤️ Pick Your Path: Choose Your Setup

> Not everyone uses the same tools. HESOYAM adapts to you.

## Path A: Claude Code Only (No Obsidian, No NotebookLM)

**You want:** Better Claude Code sessions, period. No extra apps.

### Minimal Setup (15 min)

```bash
# 1. Install ECC for guardrails + agents
/plugin marketplace add affaan-m/everything-claude-code
/plugin install everything-claude-code@everything-claude-code

# 2. Install claude-brain for single-file memory
/plugin add marketplace memvid/claude-brain

# 3. Done. Use it:
/plan "Build feature X"
/code-review
/mind search "what did we decide about auth?"
```

### What You Get

- 28 agents, 125 skills, 60 commands
- Security hooks (secret detection, force-push blocking)
- Persistent memory in one `.mv2` file (~70KB, grows ~1KB per memory)
- No external dependencies beyond Claude Code

### What You Don't Get

- Structured knowledge base (your learnings live only in memory)
- Meeting-to-code pipeline
- Cross-session knowledge graphs
- Team-shared knowledge

### When to Upgrade

When you catch yourself saying: "Wait, didn't we already solve this problem last month?"

---

## Path B: Claude Code + Memory (claude-mem, No Obsidian)

**You want:** Rich session memory with semantic search, but no note-taking app.

### Setup (20 min)

```bash
# 1. Install ECC
/plugin marketplace add affaan-m/everything-claude-code
/plugin install everything-claude-code@everything-claude-code

# 2. Install claude-mem (full memory system)
/plugin marketplace add thedotmack/claude-mem
/plugin install claude-mem

# 3. Restart Claude Code. Memory is automatic from here.
```

### What You Get

- Everything from Path A, plus:
- Auto-capture of every session (decisions, bugs, fixes, patterns)
- SQLite database with full-text + semantic search
- Timeline reports (`/timeline-report`)
- Web viewer at `localhost:37777` for browsing memory
- Context auto-injected at session start

### What You Don't Get

- Structured notes (memory is auto-generated, not hand-curated)
- Visual knowledge graphs
- Integration with meeting tools
- Markdown files you can share with the team

### When to Upgrade

When you want to share knowledge with teammates, or when auto-captured memory isn't organized enough for long-term reference.

---

## Path C: Claude Code + Obsidian (The Second Brain)

**You want:** A persistent, structured knowledge base that Claude Code reads and writes to.

### Setup (30 min)

```bash
# 1. Install ECC
/plugin marketplace add affaan-m/everything-claude-code
/plugin install everything-claude-code@everything-claude-code

# 2. Install claude-mem for session memory
/plugin marketplace add thedotmack/claude-mem
/plugin install claude-mem

# 3. Set up Obsidian vault (see guides/obsidian-setup.md)
git clone https://github.com/heyitsnoah/claudesidian.git my-vault
cd my-vault

# 4. Install Obsidian Skills
/plugin marketplace add kepano/obsidian-skills
/plugin install obsidian@obsidian-skills

# 5. Optional: MCP connection for real-time vault access
# Install obsidian-claude-code-mcp plugin in Obsidian
```

### What You Get

- Everything from Path B, plus:
- Structured Markdown knowledge base (PARA method)
- Decision records, debug journals, meeting notes
- Git-backed version control on all knowledge
- Claude Code can read/write/search your vault
- Templates for consistent note-taking
- Sharable with team via Git

### Git-Backed Vault Workflow

See **[guides/obsidian-git-workflow.md](guides/obsidian-git-workflow.md)** for the complete setup.

---

## Path D: Full HESOYAM (Everything)

**You want:** The complete loop. Meeting → Knowledge → Memory → Orchestration → Delivery.

### Setup (45 min)

Everything from Path C, plus:

```bash
# 4. Install oh-my-claudecode for orchestration
/plugin marketplace add Yeachan-Heo/oh-my-claudecode
/plugin install oh-my-claudecode
/oh-my-claudecode:omc-setup

# 5. Install notebooklm-py for research/content pipeline
pip install "notebooklm-py[browser]"
notebooklm login

# 6. Set up Granola for meeting capture (optional)
# Download from granola.so
```

### What You Get

- Everything from Path C, plus:
- 5 execution modes (Autopilot, Ultrapilot, Team, Pipeline, Ecomode)
- Multi-model orchestration (Claude + Codex + Gemini)
- HUD for real-time usage monitoring
- Stop callbacks to Telegram/Discord/Slack
- NotebookLM content generation (podcasts, slides, mind maps)
- Meeting capture → code pipeline

---

## Path Comparison

| Feature | A: Minimal | B: + Memory | C: + Obsidian | D: Full |
|---------|-----------|-------------|---------------|---------|
| ECC agents & skills | ✅ | ✅ | ✅ | ✅ |
| Security hooks | ✅ | ✅ | ✅ | ✅ |
| Session memory | Basic (.mv2) | Full (SQLite) | Full (SQLite) | Full (SQLite) |
| Knowledge base | ❌ | ❌ | ✅ (Obsidian) | ✅ (Obsidian) |
| Git-backed knowledge | ❌ | ❌ | ✅ | ✅ |
| Team sharing | ❌ | Via OpenClaw | Via Git | Via Git + NLM |
| Multi-agent orchestration | ❌ | ❌ | ❌ | ✅ |
| Content generation | ❌ | ❌ | ❌ | ✅ (NotebookLM) |
| Meeting capture | ❌ | ❌ | ❌ | ✅ (Granola) |
| Setup time | 15 min | 20 min | 30 min | 45 min |
| External tools | None | None | Obsidian | Obsidian + NLM + Granola |

**Start with Path A. Upgrade when you feel the pain.**
