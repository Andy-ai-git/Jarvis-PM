---
name: prd-writing
description: Write PRDs using industry best practices and standards. Use when drafting product requirements documents, feature specs, migration plans, or technical product proposals.
---

# PRD Writing Skill

## Steering Wheel Settings (PRD)

Before generating, apply these defaults (user can override):

| Dimension | Setting | Rationale |
|-----------|---------|-----------|
| **Certainty** | Definitive | PRDs are final specs, not explorations |
| **Originality** | Proven | Use established patterns and templates |
| **Grounding** | Concrete | Specific requirements, measurable criteria |
| **Risk** | Safe | Conservative estimates, thorough risk assessment |
| **Scope** | Focused | Only what's needed for this release |
| **Style** | Clear | Direct language, no marketing fluff |

**User overrides:** "make it more exploratory" (for early drafts), "expand scope" (for comprehensive docs)

---

## Overview

This skill teaches how to write Product Requirements Documents (PRDs) following industry best practices.

## Document Structure

Every PRD must include these sections in this order:

### 1. Metadata Header

```markdown
# PRD: [Feature/Project Name]

**Created Date:** [Month Day, Year]
**Created by:** [Author Name]
**Last Updated:** [Month Day, Year]
**Version:** [X.X]
**Status:** [Draft | In Progress | In Review | Approved]
**Reviewed by:** [Reviewer Names]

---
```

### 2. Project Overview

```markdown
## 1. Project Overview

[2-3 paragraphs explaining what this project delivers and why]

**[Project] Focus:** "[Tagline summarizing scope]"

Based on [discovery source] with [teams/customers], we identified that [this project] requires:
- [Key requirement 1]
- [Key requirement 2]
- [Key requirement 3]

We will deliver [outcome]. Unlike [current state], [new state] will [key benefit].

### 1.1 References

| Document | Content |
|----------|---------|
| [Doc name] | [What it contains] |
| [Doc name] | [What it contains] |

### 1.2 Stakeholders

| Role | Person |
|------|--------|
| Product Owner | [Name] |
| Engineering Lead | [Name] |
| [Team Name] | [Names] |
| [Team Name] | [Names] |
```

### 3. Purpose and Scope

```markdown
## 2. Purpose and Scope

### 2.1 Core Tenets

1. **[Tenet Name]:** [Explanation of guiding principle]
2. **[Tenet Name]:** [Explanation]
3. **[Tenet Name]:** [Explanation]

### 2.2 User Personas

#### Primary Persona: [Role Name]

[Brief description of who they are]

| Attribute | Description |
|-----------|-------------|
| **Background** | [Context about this user] |
| **Goals** | [What they're trying to achieve] |
| **Pain Points** | [Current frustrations] |
| **Key Needs** | [What they need from this solution] |

**Jobs To Be Done ([Phase/MVP]):**
- [Job 1]
- [Job 2]
- [Job 3]

**Pain Points Addressed by [Phase]:**
- [Pain point 1 and how addressed]
- [Pain point 2 and how addressed]

#### Secondary Persona: [Role Name]
[Same structure]
```

### 4. Requirements

```markdown
## 3. Requirements

### 3.1 Functional Requirements

**[Feature Area 1]:**
- [Requirement]
- [Requirement]
  - [Sub-requirement]
  - [Sub-requirement]

**[Feature Area 2]:**
- [Requirement]

### 3.2 Non-functional Requirements

| Category | Requirement | Target |
|----------|-------------|--------|
| Performance | [Metric] | [Value] |
| Reliability | [Metric] | [Value] |
| Latency | [Metric] | [Value] |

### 3.3 Technical Requirements

**[Technical Area]:**
- [Requirement with rationale]

### 3.4 Out of Scope

- [What's explicitly NOT included]
- [What's deferred to future phases]
```

### 5. Implementation

```markdown
## 4. Implementation

### 4.1 Dependencies

| Dependency | Owner | Status | Risk |
|------------|-------|--------|------|
| [Dependency] | [Team/Person] | [Status] | [High/Medium/Low] |

### 4.2 Timeline and Milestones

| Milestone | Deliverables | Target Date |
|-----------|--------------|-------------|
| [Milestone] | [What's delivered] | [Date] |

### 4.3 Success Criteria

- [Measurable criterion]
- [Measurable criterion]
```

### 6. Risk Assessment

```markdown
## 5. Risk Assessment

| Risk | Impact (1-10) | Likelihood (1-10) | Mitigation Plan |
|------|---------------|-------------------|-----------------|
| [Risk] | [N] | [N] | [How to mitigate] |
```

### 7. Open Questions

```markdown
## 6. Open Questions

**High Priority:**
- [Question needing resolution]

**Medium Priority:**
- [Question]
```

## Writing Guidelines

### Core Tenets Style

- **2-3 guiding principles** that shape all decisions
- **Bold the tenet name**, then explain
- Examples:
  - "Full Feature Parity:" We commit to delivering full feature parity with current solution
  - "Migration without Disruption:" Existing customers migrate with zero feature regression

### Persona Style

- **Use job titles** (Call Center Agent, Supervisor, Operations Leader)
- **Include JTBD** (Jobs To Be Done) as action verbs
- **Connect pain points to solutions**
- **Be specific** ("15-50% of call time" not "lots of time")

### Requirements Style

- **Organize by feature area** or workflow phase
- **Use bullet hierarchies** for sub-requirements
- **Include acceptance criteria** where testable
- **Separate functional vs. non-functional vs. technical**

### Dependencies Style

- **Name the owner** (team or person)
- **Assess risk** (High/Medium/Low)
- **Track status** (Recognized, In Progress, Blocked, Resolved)

### Quantification

- Use specific numbers: "100% feature parity", "Latency < 500ms", "Zero feature regression"
- Avoid vague terms: "Full feature support", "Low latency", "Minimal regression"

## Reference Documents

- Example PRD: `/examples/platform-migration-prd.md`
- Template: `/06-reference/prd-example-amp-assist.md`

## Checklist Before Submission

- [ ] Metadata header complete with version and reviewers
- [ ] Core tenets defined (2-3)
- [ ] All personas have JTBD and pain points
- [ ] Requirements are specific and testable
- [ ] Dependencies have owners and risk levels
- [ ] Success criteria are measurable
- [ ] Open questions categorized by priority
- [ ] Stakeholder table includes all relevant teams
