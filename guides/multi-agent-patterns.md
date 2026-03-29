# Multi-Agent Patterns: When and How to Parallelize

> Not everything should be parallelized. Here's when each pattern wins.

## Pattern 1: Single Agent (Default)

```
You → Claude Code → Output
```

**When:** Simple tasks, quick questions, small edits, debugging with clear symptoms.

**Why not more agents?** Agent coordination has overhead. For tasks under 10 minutes, a single focused agent beats a swarm every time.

## Pattern 2: Subagent Delegation

```
You → Claude Code (main) → Subagent (specialist) → Result back to main
```

**When:** You need specialist knowledge (security review, specific language expertise) or you want to read large files without consuming main context.

**Key insight:** Subagent context is isolated from your main session. When a librarian reads a 2,000-line file, those lines don't consume your context window.

```bash
# ECC agents
Task(subagent_type="code-reviewer", prompt="Review src/auth/")
Task(subagent_type="security-reviewer", prompt="Audit this migration")
Task(subagent_type="librarian", prompt="Summarize the payment module")
```

## Pattern 3: Parallel Swarm

```
You → oh-my-claudecode → Agent 1 (task A)
                        → Agent 2 (task B)  
                        → Agent 3 (task C)
                        → Synthesis
```

**When:** Multiple independent tasks that don't share state. UI changes + API changes + database migrations happening simultaneously.

```bash
/swarm

> Tasks (all independent):
> - Build the user settings UI component
> - Add the /api/settings endpoint
> - Write the database migration for user preferences
> - Update API documentation
```

**Critical rule:** Tasks must be independent. If Agent 2 needs Agent 1's output, use Pipeline instead.

## Pattern 4: Pipeline (Sequential Chain)

```
Agent 1 (research) → Agent 2 (plan) → Agent 3 (implement) → Agent 4 (review)
```

**When:** Each step depends on the previous step's output. Research before planning. Plan before coding. Code before reviewing.

This is essentially the Greenfield Feature playbook executed as a chain.

## Pattern 5: Multi-Model Orchestration

```
Claude (orchestrator) → Codex (task A)
                      → Gemini (task B)
                      → Claude synthesizes
```

**When:** Different models have different strengths. Codex for deep reasoning about architecture. Gemini for creative UI suggestions. Claude for synthesis and final implementation.

```bash
# oh-my-claudecode CCG skill
/ccg Review this PR — architecture (Codex) and UI components (Gemini)
```

**Requirements:** Codex and Gemini CLIs installed. Active tmux session.

## Pattern 6: Autopilot Loop

```
Claude → Plan → Execute → Verify → Fix → Verify → ... → Done
```

**When:** You trust the spec and want to walk away. Claude loops autonomously until all acceptance criteria pass.

```bash
/autopilot

> Build [feature] per this spec: [paste spec]
> Acceptance criteria:
> 1. All tests pass
> 2. No security warnings from AgentShield
> 3. Test coverage above 80%
> 4. Documentation updated
```

**Risk:** Can burn tokens if the task is poorly defined. Always use Deep Interview first for ambiguous requirements.

## Decision Framework

```
Is the task simple? (<10 min)
  → Single Agent

Does it need specialist knowledge?
  → Subagent Delegation

Are there multiple independent subtasks?
  → Parallel Swarm

Do steps depend on each other?
  → Pipeline

Do different models excel at different parts?
  → Multi-Model Orchestration

Is the spec clear and I want to walk away?
  → Autopilot Loop
```

## Cost Implications

| Pattern | Token Usage | Clock Time |
|---------|------------|------------|
| Single Agent | Baseline | Baseline |
| Subagent | +20-30% | ~Same |
| Parallel Swarm | 3-5x | 0.3-0.5x |
| Pipeline | 2-4x | 1.5-2x |
| Multi-Model | Varies | 0.5-1x |
| Autopilot | Unpredictable | Unpredictable |

Swarm is the most expensive but fastest. Single agent is cheapest but slowest. Choose based on whether you're optimizing for **your time** or **token cost**.

## Sources

- [oh-my-claudecode execution modes](https://github.com/Yeachan-Heo/oh-my-claudecode)
- [ECC agent delegation patterns](https://github.com/affaan-m/everything-claude-code)
- [Claude Code native Agent Teams](https://docs.claude.com)
