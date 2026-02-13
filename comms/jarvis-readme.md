# Jarvis OS - Implementation Summary

**Version:** 2.1
**Date:** 2026-01-23
**Author:** Jarvis (with Andrey)

---

## Overview

Jarvis OS is a personal PM operating system that provides:
- **3-layer persistent memory** (user → project → session)
- **Proactive document caching** with tiered storage
- **Auto-delegation** to specialist subagents
- **Source-grounded answers** with citation requirements

---

## Architecture

### 3-Layer Memory System

```
┌─────────────────────────────────────────────────────┐
│  SESSION MEMORY (Conversation Context)              │
│  Lifecycle: Single conversation                     │
└─────────────────────────────────────────────────────┘
                        ↓ persists to
┌─────────────────────────────────────────────────────┐
│  PROJECT MEMORY (~/.claude/jarvis/context/[slug]/)  │
│  Lifecycle: Per-project, persists across sessions   │
└─────────────────────────────────────────────────────┘
                        ↓ informs
┌─────────────────────────────────────────────────────┐
│  USER MEMORY (~/.claude/jarvis/memory/)             │
│  Lifecycle: Permanent, spans all projects           │
└─────────────────────────────────────────────────────┘
```

### Tiered Cache System

| Level | Content | Tokens | Use Case |
|-------|---------|--------|----------|
| **Level 0** | Metadata only | ~50 | Quick lookups (title, date, size) |
| **Level 1** | Key facts summary | ~500 | Most questions answered here |
| **Level 2** | Full document | ~16,000 | Deep analysis, specific quotes |

**Token Savings:** ~90% vs loading full documents

---

## Directory Structure

```
~/.claude/jarvis/
├── memory/                          # USER LEVEL (permanent)
│   ├── user-profile.md             # Preferences, writing style, frameworks
│   ├── learnings.md                # Decision patterns, corrections
│   ├── cross-project-knowledge.md  # Company context, stakeholders
│   └── daily-notes/                # Session summaries (last 3 days loaded)
│       └── YYYY-MM-DD.md           # ~50 lines max per note
│
├── context/                         # PROJECT LEVEL
│   ├── index.json                  # Registry + metrics
│   └── [project-slug]/
│       ├── session-summary.md      # Current session state
│       ├── drive-docs/             # Cached documents (Level 1)
│       ├── notion-pages/           # Cached Notion pages
│       └── analysis-outputs/       # Subagent review outputs
│
├── subagents/                       # SPECIALIST AGENTS (12 total)
│   ├── executive/SKILL.md          # Strategic alignment
│   ├── cto/SKILL.md                # Architecture, platform strategy
│   ├── backend-engineer/SKILL.md   # APIs, services
│   ├── frontend-engineer/SKILL.md  # UI implementation
│   ├── data-engineer/SKILL.md      # Pipelines, analytics
│   ├── devops/SKILL.md             # Infrastructure, CI/CD
│   ├── user-researcher/SKILL.md    # User validation
│   ├── ux-designer/SKILL.md        # Usability, interaction
│   ├── data-analyst/SKILL.md       # Metrics, experiments
│   ├── devils-advocate/SKILL.md    # Find flaws, attack assumptions
│   ├── marketer/SKILL.md           # Positioning, GTM
│   └── comms/SKILL.md              # Writing, updates
│
├── templates/                       # TASK BRIEFS
│   ├── task-brief-prd-review.md
│   ├── task-brief-prfaq-review.md
│   ├── task-brief-multi-perspective.md
│   └── jarvis-project-template.md
│
├── skill/SKILL.md                   # /jarvis activation skill
├── comms/                           # Documentation
│   └── jarvis-readme.md            # This file
└── JARVIS-GUIDE.md                  # User guide
```

---

## Changes Made (2026-01-20)

### Phase 1: Foundation

#### User Memory Populated
- **user-profile.md** - 137 lines of preferences, writing style, frameworks
  - Communication preferences (brevity, directness, sparring partner mode)
  - Writing style (formal vs casual, voice characteristics)
  - Decision-making patterns
  - Strategic frameworks (Rumelt's Strategy Kernel)
  - Terminology preferences

- **learnings.md** - Decision patterns and correction log
  - How Andrey approaches problems
  - Red flags that trigger pushback
  - Preferences discovered
  - Effective approaches to replicate
  - Anti-patterns to avoid

- **cross-project-knowledge.md** - Company context
  - What the company does (core business)
  - Strategic themes (data flywheel, deployment modes)
  - Industry metrics (AHT, FCR, CSAT)
  - Active projects (Smart Assistant, Platform Migration)
  - Key stakeholders

#### Subagent Skill Files Created
- **engineer/SKILL.md** - Technical feasibility reviews
  - Review framework
  - Checklists by document type
  - Risk assessment ratings
  - Output template
  - Acceptance criteria

- **executive/SKILL.md** - Strategic alignment reviews
  - Strategic alignment assessment
  - Stakeholder lens analysis
  - Clarity scoring
  - Gap identification
  - Output template

- **user-researcher/SKILL.md** - User value validation
  - Pain point validation
  - Solution fit assessment
  - Adoption risk analysis
  - Validation evidence ratings
  - Output template

#### Task Brief Templates
- **task-brief-prd-review.md**
- **task-brief-prfaq-review.md**
- **task-brief-multi-perspective.md**

#### Project Configuration
- Created `.jarvis.md` in Smart Assistant project
- Registered 3 critical documents with Drive IDs

### Phase 2: Proactive Caching

#### Tiered Cache Implementation
- Fetched 3 critical documents from Google Drive
- Created Level 1 summaries with metadata and key facts:
  - `agent-copilot-prfaq.md`
  - `platform-migration-prd.md`
  - `migration-dependencies.md`

#### Cache Index Updated
- `index.json` now tracks cache levels and metrics
- Accurate representation of cache state (was lying before)
- Added metrics schema for tracking hits/misses

#### SKILL.md Updated
- Added proactive caching flow (Step 5)
- Added tiered cache levels documentation
- Updated Ground Truth flow with hydration pattern
- Added token savings estimates

### Phase 2.5: Daily Notes

#### User-Level Session Memory
- Created `~/.claude/jarvis/memory/daily-notes/` directory
- Daily notes stored at USER level (cross-project)
- Format: `YYYY-MM-DD.md`

#### Activation Flow Updated
- Load last 3 days of daily notes on `/jarvis` init (context efficient)
- Provides session continuity across conversations

#### New Command
- `add today's notes` - Write/update daily session summary
- Auto-writes key accomplishments, decisions, open items

---

## Key Features

### Auto-Delegation

Trigger phrases automatically spawn subagents:

| User Says | Subagents Spawned |
|-----------|-------------------|
| "review PRD" | CTO + Backend + Frontend + Data + DevOps |
| "review PRFAQ" | Executive + Marketer |
| "validate feature" | User Researcher + UX Designer |
| "review strategy" | Executive + CTO |
| "pre-mortem" / "devil's advocate" | Devil's Advocate |
| "write post" / "draft update" | Comms |

### Ground Truth Priority

1. Check Level 1 cache (summaries)
2. **Validate freshness** (see below)
3. Hydrate to Level 2 if needed (full doc)
4. Search Notion (exact → semantic)
5. Search Drive
6. Admit "I don't have a source"

### Cache Freshness Validation (Validate-Before-Cite)

**Problem:** Cached docs can become stale if updated in Drive between sessions.

**Solution:** Before citing any cached document, validate it's still current.

**Flow:**
```
About to cite cached doc
         ↓
Call Drive API: get file metadata (modifiedTime only)
         ↓
Compare: cached lastModified vs current modifiedTime
         ↓
Same? → Use cache
         ↓
Different? → Refresh cache first → Then cite fresh data
```

**Why this works:**
- Metadata call is cheap (~50ms, ~100 tokens)
- Full doc fetch only when actually stale
- **Guarantees we NEVER cite outdated information**
- User doesn't need to remember to refresh

**When to validate:**
- ALWAYS before citing a cached doc in an answer
- NOT needed for quick metadata lookups (title, size)
- NOT needed during brainstorming (no factual claims being made)

**Implementation note:** This is "Option C" freshness — validate on reference, not on session start. More efficient than TTL-based expiration, more reliable than user-triggered refresh.

### Acceptance Criteria for Subagents

**Accept when:**
- All claims have section references
- Concerns are risk-rated
- Recommendations are actionable
- Output is structured

**Resume when:**
- Too vague
- Missing references
- No risk ratings
- Abstract recommendations

**Circuit breaker:** 3 resume attempts, then escalate

---

## Maintenance Commands

| Command | Action |
|---------|--------|
| `/jarvis` | Initialize for current project |
| `jarvis status` | Show cache and metrics |
| `jarvis memory` | Show user memory |
| `jarvis learn [fact]` | Add to learnings |
| `add today's notes` | Write daily session summary |
| `refresh cache for [doc]` | Re-fetch document |
| `jarvis clear cache` | Clear project cache |

---

## Daily Notes (Session Continuity)

Daily notes provide cross-session memory at the user level.

### How It Works
- **On init:** Load last 3 days only (context efficient)
- **On "add today's notes":** Write/update current day's summary
- **Retention:** Keep 30 days, auto-prune older
- **Max size:** ~50 lines per note to minimize context load

### Format
```markdown
# Daily Notes - YYYY-MM-DD

## Session Summary
### What We Worked On
- [Key accomplishments]
- [Decisions made]

### Project: [Name]
- [Project-specific context]

### Open Items
- [Pending tasks]
```

### Location
`~/.claude/jarvis/memory/daily-notes/YYYY-MM-DD.md`

---

## Token Efficiency

### Before Jarvis
- Upload 64KB doc: 16,000 tokens
- 10 questions: 185,000 tokens
- No persistence across sessions

### With Jarvis
- Level 1 cache: ~500 tokens per doc
- 10 questions: ~5,000 tokens
- Persistent across sessions
- **~97% reduction**

### Current Project Cache
- 3 documents cached (Level 1)
- Full docs: ~163KB (~40,000 tokens)
- Summaries: ~15KB (~3,750 tokens)
- **Savings: ~90%**

---

## Next Steps (Future)

### Phase 3: Observability
- [ ] Context health monitoring (token budget tracking)
- [ ] Cache hit/miss metrics instrumentation
- [ ] Session-end summary automation
- [ ] Alert thresholds (75%, 90% budget)

### Phase 4: Advanced Patterns
- [ ] Cross-subagent synthesis (merge findings)
- [ ] Conflict detection (where agents disagree)
- [ ] Automatic Level 1 enrichment from questions
- [ ] Notion page caching

---

## File References

| Purpose | Location |
|---------|----------|
| Global config | `~/.claude/CLAUDE.md` |
| Activation skill | `~/.claude/jarvis/skill/SKILL.md` |
| User memory | `~/.claude/jarvis/memory/` |
| Project context | `~/.claude/jarvis/context/[slug]/` |
| Subagent skills | `~/.claude/jarvis/subagents/` |
| Templates | `~/.claude/jarvis/templates/` |
| This doc | `~/.claude/jarvis/comms/jarvis-readme.md` |

---

*Generated by Jarvis OS v2.1*
