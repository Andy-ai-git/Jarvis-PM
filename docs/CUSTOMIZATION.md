# Customizing Your Jarvis Profile

Start minimal, expand over time.

---

## Philosophy

Jarvis works with a minimal profile. You don't need to configure everything on day one.

**Recommended approach:**
1. Start with the minimal profile (installed by default)
2. Add customizations as you discover preferences
3. Let Jarvis learn from corrections (it updates `learnings.md`)

---

## Profile Location

```
~/.claude/jarvis/memory/user-profile.md
```

---

## Minimal Profile (Default)

The installer creates this:

```markdown
# User Profile

## Identity
- **Name:** [Your name]
- **Role:** Product Manager

## Communication
- **Default style:** Brief and direct
- **When to elaborate:** When I ask "walk me through", "explain", or "why"

## Core Preferences
- Challenge my assumptions
- Say "I don't know" when uncertain
- No sycophancy
```

This is enough to get started.

---

## Customization Options

### Communication Style

```markdown
## Communication

- **Default style:** Brief and direct
- **Detail triggers:** "walk me through", "explain in detail", "why"
- **Format preference:** Bullet points over paragraphs
- **Code style:** Show full code, not diffs
```

### Writing Voice

```markdown
## Writing Voice

When drafting content for me:
- **Tone:** Professional but approachable
- **Sentence length:** Mix of short punchy and longer explanatory
- **Avoid:** Corporate jargon, buzzwords, "synergy"
- **Include:** Concrete examples, specific numbers
```

### Decision Making

```markdown
## Decision Making

- **Risk tolerance:** Moderate - prefer reversible decisions
- **Speed vs. thoroughness:** Bias toward action with good-enough info
- **Stakeholder priority:** Users > Engineering > Business
```

### Domain Context

```markdown
## Domain

- **Industry:** B2B SaaS
- **Company stage:** Series B, 100 employees
- **Product:** Contact center AI platform
- **Key metrics:** ARR, NRR, CSAT
```

### Tools & Systems

```markdown
## Tools

- **Documentation:** Notion
- **Code:** GitHub
- **Communication:** Slack
- **Project tracking:** Linear
```

### Specialist Preferences

```markdown
## Specialist Usage

- **Always invoke for PRDs:** Engineering Team (CTO, Backend, Frontend)
- **Always invoke for launches:** Marketer + Executive
- **Skip for:** Quick brainstorming, casual questions
```

---

## Full Template

For all available options, see:
```
~/.claude/jarvis/templates/user-profile-template.md
```

Copy sections you want into your `user-profile.md`.

---

## Learnings File

Jarvis remembers corrections in:
```
~/.claude/jarvis/memory/learnings.md
```

### Automatic Learning

When you correct Jarvis:
```
You: Actually, we use SAML not OAuth.
Jarvis: Got it - I'll remember SAML for future auth discussions.
        [Updates learnings.md]
```

### Manual Learning

You can also add learnings directly:
```markdown
## Learnings

- **2024-01-15:** Prefers "users" over "customers" in internal docs
- **2024-01-20:** Sprint planning is Tuesdays, not Mondays
- **2024-02-01:** Always CC Sarah on infrastructure decisions
```

---

## Cross-Project Knowledge

For facts that apply across all projects:
```
~/.claude/jarvis/memory/cross-project-knowledge.md
```

Example:
```markdown
## Company

- Company name: Acme Corp
- Founded: 2019
- HQ: Berlin
- Engineering: 40 people across 5 teams

## Key Stakeholders

- CEO: Jane Smith (focuses on ARR growth)
- CTO: Bob Chen (cares about technical debt)
- VP Product: Alice Wong (my skip-level)

## Standards

- All PRDs use the company template
- Security review required for user data changes
- Design review required for UI changes
```

---

## Project-Specific Context

Each project can have its own context:
```
~/.claude/jarvis/context/[project-slug]/
```

Created automatically when you work in a project directory.

---

## Tips

### Start Small
Don't try to fill in everything. Add customizations when you notice Jarvis doing something you'd prefer differently.

### Be Specific
Instead of "write better", say "use shorter sentences and more bullet points".

### Use Examples
Show Jarvis what you want:
```markdown
## Writing Examples

Good: "Users can now export reports to CSV."
Bad: "We're excited to announce the new export functionality!"
```

### Review Periodically
Once a month, review `learnings.md` and promote important patterns to `user-profile.md`.

---

## Related Documentation

- [Skill Registration](SKILL-REGISTRATION.md) - How `/jarvis` works
- [Troubleshooting](TROUBLESHOOTING.md) - Common issues
