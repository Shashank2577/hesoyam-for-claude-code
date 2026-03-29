# 🔄 Git-Backed Obsidian: Version Control Your Brain

> Your knowledge base deserves the same version control as your code.

## Why Git + Obsidian?

1. **History** — See exactly when a decision was made and what changed
2. **Collaboration** — Team shares a single vault via Git
3. **Backup** — Your vault is replicated to a remote repo
4. **Branching** — Experiment with vault reorganization without risk
5. **Blame** — Know who added that questionable architecture note

## Setup Options

### Option 1: Obsidian Git Plugin (Recommended)

The community plugin auto-commits and pushes on a schedule.

1. **Create a private GitHub repo** via the GitHub CLI:
   ```bash
   cd ~/Documents/obsidian-vault
   git init -b main
   git add -A
   git commit -m "vault: initial template"

   # Create private repo and push in one command
   gh repo create obsidian-vault --private --source=. --push

   # Or if the repo already exists, just add the remote:
   # git remote add origin git@github.com:YOUR_USER/obsidian-vault.git
   # git push -u origin main
   ```
3. **Install the Obsidian Git plugin** via Community Plugins
4. **Configure auto-commit:**
   - Auto backup interval: 10 minutes
   - Commit message: `vault: auto-backup {{date}}`
   - Auto-pull on startup: enabled
   - Push after commit: enabled

### Option 2: Manual Git + Hooks

For teams that want more control:

```bash
# .git/hooks/post-commit (in your vault)
#!/bin/bash
git push origin main 2>/dev/null &
```

```bash
# Cron job for auto-commit (every 10 min)
*/10 * * * * cd ~/Documents/obsidian-vault && git add -A && git commit -m "auto: $(date +\%Y-\%m-\%d\ \%H:\%M)" 2>/dev/null && git push origin main 2>/dev/null
```

### Option 3: Claude Code PostToolUse Hook (Recommended — Auto-sync on Every Write)

Add a hook that auto-commits and pushes every time Claude Code writes to your vault. This is configured automatically by `install.sh --pillar knowledge`, or manually add to `~/.claude/settings.json`:

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "cd '~/Documents/obsidian-vault' && git add -A && git diff --cached --quiet || (git commit -m 'vault: auto-sync' && git push 2>/dev/null &)"
          }
        ]
      }
    ]
  }
}
```

This means: every time Claude creates an ADR, debug journal, or any note in your vault, it **immediately** commits and pushes. Your phone's Obsidian app will see the changes next time it syncs.

The `2>/dev/null &` runs the push in the background so it doesn't block Claude Code.

### Option 4: Claude Code SessionEnd Hook (Alternative — Sync at End of Session)

If you prefer fewer commits (one per session instead of one per file write):

```json
{
  "hooks": {
    "SessionEnd": [
      {
        "type": "command",
        "command": "cd ~/Documents/obsidian-vault && git add -A && git diff --cached --quiet || git commit -m 'session: auto-capture' && git push origin main"
      }
    ]
  }
}
```

**Which to use?**
- **PostToolUse (Option 3):** Real-time sync. Best for solo devs who want phone access immediately.
- **SessionEnd (Option 4):** Batched sync. Fewer commits, cleaner history. Better for team vaults.

## .gitignore for Obsidian

```gitignore
# Obsidian workspace (local to each user)
.obsidian/workspace.json
.obsidian/workspace-mobile.json

# Obsidian cache
.obsidian/cache

# Plugin local data (secrets, API keys)
.obsidian/plugins/*/data.json

# OS files
.DS_Store
Thumbs.db
.trash/

# claude-mem database (keep this local, not in vault Git)
.claude-mem/
*.mv2
```

## Team Vault Structure

```
team-brain/                    # Git repo
├── .obsidian/                 # Shared plugin configs (committed)
│   ├── plugins/               # Plugin list (committed)
│   └── community-plugins.json # So everyone has same plugins
├── 00_Inbox/                  # Each dev has a subfolder
│   ├── dev-alice/
│   ├── dev-bob/
│   └── dev-carol/
├── 01_Projects/               # Project folders
│   ├── project-alpha/
│   │   ├── decisions/         # ADRs
│   │   ├── meetings/          # Meeting notes
│   │   ├── dailies/           # Standup notes
│   │   └── README.md          # Project context
│   └── project-beta/
├── 02_Areas/
├── 03_Resources/              # Shared team knowledge
│   ├── patterns/              # Reusable patterns
│   ├── tech-decisions/        # Cross-project ADRs
│   ├── onboarding/            # New team member guides
│   └── debugging-journal/     # Shared bug patterns
├── 04_Archive/
└── .claude/                   # Claude Code skills
    └── skills/
```

## Conflict Resolution

With multiple devs pushing to the same vault:

1. **Prefer subdirectories per person** for daily notes and inbox
2. **Use Obsidian's frontmatter** for metadata (Git-mergeable YAML)
3. **Avoid editing the same file simultaneously** — if needed, use Git branches
4. **Auto-pull before sessions:**
   ```bash
   cd ~/Documents/obsidian-vault && git pull --rebase origin main
   ```

## Integration with claude-mem

claude-mem and the Git-backed vault serve different purposes:

| | claude-mem | Obsidian Vault (Git) |
|---|---|---|
| **What** | Raw session captures | Curated knowledge |
| **Where** | `~/.claude-mem/` (local SQLite) | `~/vault/` (Git repo) |
| **Backed up** | No (local only)* | Yes (Git remote) |
| **Shared** | No (per-user) | Yes (via Git) |
| **Queryable by Claude** | At session start (auto-injected) | Via Skills or MCP |

*claude-mem with OpenClaw integration can share via Telegram/Discord/Slack

### The Full Loop

```
1. claude-mem auto-captures session → local SQLite
2. Weekly: /promote-to-vault extracts knowledge → Obsidian Markdown
3. Obsidian Git auto-commits → pushes to remote repo
4. Teammate pulls → Obsidian updated → Claude Code reads vault
5. Everyone has institutional memory
```

## Security Notes

- **Don't commit secrets.** Use `.gitignore` for `data.json` files and any plugin configs with API keys
- **Use private repos** for team vaults. Your architecture decisions are competitive intel
- **Review before pushing** if using manual commits. Auto-commit can push sensitive meeting notes
- **Consider separate vaults** for client-specific knowledge with different access controls
