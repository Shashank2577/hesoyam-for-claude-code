# ⚡ What People Actually Use Daily

> Every tool here has 30+ features. Most people use 5. Here are the 5 that matter.

## The Honest Truth

oh-my-claudecode has 32 agents, 31 skills, and 5 execution modes. Everything-claude-code has 28 agents, 125 skills, and 60 commands. That's overwhelming. After real-world usage, here's what actually gets used daily vs. what's nice-to-have.

## Daily Drivers: oh-my-claudecode

### 1. Ralph Mode (90% of real usage)

Ralph combines planning + relentless execution. It gathers requirements through interview-style questioning, then works until completion without giving up.

```bash
ralph "build user settings page with form validation"
```

This alone is worth the install. It replaces: Deep Interview + Autopilot in one flow.

### 2. HUD (Usage Monitor)

Shows your token usage and rate limit status in real-time. When you're on a Pro/Max plan with limits, knowing you're at 78% before hitting the wall lets you plan your session.

```bash
/oh-my-claudecode:hud setup
# Then it's always visible in your status line
```

Real user feedback: the HUD percentage closely matches actual limit timing, so you can predict exactly when you'll hit the ceiling.

### 3. `/ask` Multi-Provider

Query different models without leaving Claude Code:

```bash
omc ask codex "identify architecture risks in this PR"
omc ask gemini "suggest UI improvements"
omc ask claude --agent-prompt executor "implement these changes"
```

Each response is saved as a markdown artifact under `.omc/artifacts/ask/`.

### 4. Stop Callbacks (Notifications)

Get notified on Telegram/Discord/Slack when a long-running session finishes or needs input:

```bash
omc config-stop-callback telegram --enable --token <bot_token> --chat <chat_id>
omc config-stop-callback discord --enable --webhook <url>
omc config-stop-callback slack --enable --webhook <url>
```

Walk away from your computer. Get a ping when it's done.

### 5. Team Mode (Replaced Swarm)

When you need parallel agents on a shared task list:

```bash
/team "refactor the payment module: 
  Agent 1: extract interfaces, 
  Agent 2: write tests,
  Agent 3: update documentation"
```

Note: The legacy `swarm` keyword was removed in v4.1.7. Use `team` directly.

### Features Most People Don't Use (Yet)

- **Ultrapilot** — Too aggressive for most workflows. Try it for large, well-specced features.
- **Pipeline** — Sequential chains. Useful but ralph covers most sequential needs.
- **Ecomode** — Budget-conscious mode. Great if you're paying per-token.
- **Visual-Verdict** — Screenshot-based QA. Niche but powerful for frontend work.
- **Mission Board** — Multi-agent progress tracking dashboard. Useful for swarm/team sessions.
- **Anti-Slop Workflow** — Prevents AI-generated filler in code comments.

### OMC Gotcha: Package Naming

The repo, plugin, and commands are branded `oh-my-claudecode`, but the npm package is published as `oh-my-claude-sisyphus`. If upgrading via npm:

```bash
npm i -g oh-my-claude-sisyphus@latest
```

---

## Daily Drivers: everything-claude-code

### 1. `/plan` + `/code-review`

The planning agent and code review agent are the workhorses:

```bash
/plan "add OAuth2 login flow"
# ... work happens ...
/code-review
```

### 2. Security Hooks (Set and Forget)

Once installed, these run silently in the background:
- Block `--no-verify` flags
- Detect secrets in prompts
- Prevent linter config modifications

You don't "use" them daily — they protect you daily.

### 3. `/security-scan`

Run before any PR. Non-negotiable for production code:

```bash
/security-scan
```

### 4. `/tdd`

Test-driven development workflow. Write failing test → implement → verify:

```bash
/tdd "fix the payment timeout bug"
```

### 5. Selective Install (New in v1.9.0)

You don't need all 125 skills. Install only what you need:

```bash
# The installer shows what's available and lets you pick
node scripts/install-plan.js    # Preview what would be installed
node scripts/install-apply.js   # Apply the installation
```

State store tracks what's installed. Incremental updates work.

### ECC Features Most People Don't Use (Yet)

- **Instinct system** — Auto-extracted patterns from sessions into reusable behavioral rules
- **Continuous learning hooks** — Hooks that detect patterns and suggest new skills
- **ccg-workflow runtime** — Required for `/multi-plan`, `/multi-execute`, etc. Install with `npx ccg-workflow`
- **AgentShield --opus mode** — Three-agent red team/blue team. Powerful but token-heavy

### ECC Gotcha: Hooks Duplication

The #1 support issue. Do NOT add `"hooks"` to `.claude-plugin/plugin.json`. Claude Code v2.1+ auto-loads hooks from plugins. Declaring them explicitly causes "Duplicate hooks file" errors.

---

## Daily Drivers: claude-mem

### 1. Automatic Context Injection

You don't "use" this — it happens automatically. When you start a session, claude-mem injects relevant context from past sessions. Your Claude Code "remembers" what you were working on.

### 2. `/mind search`

When you need to recall something specific:

```bash
/mind search "that JWT refresh token bug"
/mind ask "what was the solution for the rate limiting issue?"
/mind recent   # what happened in the last few sessions
```

### 3. Timeline Reports

Generate a narrative summary of your development history:

```bash
/timeline-report
```

Great for retrospectives, project handoffs, and sprint reviews.

### 4. Web Viewer

Browse all your memories visually at `http://localhost:37777`. Useful for auditing what claude-mem captured and deleting sensitive observations.

---

## The 80/20 Rule

If you only do these things, you'll get 80% of HESOYAM's value:

1. **Install ECC** → security hooks auto-protect you
2. **Install claude-mem** → sessions auto-persist
3. **Use `/plan` → ralph → `/code-review`** → the core workflow
4. **Use HUD** → never hit rate limits by surprise
5. **Run `/security-scan` before PRs** → catch vulnerabilities

Everything else is power-user territory. Adopt it when you feel the need, not before.
