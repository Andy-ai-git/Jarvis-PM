# Task Brief: Multi-Perspective Review

## Objective
Comprehensive review of **[DOCUMENT_NAME]** from technical, strategic, and user perspectives.

## Subagents Assigned (Parallel Execution)

| Agent | Focus | Parallel |
|-------|-------|----------|
| **Engineer** | Technical feasibility, architecture, risks | ✓ |
| **Executive** | Strategic alignment, stakeholder clarity | ✓ |
| **User Researcher** | User value, adoption, validation gaps | ✓ |

## Files to Review
- **Primary:** [DOCUMENT_PATH_OR_DRIVE_ID]
- **Supporting:** [LIST_OTHER_RELEVANT_DOCS]

## Context Summary
[2-3 sentences: What document? What decision? Why multi-perspective review?]

## Review Instructions

### Engineer Focus
- Technical feasibility and timeline
- Dependencies and blockers
- Architecture implications
- Risk assessment

### Executive Focus
- Strategic alignment
- Stakeholder clarity
- Competitive positioning
- Business case strength

### User Researcher Focus
- Pain point validity
- Solution fit
- Adoption barriers
- Validation evidence

## Specific Questions to Answer
1. Should we proceed with this? (Go/No-Go)
2. What are the top 3 risks across all perspectives?
3. Where do the perspectives align/conflict?
4. What's missing that would change our confidence?

## Synthesis Requirements

After individual reviews, Jarvis should synthesize:
- **Consensus areas:** Where all three agree
- **Conflicts:** Where perspectives differ
- **Combined risk assessment:** Top risks across all lenses
- **Unified recommendation:** Go/No-Go/Conditional

## Success Criteria
- [ ] All three perspectives are represented
- [ ] Conflicts are highlighted (not hidden)
- [ ] Combined recommendation is clear
- [ ] Action items are assigned

## Output Destination
Save to: `~/.claude/jarvis/context/[PROJECT]/analysis-outputs/`
- `[DOC_NAME]-engineer-review-[DATE].md`
- `[DOC_NAME]-executive-review-[DATE].md`
- `[DOC_NAME]-user-researcher-review-[DATE].md`
- `[DOC_NAME]-synthesis-[DATE].md`

---
*Template version: 1.0*
*Use for: Major decisions, launch readiness, strategy validation*
