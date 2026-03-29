# Playbook: Bug Hunt

> Systematic debugging with multi-agent investigation, root cause analysis, and regression-proof fixes.

## When to Use

You have a bug that isn't obvious. Reproduction is tricky, the root cause is unclear, or the fix has cascading implications across the codebase.

## Prerequisites

- everything-claude-code installed (code reviewer + build resolver agents)
- claude-mem running (the bug's history might span multiple sessions)
- oh-my-claudecode optional (for parallel investigation tracks)

## Phase 1: Reproduce (Deep Interview)

Never jump to fixing. First, prove you can reproduce the bug reliably.

```bash
/deep-interview "We have a bug: [describe symptoms]. 
Help me build a reliable reproduction case before we investigate."
```

Claude will ask:
- When does it happen? (Always? Sometimes? Only in production?)
- What changed recently? (Deploys, config changes, data changes?)
- What's the expected vs. actual behavior?
- Can we reproduce it with a test?

**Output:** A failing test or reproduction script. If you can't reproduce it, you can't fix it.

## Phase 2: Investigate (Parallel Tracks)

If the root cause isn't obvious, run parallel investigations:

```bash
# Option A: Using ECC agents
/code-review   # Maybe the reviewer spots it in the diff
/security-scan # Maybe it's a security-related edge case

# Option B: Using oh-my-claudecode Swarm
/swarm

> Investigation tracks:
> - Agent 1: Read git log for recent changes to affected files
> - Agent 2: Search codebase for similar patterns that might have the same bug
> - Agent 3: Analyze error logs and stack traces
> - Agent 4: Check test coverage for the affected code path
```

## Phase 3: Root Cause Analysis

Once you have a hypothesis:

```bash
> Perform Five Whys analysis on this bug:
> Symptom: [what's happening]
> Hypothesis: [your theory]
> 
> Why 1: Why does [symptom] happen?
> Why 2: Why does [cause 1] happen?
> ... continue until you hit the true root cause
```

## Phase 4: Fix with TDD

```bash
/tdd

> The root cause is [X].
> Write a failing test that captures this exact bug.
> Then implement the minimal fix that makes it pass.
> Then verify no existing tests break.
```

**Critical:** The fix should be minimal. Don't refactor while bug-fixing. That's a separate task.

## Phase 5: Regression Shield

```bash
/e2e           # Full end-to-end test suite
/test-coverage # Ensure the fixed path is now covered

# Add the bug to your team's knowledge base
> Document this bug in Obsidian:
> - Symptoms
> - Root cause
> - Fix applied
> - How to prevent similar bugs
```

## Tips & Gotchas

1. **Reproduce first. Always.** If you can't reproduce it, you're guessing.
2. **Check git blame.** The bug was introduced by a specific change. Find it.
3. **Don't fix multiple bugs at once.** One fix per PR. Clean git history.
4. **Search for siblings.** If the bug exists in one place, the same pattern might exist elsewhere. Use Agent 2 from Phase 2 for this.
5. **Memory pays dividends.** claude-mem captures debugging patterns. Next time you hit a similar bug, the context is already there.
