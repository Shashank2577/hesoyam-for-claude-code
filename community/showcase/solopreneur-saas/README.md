# Solopreneur SaaS Setup

**Stack:** Next.js 15 + Supabase + Stripe + Vercel
**Pillars Used:** Orchestration + Config + Memory
**Team Size:** Solo developer

## What I Built

A B2B SaaS invoicing platform — from zero to production in 3 weeks as a solo founder. HESOYAM let me operate at the velocity of a 3-person team.

## Setup

### Pillars in Use

| Pillar | Tool | How I Use It |
|--------|------|-------------|
| Orchestration | oh-my-claudecode | Ralph Mode for daily feature sprints. Deep Interview before starting each major feature. |
| Config | everything-claude-code | Selective install — only `code-reviewer`, `security-reviewer`, and `tdd-guide` agents. Stack config based on `nextjs-fullstack`. |
| Memory | claude-mem | Auto-captures everything. I run `/promote-to-vault` on Fridays to extract architecture decisions. |

### Key CLAUDE.md Sections

```markdown
## Project Rules
- Supabase Edge Functions for all backend logic (no separate API server)
- Row Level Security (RLS) policies on every table — no exceptions
- Stripe webhooks via Supabase Edge Function, idempotency keys required
- All money amounts stored as integers (cents), displayed with Intl.NumberFormat
```

### Daily Workflow

1. **Morning:** Open Claude Code. claude-mem auto-injects yesterday's context. Review what I was working on.
2. **Feature work:** Start with `/deep-interview` to spec the feature, then `/ralph` to execute.
3. **Review:** `code-reviewer` + `security-reviewer` agents run in parallel on every PR.
4. **Evening:** Push to Vercel preview. Quick manual smoke test. Ship to production if green.

## What Worked Best

**Ralph Mode is the killer feature.** As a solo dev, I don't have a tech lead to review my plans. Deep Interview forces me to think through edge cases before writing code. Then Ralph Mode executes the plan relentlessly. I've caught dozens of "oh I didn't think of that" moments during the interview phase.

**claude-mem's session continuity is invisible magic.** I used to spend 15-20 minutes at the start of each session re-explaining my project to Claude. Now it just... knows. The time savings compound dramatically over weeks.

## Lessons Learned

1. **Don't install all ECC agents.** I started with the full install and my context window was crushed. Selective install with just 3 agents freed up ~40K tokens.
2. **Set up stop callbacks early.** I wasted hours watching Claude Code run when I could have been doing customer calls. Telegram notifications changed my life.
3. **Obsidian is overkill for solo.** claude-mem alone handles everything I need. I might add Obsidian when I hire my first dev.

## Stats

- **Features shipped (3 weeks):** 47 PRs merged
- **Average tokens per session:** ~85K (with 3 MCPs + 3 agents)
- **Bugs caught by security-reviewer:** 4 critical (RLS bypass, Stripe webhook replay, XSS in invoice notes, insecure direct object reference)
