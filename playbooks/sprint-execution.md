# Playbook: Sprint Execution

> Run an entire sprint's worth of tickets through Claude Code with daily checkpoints.

## When to Use

You have a set of well-defined tickets for a sprint and want to maximize throughput using multi-agent execution with human oversight at daily checkpoints.

## Prerequisites

All five HESOYAM pillars installed. Tickets written with clear acceptance criteria.

## Day 1: Sprint Planning

```bash
/deep-interview "We have [N] tickets for this sprint. Let me describe them."

# After discussion:
/plan "Create a sprint execution plan. 
Group tickets by:
1. Independent (can run in parallel)  
2. Sequential (has dependencies)
3. Risky (needs careful review)
Assign estimated complexity to each."
```

Save the plan to Obsidian: `01_Projects/sprint-XX/plan.md`

## Days 2-N: Execution Loops

### Morning: Review & Assign

```bash
# Check what memory has from yesterday
> What did we accomplish yesterday? What's still pending?

# Assign today's work
/swarm

> Today's tickets: [list independent tickets]
> Agent 1: [Ticket A]
> Agent 2: [Ticket B]  
> Agent 3: [Ticket C]
```

### Afternoon: Review & Validate

```bash
/code-review    # Review morning's output
/e2e            # Run integration tests

> Update the sprint tracker:
> - Completed: [list]
> - In progress: [list]
> - Blocked: [list with reasons]
```

### End of Day: Memory Checkpoint

```bash
> Summarize today's sprint progress.
> Capture decisions, patterns discovered, and blockers in Obsidian.
```

claude-mem auto-captures, but explicit Obsidian notes help with team visibility.

## Final Day: Sprint Review Prep

```bash
# Generate sprint review artifacts
notebooklm create "Sprint XX Review"
notebooklm source add "./01_Projects/sprint-XX/"
notebooklm generate slide-deck
notebooklm generate audio "summarize sprint achievements"
```

## Tips

1. **Don't Ultrapilot the entire sprint.** Use Swarm for parallel independent tickets. Use Autopilot for sequential work.
2. **Compact between tickets.** Each ticket is a fresh context. Don't let one ticket's context pollute the next.
3. **Track velocity.** After a few sprints with HESOYAM, you'll have data on how many story points Claude Code can handle vs. where human intervention is still needed.
