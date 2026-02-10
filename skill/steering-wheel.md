---
name: steering-wheel
description: Clarify output expectations using 6 dimensions. Use when requests are vague about tone, scope, or format.
---

# Steering Wheel Clarification

The **Steering Wheel** provides 6 dimensions for tuning AI output. Use this to clarify ambiguous requests and adjust outputs.

## When to Use

- User request is vague about output expectations
- User says "help me think through..." or "draft something..."
- Output could go multiple valid directions
- User hasn't specified tone, scope, or format

## The 6 Dimensions

| Dimension | Spectrum | Question |
|-----------|----------|----------|
| **Certainty** | Exploratory ↔ Definitive | Are we exploring options or making a decision? |
| **Originality** | Novel ↔ Proven | Should I try something new or stick to what works? |
| **Grounding** | Abstract ↔ Concrete | High-level strategy or specific actionable details? |
| **Risk** | Bold ↔ Safe | Push boundaries or play it safe? |
| **Scope** | Expansive ↔ Focused | Comprehensive coverage or focused deep-dive? |
| **Style** | Compelling ↔ Clear | Punchy and engaging or clear and direct? |

## Clarification Flow

### 1. Detect Ambiguity

Identify which dimensions are unclear from the request:

| Unclear Signal | Ambiguous Dimension |
|----------------|---------------------|
| "Help me think about..." | Certainty (explore vs decide?) |
| "Draft something for..." | Style (formal vs casual?) |
| "What should we do about..." | Risk (conservative vs bold?) |
| "Tell me about..." | Scope (overview vs deep-dive?) |
| No audience specified | Style + Grounding |

### 2. Ask Targeted Questions (Max 2-3)

Only ask about unclear dimensions. Use quick prompts:

```
"Before I dive in - are we exploring options or making a final decision?"
"Should I push boundaries here or keep it conservative?"
"High-level overview or specific details?"
```

### 3. Apply Settings

Load defaults from `~/.claude/jarvis/memory/user-profile.md`:
- Check document-type overrides first
- Fall back to personal defaults
- Override with user's clarifications

### 4. Offer Refinement After Output

After generating output:
```
"If this needs adjustment: 'make it bolder', 'more concrete', 'expand on this', etc."
```

## Presets (Shortcuts)

Recognize these trigger phrases and auto-apply settings:

| Preset | Trigger Phrases | Settings |
|--------|-----------------|----------|
| **Brainstorm Mode** | "let's brainstorm", "help me think", "explore options" | Exploratory, Novel, Abstract, Bold, Expansive, Compelling |
| **Final Draft** | "finalize", "polish this", "make it ready", "lock it in" | Definitive, Proven, Concrete, Safe, Focused, Clear |
| **Strategy Mode** | "strategy", "big picture", "long-term" | Exploratory, Novel, Abstract, Bold, Expansive, Compelling |
| **Execution Mode** | "tactical", "action items", "next steps", "implementation" | Definitive, Proven, Concrete, Safe, Focused, Clear |
| **External Comms** | "for LinkedIn", "blog post", "announcement" | Definitive, Novel, Concrete, Bold, Focused, Compelling |

## Refinement Commands

Users can adjust dimensions on-the-fly with these commands:

| Command | Effect |
|---------|--------|
| "make it more concrete" | Grounding → Concrete |
| "make it bolder" | Risk → Bold |
| "expand on this" | Scope → Expansive |
| "simplify" | Style → Clear, Scope → Focused |
| "make it punchier" | Style → Compelling |
| "more exploratory" | Certainty → Exploratory |
| "lock it in" | Certainty → Definitive |
| "be more conservative" | Risk → Safe |
| "try something different" | Originality → Novel |
| "stick to what works" | Originality → Proven |
| "give me the big picture" | Grounding → Abstract, Scope → Expansive |
| "get specific" | Grounding → Concrete, Scope → Focused |

## Document Type Detection

Auto-apply steering wheel settings based on document type:

| Detected Doc Type | Apply Settings From |
|-------------------|---------------------|
| PRD, spec, requirements | PRD override row |
| PRFAQ, announcement | PRFAQ override row |
| Strategy, roadmap | Strategy override row |
| Update, status, recap | Stakeholder Update override row |
| LinkedIn, blog, social | LinkedIn/Blog override row |
| Brainstorm, ideation | Brainstorm override row |

## Integration with Writing Skills

When invoking writing skills (prd-writing, prfaq-writing, etc.), steering wheel settings are applied automatically:

1. Detect document type from skill invoked
2. Load document-type override from user profile
3. Allow user overrides via preset or explicit command
4. Pass settings context to skill execution

## Example Interaction

```
User: "Help me draft something about the new feature"

Jarvis: "Before I start - a couple quick questions:

1. **Certainty:** Are we exploring positioning options, or is this a final draft?
2. **Audience:** Internal (clear/direct) or external (compelling/punchy)?

I'll use your defaults for the rest: concrete details, bold approach, focused scope."

User: "Exploring, internal"

Jarvis: [Generates with: Exploratory, Proven, Concrete, Bold, Focused, Clear]

...

User: "Make it bolder and expand on the competitive angle"

Jarvis: [Adjusts: Risk → Bold (already), Scope → Expansive on competitive section]
```

## Error Handling

| Scenario | Action |
|----------|--------|
| No clarification given | Use personal defaults from user-profile.md |
| Conflicting signals | Ask for clarification |
| Unknown document type | Use personal defaults |
| User says "just do it" | Apply defaults, skip questions |
