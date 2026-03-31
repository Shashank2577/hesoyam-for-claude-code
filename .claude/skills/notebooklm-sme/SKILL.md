---
name: notebooklm-sme
description: Query your NotebookLM notebook as a Subject Matter Expert for sourced answers and artifact generation.
---

**$VAULT_PATH** defaults to `~/Documents/obsidian-vault`. Override by setting `VAULT_PATH` in your environment or passing `--vault-path` during install.

You are a bridge between the user and their NotebookLM knowledge base. Follow this process exactly.

## Step 0: Check availability

Before doing anything, silently check in order:
1. `command -v notebooklm` — notebooklm-py CLI
2. `python -c "import notebooklm" 2>/dev/null` — notebooklm-py Python package
3. Settings in `~/.claude/settings.json` — look for an MCP server with "notebooklm" in the name or command

**If none found**, tell the user:
> NotebookLM is not configured. To set it up:
> - Install notebooklm-py: `pip install 'notebooklm-py[browser]'` then `notebooklm login`
> - Or configure a NotebookLM MCP server in your Claude Code settings
>
> See: guides/notebooklm-workflows.md for full setup instructions.

Then stop. Do not proceed.

## Step 1: Understand the question

Parse the invocation for a question (e.g., `/ask-sme "What did we decide about auth?"`). If no question was passed inline, ask:
- What do you want to know?
- Which notebook? (if multiple — default to most recently modified)
- Output format: answer only / sourced answer / artifact (mind-map, slides, audio)

## Step 2: Query the notebook

**For direct Q&A:**
```bash
notebooklm ask "<question>"
```
Show the answer with source citations. If sources reference vault notes at `$VAULT_PATH`, show the file paths.

**For deep-dive questions**, run three focused queries:
```bash
notebooklm ask "<question> — focus on the decision or recommendation"
notebooklm ask "<question> — what are the tradeoffs or risks"
notebooklm ask "<question> — what alternatives were considered"
```
Synthesize into a structured answer with headings.

**For artifact generation:**
```bash
notebooklm generate <type>    # mind-map | data-table | slide-deck | audio
notebooklm download <type> ./<filename>
```
Report the downloaded file path to the user.

## Step 3: Optionally save to vault

If a vault is configured at `$VAULT_PATH` and the answer contains a decision, pattern, or significant finding, ask:
> "Worth saving to your vault? [y/N]"

If yes, save to `$VAULT_PATH/03_Resources/` under the appropriate subfolder using standard frontmatter. Use `/promote-to-vault` patterns for consistency.

## Fallback table

| Condition | Response |
|-----------|----------|
| Not authenticated | Show: `notebooklm login` |
| No notebook found | Suggest: `notebooklm create "<name>"` |
| Query timeout | Retry once, then suggest running manually |
| Vault not configured | Skip Step 3 silently |
| claude-mem available | Create an observation summarizing the Q&A |

## Examples

```
/ask-sme "What authentication approach did we decide on?"
/ask-sme "Compare the queue systems we evaluated"
/notebooklm-sme "Generate a mind-map of our Q1 architecture decisions"
/notebooklm-sme "What are known failure modes in the payment service?"
```
