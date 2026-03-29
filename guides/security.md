# 🔒 Security Guide: Protecting Your Workflow

> The more powerful your tools, the more carefully you need to wield them.

## Why Security Matters Here

When Claude Code has access to your terminal, file system, Git repos, API keys, and cloud infrastructure, a single prompt injection or misconfigured skill can cause real damage. This guide covers defense-in-depth for the HESOYAM stack.

## Layer 1: ECC Security Hooks (Passive Defense)

Everything-claude-code ships PreToolUse hooks that block common mistakes:

### Secret Detection

Hooks automatically detect and block secrets in prompts:

```
Patterns blocked: sk-*, ghp_*, AKIA*, aws_secret_access_key, etc.
```

If you accidentally paste an API key into a prompt, the hook stops it before it reaches the model.

### Force-Push Prevention

```json
{
  "PreToolUse": {
    "Bash": "block-no-verify.sh"
  }
}
```

Blocks `git push --force` and `git commit --no-verify` to prevent bypassing pre-commit hooks.

### Config Protection

Hooks intercept writes to linter/formatter configs (`.eslintrc`, `biome.json`, `.ruff.toml`). Prevents the agent from "fixing" lint errors by loosening rules instead of fixing code.

## Layer 2: AgentShield (Active Scanning)

ECC includes AgentShield — a security scanner with 1,282 tests and 102 static analysis rules.

### Basic Scan

```bash
/security-scan
```

Runs OWASP Top 10 analysis, checks for common vulnerabilities in your code.

### Red Team Mode (Opus)

```bash
# Requires Opus model access
/security-scan --opus
```

Runs three Claude Opus agents simultaneously:
1. **Red Team** — Tries to find vulnerabilities
2. **Blue Team** — Evaluates the red team's findings
3. **Auditor** — Arbitrates disagreements and produces final report

This catches things that single-pass scanning misses.

## Layer 3: Permission Model

### Claude Code's Built-in Permissions

- **Plan Mode** (Shift+Tab) — Claude proposes changes, you approve before execution
- **Permission prompts** — Claude asks before running destructive commands
- **YOLO mode** — Skips permission prompts. Use only in sandboxed environments

**Recommendation:** Never use YOLO mode on production codebases. Use Plan Mode for unfamiliar codebases.

### oh-my-claudecode Modes

| Mode | Risk Level | When to Use |
|------|-----------|-------------|
| **Deep Interview** | Low | Requirements gathering, no code changes |
| **Ecomode** | Low | Read-only exploration, low token usage |
| **Team** | Medium | Coordinated agents, review before merge |
| **Autopilot** | High | Well-specced tasks in sandboxed environments |
| **Ultrapilot** | High | Same as Autopilot but parallel — more agents, more surface area |

**Recommendation:** Use Deep Interview → Team for most work. Reserve Autopilot/Ultrapilot for well-defined tasks with test coverage.

## Layer 4: Plugin/Skill Vetting

### Community Skills

Skills from the Claude Code marketplace or GitHub repos can execute arbitrary code. Before installing:

1. **Read the source code.** Skills are Markdown + scripts. Read them.
2. **Check the author.** Known maintainers with history > anonymous repos
3. **Check the stars/forks.** Popular doesn't mean safe, but zero stars means zero vetting
4. **Run in a sandbox first.** Docker container or VM for untrusted skills

### MCP Server Security

MCP servers bridge Claude Code to external services. Each one is an attack surface.

- **Audit MCP permissions.** Does the Slack MCP need write access? Maybe read-only is enough
- **Limit MCP count.** Each enabled MCP increases your attack surface
- **Prefer official MCPs.** Anthropic-maintained > community-maintained > unknown

### OpenClaw Warning

If you're using oh-my-claudecode's OpenClaw integration, read ECC's [OpenClaw Security Guide](https://github.com/affaan-m/everything-claude-code/blob/main/the-openclaw-guide.md) first. Key concerns:

- Every connected channel (Telegram, Discord, Slack) is an injection surface
- Community-contributed skills on ClawdHub have no formal review process
- Prompt injection via messaging channels is a real, demonstrated risk

## Layer 5: Data Hygiene

### What Not to Store

| Data Type | claude-mem | Obsidian Vault | Git Remote |
|-----------|-----------|----------------|-----------|
| API keys | ❌ Never | ❌ Never | ❌ Never |
| Passwords | ❌ Never | ❌ Never | ❌ Never |
| Client PII | ⚠️ Auto-captured* | ⚠️ Be careful | ❌ Never |
| Architecture decisions | ✅ Auto | ✅ Curated | ✅ Via vault |
| Code patterns | ✅ Auto | ✅ Curated | ✅ Via vault |

*claude-mem may capture PII from session context. Review observations periodically and delete sensitive ones.

### Vault Security

- Use **private Git repos** for team vaults
- Add `data.json` to `.gitignore` (plugin configs may contain keys)
- Separate vaults for different clients/security domains
- Review auto-committed content before pushing to shared repos

## Practical Checklist

Before starting any session:

- [ ] ECC security hooks are enabled
- [ ] `--no-verify` and force-push are blocked
- [ ] MCP count is under 10
- [ ] No API keys in CLAUDE.md or skills
- [ ] Vault .gitignore excludes sensitive plugin data
- [ ] Using Plan Mode for unfamiliar codebases

Before deploying or merging:

- [ ] `/security-scan` passed
- [ ] `/code-review` completed
- [ ] No hardcoded secrets in diff
- [ ] Test coverage adequate
- [ ] PR reviewed by human

## Sources

- [ECC AgentShield](https://github.com/affaan-m/everything-claude-code)
- [ECC OpenClaw Security Guide](https://github.com/affaan-m/everything-claude-code/blob/main/the-openclaw-guide.md)
- [Claude Code Safety Net Plugin](https://github.com/kenryu42/claude-code-safety-net)
- [Anthropic Claude Code Security Docs](https://docs.claude.com)
