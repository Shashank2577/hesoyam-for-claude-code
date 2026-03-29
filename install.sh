#!/usr/bin/env bash
set -euo pipefail

# ─── HESOYAM for Claude Code — Installer ──────────────────────────────────
# The cheat code for Claude Code. Health + Armor + $250K.
# Usage: ./install.sh [--pillar NAME] [--dry-run] [--vault-path PATH] [--repo-name NAME]
# Pillars: orchestration, config, memory, knowledge, discovery

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DRY_RUN=false
VAULT_PATH="${HOME}/Documents/obsidian-vault"
REPO_NAME="obsidian-vault"
CLAUDE_DIR="${HOME}/.claude"
PILLAR=""

# ─── Colors ──────────────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

info()  { echo -e "${BLUE}[INFO]${NC}  $1"; }
ok()    { echo -e "${GREEN}[ OK ]${NC}  $1"; }
warn()  { echo -e "${YELLOW}[WARN]${NC}  $1"; }
err()   { echo -e "${RED}[ERR]${NC}   $1"; }
dry()   { echo -e "${CYAN}[DRY]${NC}   Would run: $1"; }

# GTA San Andreas cheat activation sound
# Cross-platform: macOS (afplay), Linux (mpg123/paplay/aplay), Windows (powershell)
# Falls back to terminal bell if no audio player available
play_cheat_sound() {
  local sound_file="${SCRIPT_DIR}/assets/cheat-activated.mp3"
  if [[ -f "$sound_file" ]]; then
    if command -v afplay &>/dev/null; then
      # macOS
      afplay "$sound_file" &>/dev/null &
    elif command -v mpg123 &>/dev/null; then
      # Linux (mpg123)
      mpg123 -q "$sound_file" &>/dev/null &
    elif command -v ffplay &>/dev/null; then
      # Linux (ffmpeg)
      ffplay -nodisp -autoexit -loglevel quiet "$sound_file" &>/dev/null &
    elif command -v aplay &>/dev/null && command -v ffmpeg &>/dev/null; then
      # Linux (ALSA + ffmpeg convert)
      ffmpeg -i "$sound_file" -f wav - 2>/dev/null | aplay -q &>/dev/null &
    elif command -v powershell.exe &>/dev/null; then
      # Windows (WSL/Git Bash) — use PowerShell media player
      powershell.exe -NoProfile -Command "(New-Object Media.SoundPlayer '$(wslpath -w "$sound_file" 2>/dev/null || echo "$sound_file")').PlaySync()" &>/dev/null &
    elif command -v powershell &>/dev/null; then
      # Windows (native Git Bash/MSYS2)
      powershell -NoProfile -Command "(New-Object Media.SoundPlayer '$sound_file').PlaySync()" &>/dev/null &
    else
      # Universal fallback — terminal bell
      printf '\a'
    fi
  else
    # No sound file found — terminal bell
    printf '\a'
  fi
}

show_banner() {
  echo ""
  echo -e "${GREEN}  ██╗  ██╗███████╗███████╗ ██████╗ ██╗   ██╗ █████╗ ███╗   ███╗${NC}"
  echo -e "${GREEN}  ██║  ██║██╔════╝██╔════╝██╔═══██╗╚██╗ ██╔╝██╔══██╗████╗ ████║${NC}"
  echo -e "${GREEN}  ███████║█████╗  ███████╗██║   ██║ ╚████╔╝ ███████║██╔████╔██║${NC}"
  echo -e "${GREEN}  ██╔══██║██╔══╝  ╚════██║██║   ██║  ╚██╔╝  ██╔══██║██║╚██╔╝██║${NC}"
  echo -e "${GREEN}  ██║  ██║███████╗███████║╚██████╔╝   ██║   ██║  ██║██║ ╚═╝ ██║${NC}"
  echo -e "${GREEN}  ╚═╝  ╚═╝╚══════╝╚══════╝ ╚═════╝    ╚═╝   ╚═╝  ╚═╝╚═╝     ╚═╝${NC}"
  echo ""
  echo -e "  ${BOLD}The cheat code for Claude Code${NC}"
  echo -e "  ${CYAN}Health (Memory) · Armor (Security) · \$250K (Productivity)${NC}"
  echo ""
  play_cheat_sound
}

run_cmd() {
  if $DRY_RUN; then
    dry "$*"
  else
    eval "$@"
  fi
}

# ─── Argument Parsing ────────────────────────────────────────────────────────
while [[ $# -gt 0 ]]; do
  case $1 in
    --pillar)     PILLAR="$2"; shift 2 ;;
    --dry-run)    DRY_RUN=true; shift ;;
    --vault-path) VAULT_PATH="$(cd "$(dirname "$2")" 2>/dev/null && pwd)/$(basename "$2")"; shift 2 ;;
    --repo-name)  REPO_NAME="$2"; shift 2 ;;
    -h|--help)
      echo "Usage: ./install.sh [OPTIONS]"
      echo ""
      echo "Options:"
      echo "  --pillar NAME     Install a specific pillar (orchestration|config|memory|knowledge|discovery)"
      echo "  --dry-run         Show what would be done without making changes"
      echo "  --vault-path PATH Set Obsidian vault path (default: ~/Documents/obsidian-vault)"
      echo "  --repo-name NAME  Set GitHub repo name for vault (default: obsidian-vault)"
      echo "  -h, --help        Show this help message"
      echo ""
      echo "Examples:"
      echo "  ./install.sh                                    # Install all pillars"
      echo "  ./install.sh --dry-run                          # Preview all actions"
      echo "  ./install.sh --pillar knowledge                 # Install only Knowledge pillar"
      echo "  ./install.sh --vault-path ~/my-notes            # Use existing Obsidian vault"
      echo "  ./install.sh --pillar knowledge --repo-name my-brain  # Custom repo name"
      exit 0
      ;;
    *) err "Unknown option: $1"; exit 1 ;;
  esac
done

# ─── Prerequisites ───────────────────────────────────────────────────────────
check_prerequisites() {
  info "Checking prerequisites..."
  local missing=()

  command -v claude >/dev/null 2>&1 || missing+=("claude (Claude Code CLI) — npm install -g @anthropic-ai/claude-code")
  command -v node >/dev/null 2>&1   || missing+=("node (Node.js 18+) — https://nodejs.org/")
  command -v npm >/dev/null 2>&1    || missing+=("npm — comes with Node.js")
  command -v git >/dev/null 2>&1    || missing+=("git — https://git-scm.com/")
  command -v gh >/dev/null 2>&1     || missing+=("gh (GitHub CLI) — https://cli.github.com/")

  if [[ ${#missing[@]} -gt 0 ]]; then
    err "Missing required tools:"
    for tool in "${missing[@]}"; do
      echo "  - $tool"
    done
    echo ""
    exit 1
  fi

  # Check gh auth (only warn — required for knowledge pillar, not others)
  if ! gh auth status &>/dev/null; then
    warn "GitHub CLI is not authenticated. Required for the Knowledge pillar (vault sync)."
    echo "  Run: gh auth login"
  fi

  # Check Claude Code version
  local cc_version
  cc_version=$(claude --version 2>/dev/null | head -1 || echo "unknown")
  info "Claude Code version: $cc_version"

  ok "All prerequisites met."
}

# ─── Pillar I: Orchestration ────────────────────────────────────────────────
install_orchestration() {
  info "━━━ ⚔️  Pillar I: Orchestration — The Weapons ━━━"

  info "Installing oh-my-claudecode via Claude Code plugin system..."
  if ! $DRY_RUN; then
    # Register the OMC marketplace if not already registered
    if ! claude plugin list 2>/dev/null | grep -q "oh-my-claudecode"; then
      info "Adding oh-my-claudecode marketplace..."
      claude plugin marketplace add Yeachan-Heo/oh-my-claudecode 2>/dev/null || {
        warn "Could not register OMC marketplace via plugin system."
        warn "Falling back to npm install..."
        run_cmd "npm install -g oh-my-claude-sisyphus"
        if command -v oh-my-claudecode >/dev/null 2>&1; then
          run_cmd "oh-my-claudecode install"
        fi
        ok "Orchestration pillar installed (npm fallback)."
        return
      }
      info "Installing oh-my-claudecode plugin..."
      claude plugin install oh-my-claudecode@omc 2>/dev/null || {
        warn "Plugin install failed. Falling back to npm install..."
        run_cmd "npm install -g oh-my-claude-sisyphus"
        if command -v oh-my-claudecode >/dev/null 2>&1; then
          run_cmd "oh-my-claudecode install"
        fi
        ok "Orchestration pillar installed (npm fallback)."
        return
      }
    else
      ok "oh-my-claudecode plugin already installed."
    fi

    # Verify installation
    if claude plugin list 2>/dev/null | grep -q "oh-my-claudecode"; then
      ok "oh-my-claudecode registered as Claude Code plugin."
    elif command -v oh-my-claudecode >/dev/null 2>&1; then
      ok "oh-my-claudecode available via CLI."
    else
      warn "oh-my-claudecode installation could not be verified."
      warn "After install, run inside Claude Code: /oh-my-claudecode:omc-setup"
    fi
  else
    dry "claude plugin marketplace add Yeachan-Heo/oh-my-claudecode"
    dry "claude plugin install oh-my-claudecode@omc"
  fi

  ok "Orchestration pillar installed."
}

# ─── Pillar II: Configuration & Security ────────────────────────────────────
install_config() {
  info "━━━ 🛡️  Pillar II: Configuration & Security — The Armor ━━━"

  local ecc_dir="${HOME}/.hesoyam/everything-claude-code"
  if [[ -d "$ecc_dir" ]]; then
    info "Updating everything-claude-code..."
    run_cmd "cd '$ecc_dir' && git pull --ff-only"
  else
    info "Cloning everything-claude-code..."
    run_cmd "mkdir -p '${HOME}/.hesoyam'"
    run_cmd "git clone https://github.com/affaan-m/everything-claude-code.git '$ecc_dir'"
  fi

  info "Running ECC installer (selective mode)..."
  if ! $DRY_RUN; then
    if [[ -f "$ecc_dir/install-plan.js" ]]; then
      run_cmd "cd '$ecc_dir' && node install-plan.js"
    else
      warn "install-plan.js not found. Run manually: cd $ecc_dir && node install-plan.js"
    fi
  else
    dry "cd '$ecc_dir' && node install-plan.js"
  fi

  ok "Configuration pillar installed."
}

# ─── Pillar III: Memory & Persistence ───────────────────────────────────────
install_memory() {
  info "━━━ ❤️  Pillar III: Memory & Persistence — The Health Bar ━━━"

  info "Installing claude-mem..."
  run_cmd "npm install -g claude-mem"

  if ! $DRY_RUN; then
    if command -v claude-mem >/dev/null 2>&1; then
      info "Initializing claude-mem database..."
      run_cmd "claude-mem init 2>/dev/null || true"
    else
      warn "claude-mem not found in PATH. Restart terminal, then run: claude-mem init"
    fi
  else
    dry "claude-mem init"
  fi

  ok "Memory pillar installed."
}

# ─── Pillar IV: Knowledge & Second Brain ────────────────────────────────────
install_knowledge() {
  info "━━━ 💾  Pillar IV: Knowledge & Second Brain — The Safe House ━━━"
  echo ""

  # ── Step 1: Vault path + repo name (interactive if not provided via flags) ─
  if ! $DRY_RUN; then
    # Ask for vault path if user didn't provide --vault-path
    if [[ "$VAULT_PATH" == "${HOME}/Documents/obsidian-vault" ]]; then
      echo -e "  ${BOLD}Obsidian vault path:${NC} [${VAULT_PATH}]"
      read -r -p "  Press Enter to accept, or type your vault path: " user_vault_path
      if [[ -n "$user_vault_path" ]]; then
        # Expand ~ and resolve to absolute path
        user_vault_path="${user_vault_path/#\~/$HOME}"
        if [[ -d "$user_vault_path" ]]; then
          VAULT_PATH="$(cd "$user_vault_path" && pwd)"
        elif [[ -d "$(dirname "$user_vault_path")" ]]; then
          VAULT_PATH="$(cd "$(dirname "$user_vault_path")" && pwd)/$(basename "$user_vault_path")"
        else
          VAULT_PATH="$user_vault_path"
        fi
      fi
      echo ""
    fi

    # Only ask for repo name if vault doesn't already have git
    if [[ ! -d "${VAULT_PATH}/.git" ]]; then
      echo -e "  ${BOLD}Vault GitHub repo name:${NC} [${REPO_NAME}]"
      read -r -p "  Press Enter to accept, or type a new name: " user_repo_name
      if [[ -n "$user_repo_name" ]]; then
        REPO_NAME="$user_repo_name"
      fi
      echo ""
    else
      ok "Vault already has git — skipping repo setup prompts."
    fi
  fi

  # ── Step 2: Create vault from template ────────────────────────────────────
  info "Step 1/6: Creating vault at ${VAULT_PATH}"
  if [[ -d "$VAULT_PATH" ]]; then
    ok "Using existing vault: $VAULT_PATH"
  else
    run_cmd "cp -r '${SCRIPT_DIR}/knowledge/obsidian-vault-template' '$VAULT_PATH'"
    ok "Vault created with PARA structure."
  fi

  # ── Step 3: Create .gitignore ─────────────────────────────────────────────
  info "Step 2/6: Creating vault .gitignore"
  local gitignore_path="${VAULT_PATH}/.gitignore"
  if [[ -f "$gitignore_path" ]]; then
    warn ".gitignore already exists in vault, skipping."
  else
    if ! $DRY_RUN; then
      cat > "$gitignore_path" << 'GITIGNORE'
# Obsidian workspace (local to each device)
.obsidian/workspace.json
.obsidian/workspace-mobile.json

# Obsidian cache
.obsidian/cache

# Plugin local data (may contain API keys)
.obsidian/plugins/*/data.json

# OS files
.DS_Store
Thumbs.db

# Trash
.trash/

# claude-mem database (stays local, not in vault)
.claude-mem/
*.mv2
GITIGNORE
      ok "Created .gitignore"
    else
      dry "Create ${gitignore_path}"
    fi
  fi

  # ── Step 4: Git init + GitHub repo ────────────────────────────────────────
  info "Step 3/6: Setting up Git repo (${REPO_NAME})"

  if ! $DRY_RUN; then
    cd "$VAULT_PATH"

    # Init git if not already
    if [[ ! -d ".git" ]]; then
      git init -b main
      ok "Initialized git repository."
    else
      ok "Git already initialized."
    fi

    # GitHub remote setup (requires gh auth)
    if gh auth status &>/dev/null; then
      if gh repo view "$REPO_NAME" &>/dev/null; then
        ok "GitHub repo '${REPO_NAME}' already exists."
        # Ensure remote is set
        if ! git remote get-url origin &>/dev/null; then
          local repo_url
          repo_url=$(gh repo view "$REPO_NAME" --json url -q '.url')
          git remote add origin "$repo_url"
          ok "Set remote origin to: $repo_url"
        else
          ok "Remote origin already configured."
        fi
      else
        info "Creating private GitHub repo: ${REPO_NAME}"
        git add -A
        git commit -m "vault: HESOYAM initial setup — PARA structure, templates, .gitignore

Initialized Obsidian vault with:
- PARA folders: Inbox, Projects, Areas, Resources, Archive
- Templates: decision-record, debug-journal, daily-note, meeting-notes
- Git-backed auto-sync via Claude Code PostToolUse hook
- Ready for Obsidian desktop/mobile" --allow-empty
        gh repo create "$REPO_NAME" --private --source=. --push
        ok "Created and pushed to: github.com/$(gh api user -q '.login')/${REPO_NAME}"
      fi

      # Ensure initial commit exists and is pushed
      if [[ -z "$(git log --oneline -1 2>/dev/null)" ]]; then
        git add -A
        git commit -m "vault: HESOYAM initial setup — PARA structure, templates, .gitignore"
        git push -u origin main
        ok "Initial commit pushed."
      else
        # Push if there are unpushed commits
        if ! git diff --quiet origin/main HEAD 2>/dev/null; then
          git add -A
          git diff --cached --quiet || git commit -m "vault: template update"
          git push -u origin main 2>/dev/null || true
        fi
      fi
    else
      warn "GitHub CLI not authenticated — skipping remote repo setup."
      warn "Vault will work locally. Run 'gh auth login' then re-run for sync."
    fi

    cd "$SCRIPT_DIR"
  else
    dry "cd '$VAULT_PATH' && git init -b main"
    dry "gh repo create '$REPO_NAME' --private --source=. --push"
  fi

  # ── Step 5: Install skills globally ───────────────────────────────────────
  info "Step 4/6: Installing HESOYAM skills to ${CLAUDE_DIR}/skills/"
  run_cmd "mkdir -p '${CLAUDE_DIR}/skills'"

  if [[ -d "${SCRIPT_DIR}/.claude/skills" ]]; then
    for skill_dir in "${SCRIPT_DIR}"/.claude/skills/*/; do
      [[ -d "$skill_dir" ]] || continue
      [[ -f "${skill_dir}/SKILL.md" ]] || continue
      local skill_name
      skill_name=$(basename "$skill_dir")
      if [[ -d "${CLAUDE_DIR}/skills/${skill_name}" ]]; then
        warn "Skill already exists, skipping: ${skill_name}"
      else
        run_cmd "mkdir -p '${CLAUDE_DIR}/skills/${skill_name}'"
        run_cmd "cp '${skill_dir}/SKILL.md' '${CLAUDE_DIR}/skills/${skill_name}/SKILL.md'"
        ok "Installed skill: ${skill_name}"
      fi
    done
  fi

  # ── Step 6: Add auto-sync hook to Claude Code settings ───────────────────
  info "Step 5/6: Configuring vault auto-sync hook"
  local settings_file="${CLAUDE_DIR}/settings.json"
  local hook_script="cd '${VAULT_PATH}' && git add -A && git diff --cached --quiet || (git commit -m 'vault: auto-sync' && git push 2>/dev/null &)"

  if ! $DRY_RUN; then
    # Create settings.json if it doesn't exist
    if [[ ! -f "$settings_file" ]]; then
      echo '{}' > "$settings_file"
    fi

    # Check if hook already exists (simple grep check)
    if grep -q "vault.*auto-sync" "$settings_file" 2>/dev/null; then
      warn "Auto-sync hook already configured in settings.json"
    else
      # Use node to safely merge the hook into settings.json
      if command -v node >/dev/null 2>&1; then
        node -e "
          const fs = require('fs');
          const path = '${settings_file}';
          let settings = {};
          try { settings = JSON.parse(fs.readFileSync(path, 'utf8')); } catch(e) {}
          if (!settings.hooks) settings.hooks = {};
          if (!settings.hooks.PostToolUse) settings.hooks.PostToolUse = [];
          // Check if vault hook already exists
          const exists = settings.hooks.PostToolUse.some(h => h.matcher === 'Write|Edit' && h.hooks && h.hooks.some(k => k.command && k.command.includes('vault')));
          if (!exists) {
            settings.hooks.PostToolUse.push({
              matcher: 'Write|Edit',
              hooks: [{ type: 'command', command: \"${hook_script}\" }]
            });
          }
          fs.writeFileSync(path, JSON.stringify(settings, null, 2) + '\n');
        "
        ok "Auto-sync hook added to: ${settings_file}"
        info "When Claude writes to your vault, changes auto-commit and push to GitHub."
      else
        warn "Node.js not available to update settings.json."
        warn "Manually add this PostToolUse hook to ${settings_file}:"
        echo '  { "matcher": "Write|Edit", "hooks": [{ "type": "command", "command": "'"${hook_script}"'" }] }'
      fi
    fi
  else
    dry "Add PostToolUse auto-sync hook to ${settings_file}"
  fi

  # ── Step 6: Obsidian detection + next steps ──────────────────────────────
  info "Step 6/6: Checking for Obsidian"
  if command -v obsidian >/dev/null 2>&1 || [[ -d "/Applications/Obsidian.app" ]] || [[ -d "${HOME}/.local/share/obsidian" ]]; then
    ok "Obsidian detected."
    echo ""
    echo -e "  ${BOLD}Next steps:${NC}"
    echo "  1. Open Obsidian → 'Open folder as vault' → select: ${VAULT_PATH}"
    echo "  2. In Claude Code, install obsidian-skills:"
    echo "     /plugin marketplace add kepano/obsidian-skills"
    echo "     /plugin install obsidian@obsidian-skills"
    echo "  3. (Optional) Install Obsidian Git plugin for timed auto-sync"
    echo "  4. (Phone) Install Obsidian mobile app → clone the same repo"
  else
    warn "Obsidian not detected. Install from https://obsidian.md"
    echo "  After installing: Open Obsidian → 'Open folder as vault' → ${VAULT_PATH}"
  fi

  echo ""
  ok "Knowledge pillar installed."
}

# ─── Pillar V: Discovery & Ecosystem ───────────────────────────────────────
install_discovery() {
  info "━━━ 🗺️  Pillar V: Discovery & Ecosystem — The Map ━━━"

  info "The Discovery pillar is documentation-driven."
  info "Key resources:"
  echo "  - guides/discovery-ecosystem.md    — Full ecosystem guide with evaluation criteria"
  echo "  - guides/pick-your-path.md         — Choose your installation depth"
  echo ""

  local bookmarks_file="${CLAUDE_DIR}/ecosystem-bookmarks.md"
  if ! $DRY_RUN; then
    cat > "$bookmarks_file" << 'BOOKMARKS'
# Ecosystem Bookmarks

## Core Catalogs
- awesome-claude-code: https://github.com/hesreallyhim/awesome-claude-code
- awesome-claude-code-toolkit: https://github.com/rohitg00/awesome-claude-code-toolkit
- awesome-claude-code-subagents: https://github.com/VoltAgent/awesome-claude-code-subagents
- awesome-claude-skills: https://github.com/ComposioHQ/awesome-claude-skills

## Knowledge Catalogs
- awesome-notebooklm: https://github.com/etewiah/awesome-notebooklm
- awesome-notebookLM-prompts: https://github.com/serenakeyitan/awesome-notebookLM-prompts

## Upstream Projects
- oh-my-claudecode: https://github.com/Yeachan-Heo/oh-my-claudecode
- everything-claude-code: https://github.com/affaan-m/everything-claude-code
- claude-mem: https://github.com/thedotmack/claude-mem
- claude-brain: https://github.com/memvid/claude-brain
- obsidian-skills: https://github.com/kepano/obsidian-skills
- claudesidian: https://github.com/heyitsnoah/claudesidian
- notebooklm-py: https://github.com/teng-lin/notebooklm-py
BOOKMARKS
    ok "Saved ecosystem bookmarks to: $bookmarks_file"
  else
    dry "Create $bookmarks_file"
  fi

  ok "Discovery pillar installed."
}

# ─── Post-Install Verification ─────────────────────────────────────────────
verify_installation() {
  echo ""
  info "━━━ Verifying installation ━━━"
  local pass=0
  local fail=0

  # Check skills (directory/SKILL.md format)
  for skill in promote-to-vault daily-standup research-sprint ecosystem-check; do
    if [[ -f "${CLAUDE_DIR}/skills/${skill}/SKILL.md" ]]; then
      ok "Skill OK: /$(echo $skill)"
      ((pass++))
    elif [[ -f "${CLAUDE_DIR}/skills/${skill}.md" ]]; then
      warn "Skill ${skill} uses old flat format — migrating to directory structure..."
      mkdir -p "${CLAUDE_DIR}/skills/${skill}"
      mv "${CLAUDE_DIR}/skills/${skill}.md" "${CLAUDE_DIR}/skills/${skill}/SKILL.md"
      ok "Skill migrated: /$(echo $skill)"
      ((pass++))
    else
      warn "Skill missing: ${skill}"
      ((fail++))
    fi
  done

  # Check oh-my-claudecode
  if claude plugin list 2>/dev/null | grep -q "oh-my-claudecode"; then
    ok "Plugin OK: oh-my-claudecode (registered in plugin system)"
    ((pass++))
  elif command -v oh-my-claudecode >/dev/null 2>&1; then
    warn "oh-my-claudecode installed via npm but not as a Claude Code plugin."
    warn "Skills like /oh-my-claudecode:omc-setup may not work."
    warn "To fix: claude plugin add-marketplace omc --source github --repo Yeachan-Heo/oh-my-claudecode"
    warn "        claude plugin install oh-my-claudecode@omc"
    ((fail++))
  else
    warn "oh-my-claudecode not found."
    ((fail++))
  fi

  # Check claude-mem
  if command -v claude-mem >/dev/null 2>&1; then
    ok "Memory OK: claude-mem installed"
    ((pass++))
  else
    warn "claude-mem not found."
    ((fail++))
  fi

  # Check vault
  if [[ -d "${VAULT_PATH}/.git" ]]; then
    ok "Vault OK: ${VAULT_PATH} (git initialized)"
    ((pass++))
  else
    warn "Vault not initialized: ${VAULT_PATH}"
    ((fail++))
  fi

  # Check hook format in settings.json
  local settings_file="${CLAUDE_DIR}/settings.json"
  if [[ -f "$settings_file" ]] && command -v node >/dev/null 2>&1; then
    local hook_valid
    hook_valid=$(node -e "
      const s = JSON.parse(require('fs').readFileSync('${settings_file}', 'utf8'));
      const ptu = s.hooks && s.hooks.PostToolUse;
      if (!ptu) { console.log('missing'); process.exit(); }
      const valid = ptu.every(h => h.matcher && Array.isArray(h.hooks));
      console.log(valid ? 'valid' : 'invalid');
    " 2>/dev/null)
    if [[ "$hook_valid" == "valid" ]]; then
      ok "Hooks OK: PostToolUse format is valid"
      ((pass++))
    elif [[ "$hook_valid" == "invalid" ]]; then
      warn "PostToolUse hooks use incorrect format (missing 'hooks' array)."
      warn "Claude Code will skip the entire settings.json if hooks are malformed."
      ((fail++))
    else
      info "No PostToolUse hooks configured (OK if knowledge pillar not installed)."
    fi
  fi

  echo ""
  if [[ $fail -eq 0 ]]; then
    ok "All checks passed (${pass}/${pass})."
  else
    warn "${fail} check(s) failed, ${pass} passed. See warnings above."
  fi
}

# ─── Post-Install Summary ───────────────��────────────────────────��─────────
post_install_summary() {
  echo ""
  echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
  echo -e "${GREEN}  ✓  CHEAT ACTIVATED — HESOYAM${NC}"
  echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
  echo ""
  echo -e "  ${RED}❤️  Health:${NC}     Memory loaded     ${GREEN}████████████${NC}"
  echo -e "  ${BLUE}🛡️  Armor:${NC}      Security armed     ${GREEN}████████████${NC}"
  echo -e "  ${GREEN}💲 Cash:${NC}       Productivity max   ${GREEN}\$250,000${NC}"
  echo -e "  ⭐ Wanted:     Level 0            ${CYAN}No cops in sight${NC}"
  echo ""
  echo "Installed locations:"
  echo "  ⚔️  Skills:      ${CLAUDE_DIR}/skills/"
  echo "  💾 Vault:       ${VAULT_PATH}"
  echo "  📡 Vault repo:  github.com/$(gh api user -q '.login' 2>/dev/null || echo 'YOUR_USER')/${REPO_NAME}"
  echo "  🗺️  Bookmarks:   ${CLAUDE_DIR}/ecosystem-bookmarks.md"
  echo "  🛡️  ECC:         ${HOME}/.hesoyam/everything-claude-code/"
  echo ""
  echo "Next steps:"
  echo "  1. Restart Claude Code:  claude"
  echo "  2. Verify skills:        /promote-to-vault, /daily-standup"
  echo "  3. Read the daily guide: guides/daily-usage.md"
  echo "  4. Pick your path:       guides/pick-your-path.md"
  echo ""
  play_cheat_sound
  echo -e "  ${CYAN}\"All you had to do was follow the damn install script, CJ.\"${NC}"
  echo ""

  if $DRY_RUN; then
    echo -e "${CYAN}This was a dry run. No changes were made.${NC}"
    echo -e "${CYAN}Run without --dry-run to apply changes.${NC}"
  fi
}

# ─── Main ───────────────────────────────────────────────────────────────────
main() {
  show_banner

  if $DRY_RUN; then
    warn "DRY RUN MODE — no changes will be made."
    echo ""
  fi

  check_prerequisites

  if [[ -n "$PILLAR" ]]; then
    case "$PILLAR" in
      orchestration) install_orchestration ;;
      config)        install_config ;;
      memory)        install_memory ;;
      knowledge)     install_knowledge ;;
      discovery)     install_discovery ;;
      *)
        err "Unknown pillar: $PILLAR"
        err "Valid pillars: orchestration, config, memory, knowledge, discovery"
        exit 1
        ;;
    esac
  else
    install_orchestration
    install_config
    install_memory
    install_knowledge
    install_discovery
  fi

  if ! $DRY_RUN; then
    verify_installation
  fi

  post_install_summary
}

main "$@"
