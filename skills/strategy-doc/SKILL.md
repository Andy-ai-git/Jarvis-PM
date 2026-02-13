---
name: strategy-doc
description: Write strategic analysis documents using Rumelt's Strategy Kernel and proven decision frameworks. Use when drafting strategic rationale, architecture decisions, competitive positioning, or go-to-market strategy.
---

# Strategy Doc Writing Skill

## Steering Wheel Settings (Strategy)

Before generating, apply these defaults (user can override):

| Dimension | Setting | Rationale |
|-----------|---------|-----------|
| **Certainty** | Exploratory | Strategy docs explore options before deciding |
| **Originality** | Novel | Find unique positioning and insights |
| **Grounding** | Abstract | Big picture first, details later |
| **Risk** | Bold | Challenge assumptions, consider ambitious moves |
| **Scope** | Expansive | Consider full competitive landscape |
| **Style** | Compelling | Strategy needs to inspire action |

**User overrides:** "lock it in" (for final strategy), "more concrete" (for implementation planning)

---

## Overview

This skill teaches how to write strategic analysis documents using Rumelt's Strategy Kernel framework—the standard for strategic documents.

## Rumelt's Strategy Kernel

A good strategy has three elements:

| Element | Question |
|---------|----------|
| **Diagnosis** | What is the critical challenge we face? |
| **Guiding Policy** | What is our overall approach to address it? |
| **Coherent Actions** | What specific, coordinated actions will we take? |

**Key Principle:** A bad strategy is a list of goals or features. A good strategy is a **focused response to a diagnosis**.

## Document Structure

### 1. Framework Introduction

```markdown
# [Topic]: Strategic Analysis
## Using Rumelt's Strategy Kernel

---

## Rumelt's Framework

A good strategy has three elements:

| Element | Question |
|---------|----------|
| **Diagnosis** | What is the critical challenge we face? |
| **Guiding Policy** | What is our overall approach to address it? |
| **Coherent Actions** | What specific, coordinated actions will we take? |

A bad strategy is a list of goals or features. A good strategy is a **focused response to a diagnosis**.

---
```

### 2. Part 1: Diagnosis

```markdown
# Part 1: Diagnosis

## The Situation

[2-3 paragraphs describing current state objectively]

## The Critical Challenge

> **[One-sentence statement of the core problem]**

Specifically:

1. **[Challenge aspect 1]** — [Explanation]
2. **[Challenge aspect 2]** — [Explanation]
3. **[Challenge aspect 3]** — [Explanation]

## The Crux

The crux of our challenge is not "[obvious framing]." The crux is:

> **[The real, harder question we must answer]**

[Explanation of why this framing matters]

---
```

### 3. Part 2: Guiding Policy

```markdown
# Part 2: Guiding Policy

## The Core Insight

**[Key insight that unlocks the strategy]**

[Comparison or analogy showing how current vs. proposed approach differs]

## The Policy

> **[One-sentence statement of the guiding policy]**

This means:

1. **[Implication 1]** — [Explanation]
2. **[Implication 2]** — [Explanation]
3. **[Implication 3]** — [Explanation]

## What This Policy Says "No" To

- [What we're NOT doing]
- [What we're NOT doing]

## What This Policy Says "Yes" To

- [What we ARE doing]
- [What we ARE doing]

---
```

### 4. Part 3: Coherent Actions

```markdown
# Part 3: Coherent Actions

The guiding policy demands a specific set of coordinated actions:

## Action 1: [Action Name]

**What:** [Brief description]

**How:**
- [Specific step]
- [Specific step]

**Why coherent:** [How this connects to guiding policy]

## Action 2: [Action Name]
[Same structure]

---
```

### 5. Part 4: Testing the Strategy

```markdown
# Part 4: Testing the Strategy

## Rumelt's Tests for Good Strategy

| Test | Our Strategy |
|------|--------------|
| **Does it address the diagnosis?** | [Yes/No + explanation] |
| **Is the guiding policy a choice?** | [Yes/No + explanation] |
| **Are the actions coherent?** | [Yes/No + explanation] |
| **Does it create advantage?** | [Yes/No + explanation] |

## What Must Be True

For this strategy to work, these assumptions must hold:

| Assumption | Risk if Wrong |
|------------|---------------|
| [Assumption] | [High/Medium/Low + explanation] |

## Competitive Response

| Competitor | Likely Response | Our Counter |
|------------|-----------------|-------------|
| [Competitor] | [Their move] | [Our response] |

---
```

### 6. Part 5: Summary

```markdown
# Part 5: Summary

## The Kernel

| Element | Statement |
|---------|-----------|
| **Diagnosis** | [One paragraph] |
| **Guiding Policy** | [One paragraph] |
| **Coherent Actions** | [Numbered list of actions] |

## One-Sentence Strategy

> **[The entire strategy in one sentence]**

---
```

## Writing Guidelines

### Diagnosis Style

- **Be specific about the problem**, not vague
  - Use: "We have autonomous AI agents. We have human agents who need help. We have no product connecting them."
  - Avoid: "We need to expand our product portfolio."

- **Use "The Crux" to reframe**
  - Don't accept the obvious question
  - Find the harder, more important question underneath

### Guiding Policy Style

- **A policy is a CHOICE**, not an aspiration
  - Use: "Build Copilot as an AMP deployment mode—not a separate product"
  - Avoid: "Build a great copilot product"

- **Use "Says No To / Says Yes To" format**
  - Forces clarity on trade-offs
  - Makes the choice explicit

### Coherent Actions Style

- **Each action must reinforce others**
- **Include "Why coherent" for each action**
- **Number actions** (Action 1, Action 2, etc.)

### Testing Style

- **Be honest** in the "Tests" section
- **Name specific assumptions** and risk levels
- **Include competitive response** anticipation

## Key Terminology

- "Diagnosis" (not "problem statement")
- "Guiding policy" (not "strategy" or "vision")
- "Coherent actions" (not "initiatives" or "roadmap")
- "The crux" (the real challenge, not the obvious one)
- "Moat" (defensible advantage)
- "Flywheel" (compounding advantage)

## Reference Documents

- Example: `/01-strategy/rumelt-strategic-analysis.md`
- Architecture decision: `/01-strategy/architecture-master-decision.md`

## Checklist Before Submission

- [ ] Diagnosis identifies specific, addressable challenge
- [ ] Guiding policy is a choice (says no to something)
- [ ] Actions are coherent (each reinforces others)
- [ ] "Why coherent" explained for each action
- [ ] Assumptions and risks explicitly stated
- [ ] Competitive response anticipated
- [ ] One-sentence summary captures the kernel
