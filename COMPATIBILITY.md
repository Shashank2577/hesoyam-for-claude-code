# Compatibility Matrix

> Version requirements and tested compatibility for HESOYAM and all upstream dependencies.

**Last verified:** 2026-03-29

## Runtime Requirements

| Requirement | Minimum | Recommended | Notes |
|-------------|---------|-------------|-------|
| **Claude Code** | v2.1+ | Latest | Required for hooks, skills, and MCP support |
| **Node.js** | 18.0+ | 22 LTS | Required for oh-my-claudecode and ECC |
| **npm** | 9.0+ | 10+ | Comes with Node.js |
| **Git** | 2.30+ | 2.40+ | Required for worktrees, vault sync |
| **Python** | 3.10+ | 3.12+ | Only if using notebooklm-py (claude-mem is Node.js only) |
| **OS** | macOS 13+ / Ubuntu 22.04+ / Windows 11 (WSL2) | macOS 14+ | Native Windows without WSL is not supported |

## Upstream Project Versions

### Pillar I: Orchestration

| Project | Tested Version | Min Version | Install Command | Notes |
|---------|---------------|-------------|-----------------|-------|
| [oh-my-claudecode](https://github.com/Yeachan-Heo/oh-my-claudecode) | 4.1.x | 3.0.0 | `npm i -g oh-my-claude-sisyphus` | Breaking changes in v3 (new skill format) |

### Pillar II: Configuration & Security

| Project | Tested Version | Min Version | Install | Notes |
|---------|---------------|-------------|---------|-------|
| [everything-claude-code](https://github.com/affaan-m/everything-claude-code) | 1.9.x | 1.5.0 | `node install-plan.js` | v1.5 added selective install |

### Pillar III: Memory & Persistence

| Project | Tested Version | Min Version | Install | Notes |
|---------|---------------|-------------|---------|-------|
| [claude-mem](https://github.com/thedotmack/claude-mem) | 2.3.x | 2.0.0 | `npm i -g claude-mem` | v2.0 broke MCP protocol — requires 2.0+ |
| [claude-brain](https://github.com/memvid/claude-brain) | 0.5.x | 0.3.0 | See repo README | Uses .mv2 format, optional alternative to claude-mem |

### Pillar IV: Knowledge & Second Brain

| Project | Tested Version | Min Version | Install | Notes |
|---------|---------------|-------------|---------|-------|
| [Obsidian](https://obsidian.md) | 1.7.x | 1.5.0 | Download from obsidian.md | v1.5 added improved Markdown export |
| [obsidian-skills](https://github.com/kepano/obsidian-skills) | Latest | — | Clone into `.claude/skills/` | Follows Claude Code skill format |
| [claudesidian](https://github.com/heyitsnoah/claudesidian) | 1.2.x | 1.0.0 | See repo README | MCP bridge between Claude Code and Obsidian |
| [notebooklm-py](https://github.com/teng-lin/notebooklm-py) | 0.4.x | 0.2.0 | `pip install notebooklm-py` | Requires Google Cloud credentials |
| [Granola](https://granola.so) | Latest | — | Download from granola.so | Meeting transcription (optional) |

### Pillar V: Discovery

| Project | Tested Version | Min Version | Notes |
|---------|---------------|-------------|-------|
| [awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) | Latest | — | Reference catalog, no install needed |
| [awesome-claude-code-subagents](https://github.com/VoltAgent/awesome-claude-code-subagents) | Latest | — | Reference catalog |
| [awesome-claude-skills](https://github.com/ComposioHQ/awesome-claude-skills) | Latest | — | Reference catalog |

## Claude Code Feature Requirements

Different HESOYAM features require different Claude Code capabilities:

| Feature | Required Claude Code Capability | Since Version |
|---------|-------------------------------|---------------|
| Skills (slash commands) | Custom skills directory | v2.0 |
| Hooks (pre/post tool) | Hook configuration | v2.0 |
| MCP servers | MCP protocol support | v2.0 |
| Subagents | Agent tool | v2.0 |
| SessionStart hooks | Session lifecycle hooks | v2.1 |
| Selective MCP loading | MCP enable/disable | v2.0 |
| Context compaction | Manual compact trigger | v2.0 |

## Known Incompatibilities

| Issue | Affected Versions | Workaround |
|-------|------------------|------------|
| ECC + OMC duplicate hooks | ECC < 1.6 + OMC < 3.5 | Update both, or use `dedupe-hooks.sh` from ECC |
| claude-mem + claude-brain conflict | All versions | Use one or the other, not both simultaneously |
| Claudesidian port conflict with other MCPs | Claudesidian < 1.1 | Set custom port in Claudesidian config |
| Obsidian vault lock on Flatpak | Obsidian Flatpak | Use AppImage or native install instead |
| notebooklm-py auth failures | 0.2.x | Upgrade to 0.3+ (switched to OAuth) |

## Token Budget by Configuration

Understanding how many tokens each component consumes helps plan your setup:

| Component | Token Overhead | Type |
|-----------|---------------|------|
| **MCP server** (each) | 2,000–10,000 | Always loaded |
| **ECC agent** (each) | 1,000–3,000 | Loaded when invoked |
| **Skill** (each) | 500–2,000 | Loaded on demand |
| **Hook** (each) | ~100 | Always loaded |
| **claude-mem context** | 2,000–5,000 | SessionStart injection |

### Recommended Token Budgets

| Setup | MCPs | Agents | Skills | Estimated Overhead |
|-------|------|--------|--------|--------------------|
| **Minimal** (Pillar I+II) | 2–4 | 3 | 5 | ~25K tokens |
| **Memory** (Pillar I+II+III) | 3–5 | 4 | 8 | ~40K tokens |
| **Full** (All five) | 5–8 | 5 | 12 | ~60K tokens |
| **Max safe** | 10 | 6 | 15 | ~80K tokens |

> Rule of thumb: Keep total overhead under 80K tokens to leave room for your actual code context in a 200K window.

## Upgrading

When upgrading upstream projects:

1. **Read the changelog first.** Check for breaking changes.
2. **Test in a sandbox.** Create a test project, install the new version, verify your workflow.
3. **Pin known-good versions.** After testing, record the version in your CLAUDE.md.
4. **One upgrade at a time.** Never upgrade multiple pillars simultaneously.

```bash
# Example: upgrade oh-my-claudecode
npm update -g oh-my-claude-sisyphus

# Verify
oh-my-claudecode --version

# If broken, rollback
npm install -g oh-my-claude-sisyphus@4.1.7
```
