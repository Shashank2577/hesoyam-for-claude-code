# Playbook: Greenfield Feature Build

> From vague idea to shipped, tested code — using all five HESOYAM pillars.

## When to Use

You're starting a new feature from scratch. Requirements are partially clear. You want Claude Code to handle execution while you focus on direction.

## Prerequisites

- oh-my-claudecode installed (Orchestration)
- everything-claude-code installed (Config & Security)
- claude-mem running (Memory)
- Obsidian vault connected (Knowledge) — optional but recommended

## Phase 1: Clarify (Deep Interview Mode)

Before writing a single line of code, clarify what you're building.

```bash
/deep-interview "I want to build [your feature description]"
```

The Deep Interview uses Socratic questioning to:
- Expose hidden assumptions about scope, edge cases, and dependencies
- Measure clarity across weighted dimensions
- Generate a structured specification

**Duration:** 5-15 minutes of back-and-forth.

**Output:** A clear spec that both you and Claude agree on.

## Phase 2: Plan (ECC Planner Agent)

```bash
/plan "Implement [feature] per the spec above"
```

The planner agent will:
1. Analyze the codebase for relevant patterns
2. Identify files that need creation or modification
3. Break work into atomic, testable tasks
4. Estimate complexity and suggest parallel vs. sequential execution

**Review the plan in Plan Mode.** Approve, modify, or reject before proceeding.

## Phase 3: Execute (Swarm or Ultrapilot)

For **independent subtasks** (UI + API + DB migrations):

```bash
# Ultrapilot: Maximum parallelism
/ultrapilot
```

For **interdependent subtasks** (each builds on the previous):

```bash
# Autopilot: Sequential with architect verification
/autopilot
```

For **mixed workloads** (some parallel, some sequential):

```bash
# Swarm: Coordinated agents with shared task list
/team
```

## Phase 4: Validate (ECC Quality Gates)

```bash
/code-review          # Catch regressions, style issues
/security-scan        # OWASP Top 10 audit
/e2e                  # Critical user flow tests
/test-coverage        # Verify 80%+ coverage
```

## Phase 5: Capture (Memory + Knowledge)

claude-mem automatically captures the session. For additional persistence:

```bash
# If using Obsidian
# Claude Code will update your vault with:
# - Architecture decisions made
# - Patterns discovered
# - Gotchas encountered
```

If using NotebookLM for team communication:

```bash
notebooklm source add "./feature-spec.md"
notebooklm generate slide-deck    # For sprint review
notebooklm generate audio          # For async team updates
```

## Expected Outcome

- Feature built, tested, and reviewed
- Architecture decisions captured in memory
- Knowledge base updated
- Team artifacts (slides, audio) generated

## Tips & Gotchas

1. **Don't skip the interview.** It saves more time than it costs. Every time.
2. **Watch your context window.** If using Swarm with many agents, disable MCPs you don't need for this feature.
3. **Compact manually** between Phase 3 and Phase 4. The execution phase generates a lot of context that isn't needed for review.
4. **Save the plan.** Even if you modify it during execution, the original plan is valuable context for future similar features.
