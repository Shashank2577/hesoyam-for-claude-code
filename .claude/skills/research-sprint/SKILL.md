---
name: research-sprint
description: Conduct a structured technical research sprint with deliverables
---

**$VAULT_PATH** defaults to `~/Documents/obsidian-vault`. Override by setting `VAULT_PATH` in your environment or passing `--vault-path` during install.

You are conducting a timeboxed research sprint. Follow this process exactly.

**Step 1: Define the question.**
Ask the user:
- What specifically do you need to decide?
- What are the constraints (budget, timeline, team skills, infrastructure)?
- What output format do you need? (ADR, comparison matrix, team briefing, all of the above?)

**Step 2: Research.**
Search across multiple dimensions:
1. Current industry best practices for this problem
2. Top 3 approaches with their tradeoffs
3. How each approach integrates with the user's existing stack
4. Real-world production experience (blog posts, conference talks, post-mortems)
5. Failure modes and risks for each approach

Save findings as structured markdown files in `research/[topic]/` under the current project root:
- `findings.md` — Raw research notes organized by dimension
- `comparison-matrix.md` — Side-by-side comparison table
- `recommendation.md` — Your recommended approach with rationale

**Step 3: Synthesize.**
Create a final deliverable based on the requested output format:

- **ADR:** Use the standard ADR format (Context, Options Considered, Decision, Rationale, Consequences). Save to the vault if Obsidian is configured.
- **Comparison matrix:** Weighted scoring table with clear winner highlighted.
- **Team briefing:** Executive summary (5 bullet points max) + detailed appendix.

**Step 4: Capture.**
- Save the research to Obsidian vault if configured (`$VAULT_PATH/03_Resources/research/[topic]/`)
- Add frontmatter with type: research, topic, date, status, decision
- Create claude-mem observation summarizing the decision (skip if claude-mem is not installed)

**Rules:**
- Cite sources for every claim. "I think" is not a source.
- Present tradeoffs honestly. Every option has downsides — state them clearly.
- Make a clear recommendation. Don't leave the user with "it depends" unless it truly does, and then specify what it depends on.
- Stay within the user's constraints. Don't recommend a $50K/year solution to a solo developer.
