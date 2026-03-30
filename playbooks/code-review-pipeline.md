# Playbook: Code Review Pipeline

> Multi-agent parallel code review that catches what humans miss.

## When to Use

You have a PR that needs thorough review before merge — architecture compliance, security, performance, test quality, and documentation.

## Steps

### 1. Parallel Review Agents

```bash
/team

> Review PR #[number] with parallel agents:
> - code-reviewer: Logic errors, edge cases, regression risks
> - security-reviewer: OWASP Top 10, secret exposure, injection vectors
> - architect: Does this align with our patterns? Any drift?
> - tdd-guide: Are the tests sufficient? Missing edge cases?
> - doc-updater: Does documentation need updating?
```

### 2. Synthesize Findings

Each agent produces findings independently. Claude synthesizes into a unified review:

```bash
> Combine all review findings into a single PR comment.
> Group by severity: Blockers → Warnings → Suggestions → Praise.
> Include specific file:line references.
```

### 3. Apply Fixes

```bash
/autopilot

> Address all blocker-level findings from the review.
> Create a follow-up issue for each warning-level finding that isn't fixed now.
```

## Tips

- Run this on your own PRs before requesting human review. Catch the easy stuff early.
- Use ECC's config protection hooks to prevent the reviewer from modifying linter configs instead of flagging code issues.
- Keep review context out of your main session — delegate to subagents.
