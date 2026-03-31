# Conversational Setup — No Script Required

> **For non-technical users or anyone who prefers to have Claude walk them through it.**
>
> Instead of running the install script, you paste one prompt into Claude Code and Claude sets everything up conversationally — asking you what you want, explaining each step in plain English, and running everything for you.

---

## How it works

1. Open Claude Code in the folder where you cloned this repo
2. Paste the setup prompt below
3. Claude will ask you a few questions, then install everything

That's it. No terminal commands to memorize, no flags to learn.

---

## The Setup Prompt

Copy and paste this entire block into Claude Code:

```
I want to set up the HESOYAM Claude Code enhancement kit. The repo is cloned at my current directory.

Please be my guide. Start by asking me a few simple questions to understand what I need, then set everything up for me step by step. Explain what each step does in plain English — I don't need to understand all the technical details, just enough to know what's being installed and why.

Here's what this project installs (so you know what you're working with):
- Better AI agents and orchestration tools for Claude Code
- Security hooks that protect against common mistakes
- Optional: persistent memory so Claude remembers things between sessions
- Optional: a knowledge base (works with or without Obsidian)
- Optional: ecosystem discovery tools and NotebookLM integration

Start by asking me:
1. What kind of developer work do I mostly do?
2. How much do I care about Claude remembering things between sessions?
3. Do I already use Obsidian, or do I want a place to store notes and decisions?
4. Do I have a GitHub account?

Then recommend the right profile for me, explain what it will install, confirm I want to proceed, and do the setup.

Use the install script to do the actual installation (it handles everything safely), but explain what's happening at each stage. If anything fails or needs attention, walk me through it.
```

---

## What Claude will do

Claude will:
- Ask about your workflow to recommend the right profile (1–4)
- Explain what each profile installs before doing anything
- Run `./install.sh --profile <N>` with the right options for your answers
- Explain what just happened at each stage
- Tell you what to do next

---

## Profiles Claude will choose from

| Profile | What gets installed | Best for |
|---------|-------------------|----------|
| **1 — Minimal** | Better agents + security hooks | "Just make Claude Code smarter" |
| **2 — Memory** | +Session memory | "I want Claude to remember things" |
| **3 — Knowledge** | +Knowledge base (Obsidian optional) | "I write a lot and want to search my notes" |
| **4 — Full** | Everything | "I want the whole thing" |

---

## If you prefer even more hand-holding

Paste this shorter version instead — Claude will figure out the rest:

```
I want to set up HESOYAM in this directory. Ask me what I need, recommend a setup, explain it to me plainly, then do it.
```

---

## After setup

Once Claude finishes, you'll be prompted to restart Claude Code. After that, your new capabilities are live. Type `/daily-standup` to try your first skill.

See [daily-usage.md](./daily-usage.md) for what to do on day one.
