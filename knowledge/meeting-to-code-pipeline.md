# Meeting → Code Pipeline

> From client conversation to deployed feature with minimal human context-switching.

## The Flow

```
Meeting (Granola/Zoom) → Transcript → Structured Notes (Obsidian) → 
Spec (Claude Code) → Implementation (Claude Code) → Review → Deploy
```

## Phase 1: Capture (During Meeting)

[Granola](https://www.granola.so/) runs in the background, capturing the conversation with context-aware transcription. No manual note-taking needed.

**Alternatives:** Otter.ai, Fireflies.ai, Zoom AI Companion, or manual notes.

## Phase 2: Structure (Post-Meeting, 5 min)

Export Granola output to Obsidian:

```
vault/01_Projects/[project]/meetings/[date]-[topic].md
```

Then in Claude Code:

```bash
claude

> Read the meeting notes at vault/01_Projects/[project]/meetings/[date]-[topic].md
> Extract:
> 1. Action items with owners and deadlines
> 2. Technical requirements discussed
> 3. Open questions that need follow-up
> 4. Decisions made (with rationale)
> 
> Save structured output alongside the raw notes.
```

## Phase 3: Spec (15 min)

```bash
/deep-interview "Based on the meeting notes, spec out the feature we discussed."
```

Claude will:
- Reference the structured meeting notes
- Ask clarifying questions where the meeting was ambiguous
- Produce a clear spec with acceptance criteria
- Identify risks and unknowns

## Phase 4: Build (Autopilot)

```bash
/autopilot

> Implement the feature per the spec above.
> Run TDD — write tests first, then implementation.
> Update documentation.
```

## Phase 5: Review & Deploy

```bash
/code-review
/security-scan
/e2e

# If all pass:
# Create PR, request human review, merge, deploy
```

## Why This Works

Traditional flow:
```
Meeting → [manual notes] → [remember later] → [write spec from memory] → 
[lose context] → [ask "what did we discuss?"] → [finally code] → [miss requirements]
```

HESOYAM flow:
```
Meeting → [auto-capture] → [AI-structured] → [AI-specced] → [AI-built] → [AI-reviewed]
```

Human involvement: Attend the meeting. Answer Deep Interview questions. Review the PR. That's it.

## Integration Tips

- **Set up Granola → Obsidian sync** via file export or API
- **Create a meeting template** in Obsidian that Claude Code recognizes
- **Tag meetings by project** so Claude Code can find relevant context later
- **claude-mem auto-captures** the implementation session, creating a bridge between the meeting and the code
