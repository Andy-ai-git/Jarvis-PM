# Task Brief: Prompt Assessment

## Scenario

Select one:

- [ ] **Scenario A — Fresh Prompt (Proactive):** No known issues. Assess structural quality and predict failure modes before launch.
- [ ] **Scenario B — Prompt with Known Issues (Reactive):** Agent is failing. Diagnose root causes from observed symptoms.
- [ ] **Scenario C — Reassessment (Iterative):** Fixes applied. Compare updated prompt against previous assessment.

## Objective

Perform a structured, evidence-backed assessment of **[AGENT_NAME]**'s prompt using the Prompt Assessor methodology.

## Subagent Assigned

| Agent | Skill Location | Focus |
|-------|----------------|-------|
| **Prompt Assessor** | `~/.claude/jarvis/subagents/prompt-assessor/SKILL.md` | Structural audit, risk quantification, remediation |

**Research Library:** `~/.claude/jarvis/subagents/prompt-assessor/research-library.md` — must be read before assessment.

## Files to Review

- **Primary:** [PROMPT_PATH_OR_DRIVE_ID] — The full agent prompt to assess
- **Research:** `~/.claude/jarvis/subagents/prompt-assessor/research-library.md`
- **Supporting (Scenario B):** [CONVERSATION_LOGS], [FAILURE_REPORTS]
- **Previous Assessment (Scenario C):** [PREVIOUS_ASSESSMENT_PATH]

## Context Summary

[2-3 sentences: What agent does this prompt power? What model/platform? For Scenario B: what symptoms? For Scenario C: what was fixed?]

## Target Model (required for all scenarios)

| Field | Value |
|-------|-------|
| Current model | [e.g., GPT-4o, Claude Sonnet 4.5] |
| Migration planned? | [e.g., → GPT-4.1 in Q2 2026, or "No"] |
| Platform | [e.g., custom platform, custom deployment, Azure OpenAI] |
| Prompt delivery | [e.g., all sections bundled per turn, system message only, multi-message] |

**Why this matters:** The assessor tags every recommendation with its applicability to your specific model. Evidence tested on Claude may not transfer to GPT-4o. This field ensures you get honest, model-specific guidance.

## Scenario-Specific Inputs

### Scenario A — Fresh Prompt
- Expected turn depth: [e.g., 1-3 turns, 10+ turns]
- Launch timeline: [e.g., next week, next quarter]
- Live agent access for adversarial probing: [Yes/No]

### Scenario B — Known Issues
- Sample size available: [e.g., 200 conversations]
- Top observed symptoms:
  1. [e.g., Agent skips mandatory disclosures after turn 5]
  2. [e.g., Wrong tool called for balance inquiries]
  3. [e.g., Prompt injection succeeds with role-play attacks]
- Failure rate: [e.g., ~15% of conversations have at least one issue]
- Live agent access for adversarial probing: [Yes/No]

### Scenario C — Reassessment
- Previous assessment path: [file path or Drive ID]
- Changes made since last assessment:
  1. [e.g., Consolidated rules from 50 to 18]
  2. [e.g., Moved security rules to top of prompt]
  3. [e.g., Externalized disclosure templates]

## Thinking Level

Use extended thinking ("think hard") for this assessment. The structural audit and risk analysis require careful reasoning.

## Success Criteria

- [ ] Target model context present with applicability tags on all recommendations
- [ ] Health Scorecard present at top of output with composite grade
- [ ] All phases completed with substantive findings (including adversarial probing)
- [ ] Every recommendation cites evidence from research-library.md
- [ ] Every recommendation tagged: [Direct], [Adjacent], [Cross-model], [Consensus], or [Unverified]
- [ ] Cross-model evidence flagged with explicit caveats
- [ ] Issue table connects structural causes to symptoms/predictions
- [ ] Solution architecture tier justified and specific to THIS prompt
- [ ] Impact estimates have confidence levels and extrapolation notes
- [ ] Validation plan defines concrete metrics and sample sizes
- [ ] For Scenario C: delta report with before/after comparison

## Output Destination

Save assessment to: `~/.claude/jarvis/context/[PROJECT]/analysis-outputs/`
- Scenario A/B: `[AGENT_NAME]-prompt-assessment-[DATE].md`
- Scenario C: `[AGENT_NAME]-reassessment-[DATE].md`

---
*Template version: 2.1*
*Use for: LLM agent prompt assessments (proactive, reactive, or iterative)*
