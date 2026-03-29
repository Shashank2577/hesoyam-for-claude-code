# NotebookLM Workflows: Research → Content Pipeline

> Turn Claude Code sessions and research into podcasts, slides, mind maps, and more.

## Setup

```bash
# Install the Python API
pip install "notebooklm-py[browser]"
playwright install chromium

# Authenticate (opens browser)
notebooklm login
```

## Workflow 1: Sprint Review Autopilot

Turn a sprint's worth of work into a presentation and podcast for stakeholders.

```bash
# 1. Export sprint notes from Obsidian
cp 01_Projects/sprint-47/*.md ./sprint-review-sources/

# 2. Create a NotebookLM notebook
notebooklm create "Sprint 47 Review"

# 3. Add all sprint documentation as sources
notebooklm source add "./sprint-review-sources/plan.md"
notebooklm source add "./sprint-review-sources/daily-notes/"
notebooklm source add "./sprint-review-sources/architecture-decisions.md"

# 4. Generate deliverables
notebooklm generate slide-deck
notebooklm generate audio "engaging summary for stakeholders" --wait

# 5. Download
notebooklm download slide-deck ./sprint-47-review.pdf
notebooklm download audio ./sprint-47-podcast.mp3
```

**Result:** A slide deck and podcast episode ready for sprint review — generated from your actual work, not a manual summary.

## Workflow 2: Research Deep Dive

Exploring a new technology or architecture pattern for the team.

```bash
# 1. Gather sources in Claude Code
> Research the latest approaches to [topic].
> Save findings as markdown files in ./research/

# 2. Add to NotebookLM
notebooklm create "Research: [Topic]"
notebooklm source add "./research/"
notebooklm source add "https://relevant-paper.com"
notebooklm source add "./related-docs/existing-architecture.md"

# 3. Interactive Q&A
notebooklm ask "What are the key tradeoffs between approach A and B?"
notebooklm ask "How does this compare to our current architecture?"

# 4. Generate artifacts
notebooklm generate mind-map
notebooklm generate data-table "compare all approaches"
notebooklm generate quiz --difficulty hard  # Test your own understanding

# 5. Share with team
notebooklm download mind-map ./research-mindmap.json
notebooklm download data-table ./approach-comparison.csv
```

## Workflow 3: Client Onboarding Knowledge Base

Create a searchable, multi-format knowledge base for a new client project.

```bash
# 1. Gather all client materials
notebooklm create "Client: [Name] Knowledge Base"
notebooklm source add "./contracts/sow.pdf"
notebooklm source add "./meetings/kickoff-transcript.md"
notebooklm source add "./requirements/initial-spec.md"
notebooklm source add "https://client-website.com"

# 2. Generate onboarding artifacts
notebooklm generate audio "onboarding overview for new team members" --wait
notebooklm generate flashcards --quantity more
notebooklm generate infographic --orientation landscape

# 3. Create Q&A interface
notebooklm ask "What are the client's top priorities?"
notebooklm ask "What technical constraints did they mention?"
notebooklm ask "What's the timeline and key milestones?"
```

## Workflow 4: Architecture Decision Records → Podcast

Convert dry ADRs into engaging audio your team will actually consume.

```bash
notebooklm create "Architecture Decisions Q1 2026"
notebooklm source add "./03_Resources/tech-decisions/adr-*.md"
notebooklm generate audio "conversational discussion of key decisions" --wait
notebooklm download audio ./architecture-podcast-q1.mp3
```

Share in Slack. People listen to podcasts. People don't read ADRs.

## Combining with Claude Code

The real power is the loop:

```
Claude Code (builds) → Obsidian (captures) → NotebookLM (transforms) → Team (consumes)
```

```bash
# Inside Claude Code
> Generate a comprehensive technical summary of the work done this sprint.
> Format it as a markdown document suitable for NotebookLM ingestion.
> Include: what was built, why, key decisions, and known issues.
> Save to ./sprint-summary.md

# Then
notebooklm source add "./sprint-summary.md"
notebooklm generate audio "team update podcast" --wait
```

## Resources

- [notebooklm-py](https://github.com/teng-lin/notebooklm-py) — The Python API
- [awesome-notebookLM-prompts](https://github.com/serenakeyitan/awesome-notebookLM-prompts) — Slide prompt templates
- [awesome-notebooklm](https://github.com/etewiah/awesome-notebooklm) — Ecosystem catalog
- [open-notebook](https://github.com/lfnovo/open-notebook) — Self-hosted alternative
