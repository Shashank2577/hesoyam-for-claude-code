# Research Workflow: Claude Code + NotebookLM Loop

> A structured approach to technical research that produces actionable artifacts.

## The Loop

```
Question → Claude Code (search + analyze) → Obsidian (capture) → NotebookLM (synthesize) → Decision
```

## Step 1: Define the Research Question

Before researching, define:
- **Question:** What specifically do you need to decide?
- **Constraints:** Budget, timeline, team skills, existing infrastructure
- **Output format:** ADR? Slide deck? Podcast for team? Comparison matrix?

## Step 2: Claude Code Research Sprint

```bash
claude

> Research [topic] across these dimensions:
> 1. Current industry best practices
> 2. Tradeoffs between top 3 approaches
> 3. How it integrates with our existing stack: [describe stack]
> 4. Real-world case studies or production experience reports
> 5. Risks and failure modes
>
> Save findings as structured markdown files in ./research/[topic]/
```

Let Claude search, read documentation, and produce structured files.

## Step 3: Obsidian Capture

Move research outputs into your vault:

```bash
cp -r ./research/[topic]/ ~/vault/03_Resources/research/[topic]/
```

Add metadata to each file:
```markdown
---
type: research
topic: [topic]
date: [date]
status: in-progress
decision: pending
---
```

## Step 4: NotebookLM Synthesis

```bash
notebooklm create "Research: [Topic]"
notebooklm source add "./research/[topic]/"

# Generate synthesis artifacts
notebooklm ask "Summarize the key tradeoffs"
notebooklm ask "What would you recommend for a team of [N] with [constraints]?"
notebooklm generate mind-map
notebooklm generate data-table "comparison matrix"
notebooklm generate audio "briefing for the team" --wait
```

## Step 5: Decision

Write an Architecture Decision Record (ADR) in Obsidian:

```bash
claude

> Based on the research in ./research/[topic]/, 
> write an ADR using our template.
> Save to ~/vault/03_Resources/tech-decisions/adr-NNN-[topic].md
```

## Step 6: Share

- Podcast → Team Slack channel
- Slide deck → Sprint review
- Comparison matrix → Decision stakeholders
- ADR → Git repo for permanent record

## Research Templates

Available in `knowledge/templates/`:
- `research-brief.md` — Quick 1-pager
- `technology-evaluation.md` — Structured comparison
- `adr-template.md` — Architecture Decision Record
- `spike-report.md` — Timeboxed investigation results
