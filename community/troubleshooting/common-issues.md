# Troubleshooting: Common Issues & Fixes

## Plugin Conflicts

### "Duplicate hooks file" error

**Problem:** You installed everything-claude-code and another plugin that both define hooks.

**Fix:** Do NOT add a `"hooks"` field to `.claude-plugin/plugin.json`. Claude Code v2.1+ auto-loads `hooks/hooks.json` from installed plugins. Declaring it explicitly causes duplicate detection errors.

### Plugins not loading after install

**Fix:** Restart Claude Code after installing any plugin. Plugins are not hot-loaded.

```bash
# Verify installation
/plugin list
```

---

## Context Window Issues

### "Claude seems confused / losing context"

**Problem:** Too many MCPs eating your context window.

**Diagnosis:**
```bash
/mcp   # Check what's loaded
```

**Fix:** Disable unused MCPs. Target under 10 enabled, under 80 tools active. Convert heavy MCPs to CLI-wrapping skills.

### "Auto-compact keeps triggering"

**Problem:** You're generating more context than you're consuming.

**Fix:**
1. Delegate file reading to subagents (librarian pattern)
2. Manually compact at logical breakpoints
3. Disable auto-compact and control it yourself

---

## oh-my-claudecode Issues

### Swarm agents not spawning

**Problem:** Usually a tmux session issue.

**Fix:** Ensure tmux is installed and a session is active:
```bash
tmux new-session -s work
```

### CCG command fails

**Problem:** Codex or Gemini CLI not installed.

**Fix:** Install the required CLIs:
```bash
# Codex
npm install -g @openai/codex

# Gemini
npm install -g @google/gemini-cli
```

---

## claude-mem Issues

### Empty context after mode switching

**Problem:** Switching from a non-code mode back to code mode leaves stale filters.

**Fix:** Restart the claude-mem worker:
```bash
claude-mem worker restart
```

### Worker not starting on Windows

**Problem:** Windows Terminal tab accumulation from error exits.

**Fix:** claude-mem exits with code 0 on errors to prevent this. Check:
```bash
claude-mem worker logs
```

---

## Obsidian Integration Issues

### Claude Code can't find the vault

**Problem:** MCP server not running or wrong port.

**Fix:**
1. Verify the Obsidian MCP plugin is enabled
2. Check port 22360 is available: `lsof -i :22360`
3. If running multiple vaults, each needs a unique port

### Flatpak/Snap Obsidian can't access Claude Code

**Problem:** Sandboxing blocks access to system binaries.

**Fix:**
```bash
flatpak override --user md.obsidian.Obsidian --filesystem=host
```

Or install Obsidian via AppImage/.deb/.rpm instead.

---

## General Tips

1. **When in doubt, restart Claude Code.** Plugin changes, config changes, and MCP changes often need a fresh session.
2. **Check the GitHub Issues** of the specific tool. Most issues have already been reported and solved.
3. **Join the Claude Developers Discord** for real-time help from the community.
4. **Use `/bug`** inside Claude Code to report issues directly to Anthropic.
