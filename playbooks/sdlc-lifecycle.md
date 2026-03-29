# Playbook: The Complete SDLC Lifecycle

> Every phase of software delivery in an IT company — from a client's first ask to production monitoring — mapped to HESOYAM tools.

## When to Use

You're a software engineer at an IT company. Your work doesn't start at `git init` and end at `git push`. It starts at a meeting room (or Zoom call) and flows through requirements, design, sprint planning, development, review, testing, deployment, monitoring, incidents, and retros — then loops back.

This playbook maps **every phase** to the specific HESOYAM tool, skill, template, or playbook that handles it. Follow it linearly for a new project, or jump to the phase you're in right now.

## Prerequisites

- HESOYAM installed (any path from [Pick Your Path](../guides/pick-your-path.md))
- At minimum: oh-my-claudecode + everything-claude-code + claude-mem
- For full lifecycle: add Obsidian vault + NotebookLM

---

## The Lifecycle

```
┌──────────────────────────────────────────────────────────────────────┐
│                                                                      │
│   ┌─────────────┐    ┌─────────────┐    ┌─────────────┐             │
│   │ 1. DISCOVER │───▶│ 2. DEFINE   │───▶│ 3. DESIGN   │             │
│   │  & GATHER   │    │  & SPEC     │    │  & DECIDE   │             │
│   └─────────────┘    └─────────────┘    └──────┬──────┘             │
│                                                 │                    │
│                                                 ▼                    │
│   ┌─────────────┐    ┌─────────────┐    ┌─────────────┐             │
│   │ 6. TEST     │◀───│ 5. REVIEW   │◀───│ 4. BUILD    │             │
│   │  & QA       │    │  & MERGE    │    │  & CODE     │             │
│   └──────┬──────┘    └─────────────┘    └─────────────┘             │
│          │                                                           │
│          ▼                                                           │
│   ┌─────────────┐    ┌─────────────┐    ┌─────────────┐             │
│   │ 7. DEPLOY   │───▶│ 8. MONITOR  │───▶│ 9. RETRO    │────┐       │
│   │  & RELEASE  │    │  & RESPOND  │    │  & CAPTURE  │    │       │
│   └─────────────┘    └─────────────┘    └─────────────┘    │       │
│                                                             │       │
│          ┌──────────────────────────────────────────────────┘       │
│          ▼                                                          │
│   Back to Phase 1 (next sprint / next feature / next quarter)       │
└──────────────────────────────────────────────────────────────────────┘
```

---

## Phase 1: Discover & Gather Requirements

> *"What does the client/PM/stakeholder actually need?"*

**What happens in an IT company:**
- Client meeting or product review
- PM writes a PRD or user stories
- Stakeholders share constraints (budget, timeline, compliance)
- Existing system context needs to be understood

**HESOYAM tools:**

| Activity | Tool | How |
|----------|------|-----|
| Capture meeting context | [Granola](https://granola.so) | Auto-transcribes meetings → structured notes |
| Structure meeting notes | Obsidian vault | Save to `01_Projects/[project]/meetings/` using [meeting-notes template](../knowledge/obsidian-vault-template/06_Templates/meeting-notes.md) |
| Extract requirements from notes | Claude Code | `> Read the meeting notes in ~/vault/01_Projects/[project]/meetings/ and extract user stories in Given/When/Then format` |
| Understand existing codebase | `/research-sprint` skill | Structured investigation of the current system before touching it |
| Check for prior decisions | claude-mem | `> /mind search "auth approach"` — what did we decide before? |

**Key pipeline:**
```
Meeting (Granola) → Structured Notes (Obsidian) → User Stories (Claude Code) → Backlog
```

See: [meeting-to-code-pipeline.md](../knowledge/meeting-to-code-pipeline.md)

**Output:** User stories, acceptance criteria, constraints document — all in the vault.

---

## Phase 2: Define & Spec

> *"Turn vague requirements into something an engineer can build."*

**What happens in an IT company:**
- BA or tech lead writes functional specs
- Edge cases identified
- API contracts defined
- Data models sketched
- Dependencies mapped

**HESOYAM tools:**

| Activity | Tool | How |
|----------|------|-----|
| Deep-dive requirements | oh-my-claudecode **Deep Interview** | `/deep-interview` — Socratic questioning exposes hidden assumptions, edge cases, and missing requirements |
| Research unknowns | `/research-sprint` skill | Structured research with comparison matrix and recommendation |
| Evaluate tech options | [technology-evaluation template](../knowledge/templates/technology-evaluation.md) | Weighted scoring of candidates |
| Document scope | [research-brief template](../knowledge/templates/research-brief.md) | One-pager with in-scope, out-of-scope, constraints |
| Spike on unknowns | [spike-report template](../knowledge/templates/spike-report.md) | Timeboxed investigation with clear go/no-go output |
| Generate API specs | Claude Code | `> Design a REST API for [feature]. Output OpenAPI 3.0 spec.` |

**The Deep Interview is critical here.** Most project failures trace back to Phase 2 — requirements that seemed clear but weren't. Deep Interview forces you to answer questions like:
- "What happens when the user does X and Y at the same time?"
- "Who owns this data after the user deletes their account?"
- "What's the behavior when the third-party API is down?"

**Output:** Functional spec, API contracts, data model, spike results — all saved to vault under `01_Projects/[project]/specs/`.

---

## Phase 3: Design & Decide

> *"Make architectural choices and record why."*

**What happens in an IT company:**
- Architecture review meetings
- Tech lead picks patterns, frameworks, infrastructure
- Trade-off decisions made under uncertainty
- Diagrams drawn (sequence, ER, system context)

**HESOYAM tools:**

| Activity | Tool | How |
|----------|------|-----|
| Record architecture decisions | [ADR template](../knowledge/templates/adr-template.md) | Save to `~/vault/03_Resources/tech-decisions/adr-NNN-[topic].md` |
| Compare approaches | [technology-evaluation template](../knowledge/templates/technology-evaluation.md) | Weighted scoring matrix |
| Research best practices | `/research-sprint` skill | Multi-dimensional research with deliverables |
| Generate diagrams | Claude Code | `> Create a Mermaid sequence diagram for the auth flow` |
| Team briefing on decisions | NotebookLM | Upload ADRs → generate audio briefing or slide deck |
| Review architecture plan | oh-my-claudecode **Deep Interview** | Stress-test the design before writing code |

**Critical rule:** Every non-trivial decision gets an ADR. "We chose PostgreSQL over MongoDB" is an ADR. "We use tabs vs spaces" is not.

**Output:** ADRs in the vault, architecture diagrams, shared team briefing.

---

## Phase 4: Build & Code

> *"Write the code. This is where HESOYAM truly shines."*

**What happens in an IT company:**
- Sprint work: tickets, PRs, standups
- Feature branches, TDD, pair programming
- Integration with existing systems
- Daily standups and progress tracking

**HESOYAM tools:**

| Activity | Tool | How |
|----------|------|-----|
| Sprint execution | [sprint-execution playbook](sprint-execution.md) | Multi-day sprint with daily checkpoints |
| New feature (clear spec) | oh-my-claudecode **Autopilot** | Autonomous execution with architect verification |
| New feature (vague spec) | oh-my-claudecode **Deep Interview → Ralph Mode** | Clarify first, then relentless execution |
| Large feature (many parts) | oh-my-claudecode **Ultrapilot** | Maximum parallelism, 3-5x throughput |
| Cross-cutting refactor | oh-my-claudecode **Team Mode** | Coordinated parallel agents on shared task list |
| Greenfield feature | [greenfield-feature playbook](greenfield-feature.md) | Interview → Plan → Swarm → Review → Capture |
| Legacy migration | [legacy-migration playbook](legacy-migration.md) | Recon → Strangler Fig → Parallel → Validate → Cutover |
| Bug fix | [bug-hunt playbook](bug-hunt.md) | Reproduce → Investigate → Root Cause → TDD Fix → Regression Shield |
| TDD workflow | ECC `tdd-guide` agent | Write test first → implement → refactor |
| Token-conscious work | oh-my-claudecode **Ecomode** | Budget-friendly for long sessions |
| Daily standup | `/daily-standup` skill | Auto-generated from claude-mem + vault |
| Session continuity | claude-mem | Context auto-injected every session. No re-explanation. |

**Stack-specific guidance:** Use the appropriate [stack config](../stacks/) for your project:

| Your Stack | Config |
|-----------|--------|
| Next.js / React | [nextjs-fullstack](../stacks/nextjs-fullstack/) |
| Python / FastAPI | [python-fastapi](../stacks/python-fastapi/) |
| Python / Django | [python-django](../stacks/python-django/) |
| Ruby / Rails | [ruby-rails](../stacks/ruby-rails/) |
| Java / Spring Boot | [java-spring-boot](../stacks/java-spring-boot/) |
| .NET / C# | [dotnet-clean-architecture](../stacks/dotnet-clean-architecture/) |
| Shopify | [shopify-ecommerce](../stacks/shopify-ecommerce/) |
| Kubernetes / Platform | [kubernetes-platform](../stacks/kubernetes-platform/) |

**Security during development:**
- ECC hooks block `--no-verify`, detect secrets in prompts, prevent force-push
- `security-reviewer` agent runs on every PR
- See [security guide](../guides/security.md) for full defense layers

**Output:** Working code on feature branches, passing tests, PRs ready for review.

---

## Phase 5: Review & Merge

> *"Catch bugs before they reach production."*

**What happens in an IT company:**
- Code review (manual + automated)
- CI pipeline runs (lint, test, build)
- Tech lead or peer approves PR
- Merge to main/develop branch

**HESOYAM tools:**

| Activity | Tool | How |
|----------|------|-----|
| Parallel code review | [code-review-pipeline playbook](code-review-pipeline.md) | Multiple ECC agents review simultaneously: code quality, security, architecture |
| Security review | ECC `security-reviewer` agent | OWASP checks, SQL injection, XSS, auth bypass |
| Architecture compliance | ECC `architect` agent | Clean Architecture, layer violations, coupling |
| Code quality | ECC `code-reviewer` agent | Patterns, naming, DRY, complexity |
| PR creation | Claude Code | `> Create a PR for this branch with a summary of changes` |
| Cross-model review | oh-my-claudecode `/ask` | Route review to multiple models for diverse perspectives |

**Review pipeline:**
```
PR Created
  ├── code-reviewer agent (quality)
  ├── security-reviewer agent (OWASP)
  ├── architect agent (structure)
  └── [language]-reviewer agent (idioms)
       │
       ▼
  Synthesize findings → Fix issues → Re-review → Approve → Merge
```

**Output:** Merged PR, review comments addressed, CI green.

---

## Phase 6: Test & QA

> *"Does it actually work? Not just the happy path."*

**What happens in an IT company:**
- QA engineers run test suites
- Edge cases tested manually
- Performance/load testing
- UAT with stakeholders
- Regression testing

**HESOYAM tools:**

| Activity | Tool | How |
|----------|------|-----|
| Unit tests | ECC `tdd-guide` agent | Tests written before or alongside code |
| E2E tests | ECC `e2e-runner` agent | Playwright/Cypress execution |
| Visual regression | oh-my-claudecode **Visual-Verdict** | Screenshot-based QA for frontend |
| Bug found during QA | [bug-hunt playbook](bug-hunt.md) | Five Whys root cause → TDD fix → regression test |
| Document bugs | [debug-journal template](../knowledge/obsidian-vault-template/06_Templates/debug-journal.md) | Structured bug investigation record |
| Performance testing | Stack-specific tooling | Use k6, Artillery, or framework-specific load tools |

**The testing rule:** Every bug fix gets a regression test. No exceptions. The `tdd-guide` agent enforces this.

**Output:** Test reports, bug journals, regression tests, QA sign-off.

---

## Phase 7: Deploy & Release

> *"Get it to production without breaking anything."*

**What happens in an IT company:**
- CI/CD pipeline builds and deploys
- Staging environment validated
- Production deploy (blue-green, canary, rolling)
- Feature flags toggled
- Release notes published

**HESOYAM tools:**

| Activity | Tool | How |
|----------|------|-----|
| Pre-deploy review | [code-review-pipeline playbook](code-review-pipeline.md) | Final review of all changes since last release |
| Deployment safety | ECC hooks | Block destructive commands, verify deploy context |
| Release notes | Claude Code | `> Generate release notes from git log since last tag` |
| Notify team | oh-my-claudecode **Stop Callbacks** | Telegram/Slack/Discord notification when deploy completes |
| Post-deploy smoke test | Claude Code + browser tools | Quick verification of critical paths |

**Deployment checklist:**
```
- [ ] All tests pass on main branch
- [ ] Security reviewer found no critical issues
- [ ] Database migrations tested on staging
- [ ] Feature flags configured
- [ ] Rollback plan documented
- [ ] On-call team notified
- [ ] Monitoring dashboards reviewed
```

**Output:** Production deployment, release notes, stakeholder notification.

---

## Phase 8: Monitor & Respond

> *"Production is where requirements meet reality."*

**What happens in an IT company:**
- Monitoring dashboards (Grafana, Datadog, New Relic)
- Alerting on anomalies
- Incident response when things break
- On-call rotation

**HESOYAM tools:**

| Activity | Tool | How |
|----------|------|-----|
| Incident investigation | [bug-hunt playbook](bug-hunt.md) | Reproduce → Investigate → Root Cause → Fix |
| Access runbooks | Obsidian vault | `02_Areas/` has production runbooks that Claude Code reads |
| Context for on-call | claude-mem | "What changed in the last 24h?" — session history shows exactly what was deployed |
| Record incident | [debug-journal template](../knowledge/obsidian-vault-template/06_Templates/debug-journal.md) | Five Whys + prevention plan |
| Hot-fix workflow | oh-my-claudecode **Autopilot** | Fast, focused fix with TDD regression test |
| Team handoff | claude-mem + Obsidian | Shared memory ensures next on-call has full context |

**The on-call advantage (from the DevOps Duo showcase):**
```
Incident → claude-mem shows recent changes
         → Obsidian vault has the runbook
         → Claude Code reads both and walks through resolution
         → MTTR drops from 45 min → 12 min
```

**Output:** Incident resolved, post-mortem documented, prevention measures in place.

---

## Phase 9: Retrospective & Knowledge Capture

> *"What did we learn? How do we get better?"*

**What happens in an IT company:**
- Sprint retrospective
- Post-mortem for incidents
- Lessons learned documented (or more often, lost)
- Process improvements proposed
- Knowledge transfer to team

**HESOYAM tools:**

| Activity | Tool | How |
|----------|------|-----|
| Auto-generate retro data | `/daily-standup` skill (weekly variant) | Aggregated standup data across the sprint |
| Promote session learnings | `/promote-to-vault` skill | Review 7 days of claude-mem, extract decisions/patterns/debug journals |
| Record decisions | [ADR template](../knowledge/templates/adr-template.md) | Architecture decisions preserved permanently |
| Record debugging patterns | [debug-journal template](../knowledge/obsidian-vault-template/06_Templates/debug-journal.md) | "How we fixed X" — available for next time |
| Share knowledge with team | NotebookLM | Upload retro notes → generate team briefing audio |
| Ecosystem discovery | `/ecosystem-check` skill | Monthly: what new tools could help next sprint? |
| Update project docs | Claude Code | `> Update the README and ARCHITECTURE.md to reflect what we shipped` |

**The knowledge capture pipeline:**
```
Sprint ends
  ├── /promote-to-vault          → High-signal sessions → vault
  ├── ADR for decisions made     → 03_Resources/tech-decisions/
  ├── Debug journals             → 03_Resources/debugging-journal/
  ├── Meeting notes → processed  → 04_Archive/ (old) or 01_Projects/ (ongoing)
  └── NotebookLM briefing        → Team Slack / next sprint planning
```

**Critical anti-pattern:** Don't skip this phase. Without capture, every sprint is an amnesiac starting from zero. With HESOYAM, capture is mostly automated — `/promote-to-vault` does the heavy lifting.

**Output:** Updated vault, lessons learned, process improvements, ready for next cycle.

---

## The Daily Rhythm

Here's how the SDLC maps to a typical engineer's day:

```
Morning:
  ├── Open Claude Code → claude-mem auto-injects yesterday's context
  ├── /daily-standup → auto-generated standup for sync
  └── Pick up sprint ticket → choose playbook (greenfield, bug-hunt, etc.)

Working:
  ├── Deep Interview (if requirement unclear)
  ├── Ralph Mode / Autopilot (if spec is clear)
  ├── ECC agents guard quality in real-time
  └── claude-mem captures everything silently

End of day:
  ├── PR created, reviewed by ECC agents
  ├── Stop callback notifies you when session ends
  └── SessionEnd hook commits vault changes

Friday:
  ├── /promote-to-vault → curate the week's learnings
  ├── /ecosystem-check → scan for new tools (monthly)
  └── Sprint retro → NotebookLM briefing for the team
```

---

## Phase Mapping Cheat Sheet

| SDLC Phase | Primary HESOYAM Tool | Key Template / Playbook |
|-----------|------------------------|------------------------|
| 1. Discover & Gather | Granola + Obsidian | meeting-notes template |
| 2. Define & Spec | Deep Interview + /research-sprint | research-brief, spike-report |
| 3. Design & Decide | ADR template + /research-sprint | adr-template, technology-evaluation |
| 4. Build & Code | Ralph / Autopilot / Team Mode | greenfield, legacy-migration playbooks |
| 5. Review & Merge | ECC agents + code-review pipeline | code-review-pipeline playbook |
| 6. Test & QA | tdd-guide + Visual-Verdict | bug-hunt playbook |
| 7. Deploy & Release | ECC hooks + Stop Callbacks | deployment checklist (above) |
| 8. Monitor & Respond | claude-mem + Obsidian runbooks | bug-hunt playbook, debug-journal |
| 9. Retro & Capture | /promote-to-vault + NotebookLM | ADR, debug-journal templates |

---

## Tips & Gotchas

1. **Don't try to adopt all 9 phases at once.** Start with Phase 4 (Build) — that's where you spend most of your time. Add adjacent phases as you get comfortable.

2. **Phase 2 (Define) is where most projects fail.** Deep Interview is the single highest-ROI tool in HESOYAM. Use it before every feature that touches auth, billing, data models, or external APIs.

3. **Phase 9 (Retro) is where most teams skip.** Set a calendar reminder for `/promote-to-vault` every Friday. 5 minutes of curation saves hours of "how did we do this last time?"

4. **The loop compounds.** Sprint 1 has no memory. Sprint 5 has a vault full of ADRs, debug journals, and patterns. By Sprint 10, Claude Code knows your codebase better than most humans on the team.

5. **Adapt the phases to your company.** Some companies skip formal QA (Phase 6) because developers test their own code. Some don't do retrospectives (Phase 9) — they should, but if they don't, at least run `/promote-to-vault`. Map what you actually do, not what a textbook says.
