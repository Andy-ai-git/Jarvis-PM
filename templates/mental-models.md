# Mental Models

Reasoning frameworks and thinking tools Andrey wants applied during sparring. Loaded on Jarvis activation.

**Usage:** These are defaults. Apply the relevant model when the conversation fits. Multiple models can layer on the same problem.

---

## First Principles Thinking

**What it is:** Strip away assumptions, conventions, and analogies. Decompose to verifiable fundamentals. Rebuild from what we actually know to be true.

**When to apply:**
- "We should do X because that's how Y does it" — reasoning by analogy
- "Everyone in the industry does X" — reasoning by convention
- Costs, timelines, or constraints are accepted without questioning their basis
- A problem feels stuck or the solution space feels artificially narrow

**Protocol:**

1. **Surface the assumption.** What are we taking for granted? What convention or analogy is driving the current thinking?
2. **Decompose to fundamentals.** What do we actually know to be true? What's verifiable? Strip it to the physics of the problem.
3. **Challenge each component.** For each fundamental: is this a law of nature, or a choice someone made? Can it be different?
4. **Rebuild from truths.** Given only what we know to be true, what's the best solution? Ignore how it's been done before.

**What good looks like:**
- Clearly named assumptions that were previously implicit
- A "what we actually know" list — short, verifiable, no opinions
- A rebuilt answer that may or may not match the original — but is grounded in fundamentals

**Anti-patterns to catch:**
- "Best practice" used as justification (best practice for whom? under what conditions?)
- Cost anchoring ("it costs $X" — why? what are the components?)
- Complexity anchoring ("it would take Y months" — what are the actual steps and their durations?)
- False constraints ("we can't do Z" — is that physics or policy?)

---

## Rumelt's Strategy Kernel

**What it is:** Strategy = Diagnosis + Guiding Policy + Coherent Actions. Formalized in the `strategy-doc` skill.

**When to apply:**
- Strategic decisions, positioning, go/no-go
- When the conversation needs "what's the real challenge here?"

**Protocol:** See `strategy-doc` skill for full template. Core moves:
1. **Diagnosis** — Reframe the problem to the crux (the real challenge, not the surface one)
2. **Guiding Policy** — The approach. Says Yes To / Says No To.
3. **Coherent Actions** — Specific, reinforcing steps that execute the policy.

**Key lenses:** Unfair advantages, data flywheel, what we're saying NO to.

---

## Design Thinking

**What it is:** Start from the user, not the solution. Understand who you're solving for and what they actually need before building anything. Iterate through empathy → problem definition → divergent ideas → rapid validation.

**When to apply:**
- Feature requests arrive without user context ("we need X")
- Jumping to solutions before articulating the user's problem
- Building for the business or the technology, not the user
- "Users will love this" without evidence
- Multiple valid solutions exist and you need a selection criterion

**Protocol:**

1. **Empathize.** Who is the user? What's their context, constraints, and emotional state? What have we observed (not assumed)?
2. **Define.** What's the real problem from the user's perspective? Frame as: "[User] needs [need] because [insight]." If you can't fill this in with evidence, you're not ready to solve.
3. **Diverge.** Generate multiple solutions — at least 3. Don't anchor on the first idea. Quantity before quality.
4. **Converge.** Select based on: user value × feasibility × strategic fit. Not just what's easiest to build.
5. **Validate.** What's the cheapest way to test this with real users before committing? Prototype, mock, conversation — anything that generates evidence.

**What good looks like:**
- A named user persona with observed (not assumed) needs
- Problem statement grounded in user evidence
- Multiple options explored before selecting
- A validation plan that comes before full investment

**Anti-patterns to catch:**
- "Users want X" without citing research, interviews, or data
- Single-solution thinking ("the only way to do this is...")
- Building the full thing before validating the core assumption
- Confusing stakeholder requests with user needs
- Empathy theater — doing "user research" to confirm a decision already made

---

## Framework Selection

| Signal | Reach for |
|--------|-----------|
| "How should we approach X?" / strategic direction | Rumelt's Strategy Kernel |
| "Why does it cost/take so much?" / accepted constraints | First Principles |
| "Everyone does it this way" / convention-driven | First Principles |
| "Should we build X?" / opportunity evaluation | First Principles → then Rumelt if yes |
| "What's our strategy for X?" / positioning | Rumelt's Strategy Kernel |
| Stuck, narrow solution space | First Principles to widen, then Rumelt to choose |
| "Users want X" / feature request without evidence | Design Thinking |
| "What should we build?" / ambiguous problem space | Design Thinking → then Rumelt to prioritize |
| Jumping to solutions before defining the problem | Design Thinking |
| Multiple valid solutions, no selection criterion | Design Thinking (converge step) |

---

## Adding New Models

When Andrey introduces a new mental model, add it here with:
- What it is (1-2 sentences)
- When to apply (triggers)
- Protocol (steps)
- What good looks like
- Anti-patterns

---
*Last updated: 2026-02-11 (added Design Thinking)*
