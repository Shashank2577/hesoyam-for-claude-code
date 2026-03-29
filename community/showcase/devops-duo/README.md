# DevOps Duo Setup

**Stack:** Go microservices + Kubernetes + ArgoCD + Terraform
**Pillars Used:** All Five Pillars
**Team Size:** 2 platform engineers

## What We Built

Platform engineering team managing 14 Go microservices across 3 Kubernetes clusters (staging, production-us, production-eu). HESOYAM unified our workflows after months of each engineer having a different Claude Code setup.

## Setup

### Pillars in Use

| Pillar | Tool | How We Use It |
|--------|------|-------------|
| Orchestration | oh-my-claudecode | Team Mode for parallel infrastructure changes. Ultrapilot for Terraform refactoring. |
| Config | everything-claude-code | Full install with custom hooks for Kubernetes safety (block `kubectl delete` in prod context) |
| Memory | claude-mem | Shared memory across both engineers via Git-backed sync. Critical for on-call context handoff. |
| Knowledge | Obsidian + Git | Shared vault with runbooks, ADRs, post-mortems. Claude Code reads it via Obsidian Skills. |
| Discovery | awesome-claude-code | Monthly "tool scout" — one of us spends 30 min reviewing new ecosystem additions. |

### Key CLAUDE.md Sections

```markdown
## Infrastructure Rules
- NEVER apply Terraform changes without `terraform plan` output reviewed
- All Kubernetes manifests validated with `kubeconform` before apply
- Helm values files are source of truth — no kubectl edit in production
- ArgoCD sync must be manual for production namespace changes
- All secrets via External Secrets Operator — no base64 in manifests

## Safety Hooks
- Block kubectl commands targeting production context without confirmation
- Block terraform destroy without explicit --allow-destroy flag
- Warn on any Helm values change affecting resource limits
```

### Team Workflow

```
Engineer A (US hours):
  Morning  → claude-mem loads previous session + Obsidian vault context
  Work     → Team Mode with Engineer B for cross-cutting changes
  EOD      → SessionEnd hook commits vault changes + pushes to Git

Engineer B (EU hours):
  Morning  → Pulls vault from Git. claude-mem shows what A did overnight.
  Work     → Continues from A's context. No re-explanation needed.
  EOD      → Same commit/push cycle
```

### On-Call Context Handoff

This is where the full stack pays off. When an incident happens:

1. **claude-mem** has the recent session history — what was changed, what was deployed
2. **Obsidian vault** has the runbooks — how to diagnose and fix known issues
3. **Claude Code** can read both simultaneously — "What changed in the last 24h that might explain this 5xx spike?"

Before HESOYAM, our on-call handoff was a Slack message. Now it's an AI-powered knowledge system that actually answers questions.

## What Worked Best

**Shared Obsidian vault with runbooks is transformative.** We write a runbook once after an incident. Next time it happens, Claude Code reads the runbook and walks us (or the on-call) through the resolution. Our MTTR dropped from ~45 minutes to ~12 minutes.

**Team Mode for Terraform refactoring.** We had 14 microservices with copy-pasted Terraform modules that had diverged over time. Team Mode let us assign one agent per service to standardize them in parallel. What would have been a 2-week project took 3 days.

## Lessons Learned

1. **Invest in safety hooks before anything else.** We almost ran `terraform destroy` on a production module in week 1. The safety hooks saved us. Now they're non-negotiable.
2. **Vault structure matters.** We started with a flat folder of runbooks. Switching to PARA (Projects/Areas/Resources/Archive) made everything findable.
3. **Discovery pillar is underrated.** We found `awesome-claude-code-subagents` through the ecosystem catalog and discovered a Kubernetes-specific subagent that handles CRD generation better than our custom setup.

## Stats

- **Incident MTTR improvement:** 45 min → 12 min (73% reduction)
- **Terraform standardization:** 14 services, 3 days (estimated 2 weeks manually)
- **Runbooks in vault:** 23 production runbooks, 8 debug journals
- **Dangerous command blocks (by hooks):** 11 in first month
