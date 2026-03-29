---
type: spike
title:
date: {{date}}
timebox: {{hours}}h
status: completed | abandoned | needs-more-time
tags: [spike, investigation]
---

# Spike: {{title}}

## Objective

What question are we trying to answer? What uncertainty are we reducing?

*A spike is complete when we can confidently answer the question, NOT when we've built a production solution.*

## Timebox

| | |
|---|---|
| **Budget** | {{hours}} hours |
| **Started** | {{date}} |
| **Ended** | |
| **Actual time** | |

## Background

Why does this spike exist? What triggered the need to investigate?

## Questions to Answer

1. **Primary:**
2. **Secondary:**
3. **Secondary:**

## Approach

What did we actually do during the spike?

### Step 1: {{description}}

*Findings:*

### Step 2: {{description}}

*Findings:*

### Step 3: {{description}}

*Findings:*

## Proof of Concept

*If a PoC was built, describe it here. Link to branch if applicable.*

- **Branch:** `spike/{{name}}`
- **Key files:**
- **How to run:**
- **What it demonstrates:**

## Findings

### Question 1: {{question}}

**Answer:**

**Confidence:** High | Medium | Low

**Evidence:**

### Question 2: {{question}}

**Answer:**

**Confidence:** High | Medium | Low

**Evidence:**

### Question 3: {{question}}

**Answer:**

**Confidence:** High | Medium | Low

**Evidence:**

## Surprises

Things we didn't expect to find:

1.

## Recommendation

Based on this spike, we recommend:

- [ ] **Proceed** — the approach is viable. Create implementation tickets.
- [ ] **Pivot** — original approach won't work. Recommended alternative:
- [ ] **Deeper spike** — need more time. Remaining unknowns:
- [ ] **Abandon** — the idea is not worth pursuing because:

## Estimated Implementation Effort

If we proceed, rough estimates:

| Component | Effort | Risk |
|-----------|--------|------|
| | | |
| | | |
| **Total** | | |

## Cleanup

- [ ] Delete spike branch (or merge PoC if reusable)
- [ ] Create follow-up tickets if proceeding
- [ ] Share findings with the team
- [ ] Archive this report in vault (03_Resources/tech-decisions/)
