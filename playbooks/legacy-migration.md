# Playbook: Legacy Migration

> Systematically migrate a legacy codebase using reconnaissance, parallel execution, and continuous validation.

## When to Use

You're modernizing an existing codebase — rewriting modules, upgrading frameworks, migrating databases, or moving from monolith to microservices. The existing system must keep running while you replace it piece by piece.

## Prerequisites

- oh-my-claudecode installed (for parallel agent execution)
- everything-claude-code installed (for code reviewers + security scanning)
- claude-mem running (critical — migration context spans many sessions)
- Git worktrees configured (parallel branches without conflicts)

## Phase 1: Reconnaissance (Ecomode)

Use the cheapest execution mode to map the existing system without burning tokens.

```bash
# Let Claude explore the codebase with a librarian agent
/ecomode

> Analyze the existing codebase:
> 1. Map all modules and their dependencies
> 2. Identify the dependency graph (what depends on what)
> 3. Flag the most tightly coupled components
> 4. List all external integrations (APIs, databases, message queues)
> 5. Find test coverage gaps
```

**Output:** A dependency map and migration risk assessment stored in memory.

## Phase 2: Strangler Fig Plan

Based on the recon, identify which components can be migrated independently.

```bash
/plan "Migrate [system] using strangler fig pattern. 
Start with the lowest-risk, least-coupled modules first.
Each module must have: new implementation, adapter layer, feature flag, rollback plan."
```

**Key principle:** Never migrate two tightly-coupled modules simultaneously. One at a time. Validate. Move on.

## Phase 3: Parallel Migration (Swarm Mode)

Set up Git worktrees for parallel work:

```bash
# Create isolated worktrees for each migration target
git worktree add ../migration-auth feature/migrate-auth
git worktree add ../migration-billing feature/migrate-billing
git worktree add ../migration-notifications feature/migrate-notifications
```

```bash
/swarm

> Assign agents to parallel migration tracks:
> - Agent 1: Migrate auth module in worktree migration-auth
> - Agent 2: Migrate billing module in worktree migration-billing  
> - Agent 3: Write integration tests for the adapter layer
> - Agent 4: Update documentation for migrated components
```

## Phase 4: Continuous Validation

After each module migration:

```bash
/code-review          # Architecture compliance check
/security-scan        # No new vulnerabilities introduced
/e2e                  # End-to-end flows still work through adapter

# Critical: Test the rollback
> Simulate rolling back the auth migration. 
> Verify the feature flag correctly routes to the old implementation.
```

## Phase 5: Cutover

Once all modules pass validation:

1. Enable feature flags for new implementations in staging
2. Run full regression suite
3. Monitor for 24-48 hours
4. Gradually enable in production (canary → 10% → 50% → 100%)
5. Remove adapter layer and feature flags
6. Archive legacy code

## Memory is Critical Here

Migration spans weeks or months. Without claude-mem, every session starts from zero.

```bash
# At any point, query your migration history:
> What decisions did we make about the auth migration?
> What gotchas did we hit during billing migration?
> What's the current migration status across all modules?
```

## Tips & Gotchas

1. **Never migrate and refactor simultaneously.** First make it work in the new pattern, then make it clean.
2. **Keep the adapter layer thin.** It's temporary scaffolding, not architecture.
3. **Test rollback before you need it.** Not after.
4. **Use Ecomode for recon, Swarm for execution.** Don't burn Opus tokens on file exploration.
5. **Document every decision in Obsidian.** Future you will thank present you.
