---
name: prfaq-writing
description: Write PRFAQs using the Amazon-style template. Use when drafting product announcements, feature PRFAQs, or product proposals following the Amazon-style Press Release / FAQ format.
---

# PRFAQ Writing Skill

## Steering Wheel Settings (PRFAQ)

Before generating, apply these defaults (user can override):

| Dimension | Setting | Rationale |
|-----------|---------|-----------|
| **Certainty** | Definitive | PRFAQs announce decisions, not explore options |
| **Originality** | Novel | Position product uniquely vs. competitors |
| **Grounding** | Concrete | Specific metrics, customer quotes, dates |
| **Risk** | Bold | Ambitious claims (that we can deliver) |
| **Scope** | Focused | One product/feature, clear value prop |
| **Style** | Compelling | Press release style, engaging, quotable |

**User overrides:** "more conservative" (for internal-only), "exploratory" (for early concept testing)

---

## Overview

This skill teaches how to write Product/Feature PRFAQs following industry best practices—the Amazon-style Press Release + FAQ format.

## Document Structure

Every PRFAQ must include these sections in this order:

### 1. Metadata Header

```markdown
# PRFAQ: [Feature/Product Name]

**Created Date:** [Month Day, Year]
**Created by:** [Author Name]
**Last Updated:** [Month Day, Year]
**Version:** [X.X]
**Status:** [Draft | In Review | Approved]
**Reviewed by:** [Reviewer Names]

---
```

### 2. Press Release

Structure:
1. **Headline** - Benefit-focused, quantified impact
   - Format: "[Company] [Action] with [Product]: [Key Benefit] and [Second Benefit]"
   - Example: "Acme Corp Launches Smart Assistant: AI-Powered Assistance That Cuts Handle Time by 40%"

2. **Subheadline** - One-line value proposition (italicized)

3. **Dateline** - Location + Future Date (when GA launches)
   - Format: "**BERLIN – [Month Year]** – Today, [Company] announced..."

4. **Opening Paragraph** - What it is + key metrics (3-5 quantified benefits)

5. **Problem Statement** - 2-3 paragraphs on market pain points with statistics

6. **Solution Statement** - Bold statement: "[Product] solves all these problems at once."

7. **Feature Bullets** - Key capabilities (5-7 bullets, bold feature name + description)

8. **How It Works** - One paragraph explaining the user experience

9. **Executive Quote** - CEO or product leader quote on vision

10. **Platform Benefits** - Why this architecture/approach matters

11. **Customer Quote** - Testimonial with specific metrics (can be aspirational)

12. **Availability & CTA** - Launch timeline + next steps

### 3. Customer FAQ (Q1-Q8)

Questions customers would ask:

- **Q1:** What is [Product]?
- **Q2:** Why is your solution better than competitors?
- **Q3:** Who is this designed for? (Industries + Personas)
- **Q4:** What problems does it solve? (Detailed with metrics)
- **Q5:** How does it learn/improve over time?
- **Q6:** Security/Compliance/Data residency?
- **Q7:** When will it be available? (Phased roadmap)
- **Q8:** How much will it cost?

Format for each:
```markdown
## Q[N]: [Question]

**A:** [Answer]

[Supporting details, bullets, tables as needed]

---
```

### 4. Stakeholder FAQ (Q9-Q18)

Questions internal stakeholders would ask:

- **Q9:** Why are we building this now? (Strategic rationale)
- **Q10:** How do we know what customers want? (Discovery evidence)
- **Q11:** What is our competitive position?
- **Q12:** Pricing strategy and unit economics?
- **Q13:** Phased rollout strategy and why?
- **Q14:** UX/Design preview?
- **Q15:** Critical dependencies?
- **Q16:** Long-term product strategy fit?
- **Q17:** Where are the PRDs?
- **Q18:** [Additional as needed]

### 5. Appendix

- List of supporting documents with links
- Version history

## Writing Guidelines

### Press Release Style

- **Lead with outcomes, not features**
  - Use: "Cuts handle time by 40%"
  - Avoid: "Uses advanced AI algorithms"

- **Quantify everything**
  - Use: "114+ languages", "25-40% AHT reduction"
  - Avoid: "Many languages", "Significant improvement"

- **Use specific customer language**
  - Reference actual customer quotes from discovery
  - Use industry terminology (AHT, FCR, CSAT)

- **Future-dated but realistic**
  - Write as if launching (even if months away)
  - Metrics should be achievable targets

### FAQ Style

- **Start every answer with "A:"**
- **Lead with the direct answer, then elaborate**
- **Use tables for comparisons** (industries, competitors, phases)
- **Include "Key Quotes" sections** with attributed customer feedback
- **Reference supporting documents** with links

### Terminology

- "Smart Assistant" or "Platform Assistant" (not "Agent Assist")
- "Deployment mode" (not "product")
- "Data flywheel" (key strategic concept)
- "Human-in-the-loop" (vs. autonomous)

## Example Sections

### Good Press Release Opening

```markdown
**NEW YORK – Sep 2026** – Today, Acme Corp announced Smart Assistant, a new deployment
mode for its Agent Management Platform (AMP) that brings the full power of
AI-powered assistance to human agents. Smart Assistant reduces average handle time
by 25-40%, improves first-contact resolution by 20-35%, cuts after-call work by
up to 80%, and enables agents to serve customers in 114+ languages through
real-time voice translation—all from a single integrated workspace.
```

### Good FAQ Answer

```markdown
## Q2: Why is your solution better than competitors?

**A:** Unlike standalone copilot vendors who built isolated solutions, Platform Assistant
is the same AI brain that powers our autonomous agents—just with a human making
the final call. This isn't a siloed product. It's AMP with human-in-the-loop.

This architecture creates four unfair advantages:

### 1. One Platform, All Capabilities
Every feature we build for autonomous agents becomes instantly available for Copilot...

### 2. Dial the Balance
Clients can shift the mix of autonomous and assisted interactions...
```

## Reference Documents

- Example PRFAQ: `/01-strategy/agent-copilot-prfaq.md`
- Template: `/06-reference/prfaq-example-amp-assist.md`

## Checklist Before Submission

- [ ] Headline is benefit-focused with quantified impact
- [ ] Opening paragraph has 3-5 specific metrics
- [ ] Problem statement includes market statistics
- [ ] Feature bullets use bold names + descriptions
- [ ] Executive quote conveys vision, not features
- [ ] Customer quote has specific metrics
- [ ] Customer FAQ answers the "why buy" questions
- [ ] Stakeholder FAQ justifies strategic investment
- [ ] All claims are achievable (not aspirational fiction)
