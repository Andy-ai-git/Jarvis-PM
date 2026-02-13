---
name: stakeholder-update
description: Write executive updates and stakeholder communications following standard templates. Use when drafting status updates, progress reports, sprint summaries, decision requests, or executive briefings.
---

# Stakeholder Update Writing Skill

## Steering Wheel Settings (Stakeholder Update)

Before generating, apply these defaults (user can override):

| Dimension | Setting | Rationale |
|-----------|---------|-----------|
| **Certainty** | Definitive | Report facts, not speculations |
| **Originality** | Proven | Use established update formats |
| **Grounding** | Concrete | Specific metrics, dates, names |
| **Risk** | Safe | Honest about risks, conservative estimates |
| **Scope** | Focused | What matters for this update period |
| **Style** | Clear | Busy executives need direct communication |

**User overrides:** "more detailed" (for comprehensive reports), "punchier" (for board updates)

---

## Overview

This skill teaches how to write executive updates and stakeholder communications that respect busy readers' time while providing complete information.

## Update Formats

### Format 1: Executive Weekly Update

```markdown
# [Project/Feature] Update - Week of [Date]

## TL;DR (3 bullets max)
- **Status:** [On Track | At Risk | Blocked] - [one sentence why]
- **Key Win:** [Most important progress this week]
- **Decision Needed:** [If any - otherwise "None this week"]

---

## Progress This Week

**Shipped/Completed:**
- [Accomplishment with metric if possible]
- [Accomplishment]

**Metrics Update:**
| Metric | Target | Current | Trend |
|--------|--------|---------|-------|
| [Metric] | [Target] | [Current] | [up/down/flat] |

---

## Blockers & Risks

| Issue | Impact | Mitigation | Owner | Help Needed |
|-------|--------|------------|-------|-------------|
| [Blocker] | [High/Med/Low] | [Plan] | [Name] | [Yes/No - what] |

---

## Next Week Focus

1. [Top priority]
2. [Second priority]
3. [Third priority]

---

## Decisions Needed (if any)

**Decision:** [What needs to be decided]

**Options:**
| Option | Pros | Cons | Recommendation |
|--------|------|------|----------------|
| A: [Option] | [Pros] | [Cons] | |
| B: [Option] | [Pros] | [Cons] | Recommended |

**Deadline:** [When decision needed by]

**Impact of Delay:** [What happens if not decided]
```

### Format 2: Sprint Summary

```markdown
# Sprint [N] Summary - [Sprint Name]

**Dates:** [Start] - [End]
**Status:** [Completed | In Progress]

## Sprint Goal
[One sentence describing what this sprint aimed to achieve]

## Accomplishments

### Completed
- [x] [Item with brief description]
- [x] [Item]

### Carried Over
- [ ] [Item] - Reason: [Why not completed]

## Key Metrics

| Metric | Sprint Start | Sprint End | Change |
|--------|--------------|------------|--------|
| [Metric] | [Value] | [Value] | [+/-X%] |

## Learnings

**What Worked:**
- [Learning]

**What Didn't:**
- [Learning]

**Action Items:**
- [Action for next sprint]

## Next Sprint Preview
[2-3 sentences on Sprint N+1 focus]
```

### Format 3: Decision Request

```markdown
# Decision Request: [Topic]

**Requested by:** [Name]
**Date:** [Date]
**Decision Deadline:** [Date]
**Deciders:** [Names]

---

## Context
[2-3 paragraphs explaining the situation and why a decision is needed now]

## The Decision
> [One-sentence framing of what needs to be decided]

## Options

### Option A: [Name]
**Description:** [What this option means]

**Pros:**
- [Pro]
- [Pro]

**Cons:**
- [Con]
- [Con]

**Implications:**
- Timeline: [Impact]
- Resources: [Impact]
- Risk: [Impact]

### Option B: [Name]
[Same structure]

### Option C: [Name]
[Same structure]

## Recommendation

**Recommended Option:** [Option X]

**Rationale:** [Why this option is recommended - 2-3 sentences]

## Impact of No Decision
[What happens if we don't decide by the deadline]

---

**Next Step:** [What happens after decision is made]
```

## Writing Principles

### Lead with Outcomes, Not Activities

- Avoid: "Had 5 meetings about feature X"
- Use: "Validated feature X with 15 users, 80% would use it"

- Avoid: "Worked on migration planning"
- Use: "Migration plan approved, 3 tenants ready for pilot"

### Be Specific with Metrics

- Avoid: "Good engagement"
- Use: "DAU increased 15% (5k to 5.75k)"

- Avoid: "Reduced latency"
- Use: "P95 latency down from 800ms to 450ms"

### Flag Risks Early

- Don't bury bad news at the end
- Always include mitigation plan
- Name who needs to help

### Action-Oriented Next Steps

- Avoid: "Continue working on X"
- Use: "Launch beta to 100 users by Friday"

- Avoid: "Address feedback"
- Use: "Resolve 3 blocking issues identified in review by Wednesday"

## Status Definitions

| Status | Meaning | When to Use |
|--------|---------|-------------|
| **On Track** | Meeting plan, no significant risks | Default if proceeding normally |
| **At Risk** | Potential issues that need attention | Known blockers with mitigation plans |
| **Blocked** | Cannot proceed without resolution | Hard blockers requiring escalation |

## Frequency Guidelines

| Update Type | Audience | Frequency |
|-------------|----------|-----------|
| Executive Update | Leadership | Weekly |
| Sprint Summary | Stakeholders | Per sprint |
| Decision Request | Deciders | As needed |
| Project Status | Full team | Bi-weekly |

## Product-Specific Context

When writing updates for key projects:

**Key Metrics to Track:**
- Migration progress (tenants migrated / total)
- Feature parity status (% complete)
- Latency (P50, P95, P99)
- Customer feedback (NPS, qualitative)

**Key Stakeholders:**
- Dmitry Timofeev, Csaba Tamas (reviewers)
- Saransh Mehta (Product Suite)
- Team leads: CPL, Agent Core, DPA, Foundations

**Key Milestones Reference:**
- Phase 1: Translation Mode (EOQ2 2026)
- Phase 2: Same-Language Copilot (Q3 2026)
- Phase 3: Advanced Copilot (Q4 2026)

## Checklist Before Sending

- [ ] TL;DR is 3 bullets or fewer
- [ ] Status is clear (On Track / At Risk / Blocked)
- [ ] Metrics are specific numbers, not qualitative
- [ ] Blockers have owners and mitigation plans
- [ ] Next steps are action-oriented with deadlines
- [ ] Decision requests have clear options and recommendation
- [ ] No jargon that audience won't understand
