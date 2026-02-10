# Jarvis OS

[![Claude Code](https://img.shields.io/badge/Claude_Code-Compatible-blueviolet)](https://claude.ai/claude-code)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Subagents](https://img.shields.io/badge/Subagents-13-blue)]()
[![Memory](https://img.shields.io/badge/Memory-Persistent-orange)]()

**Your personal AI operating system for Product Management.**

Jarvis transforms Claude Code into an intellectual sparring partner with persistent memory, document caching, source-grounded answers, and 13 specialist AI reviewers on demand. It challenges your thinking instead of agreeing with everything, remembers across sessions, and never states facts without sources.

```
       ██╗    █████╗     ██████╗     ██╗   ██╗    ██╗    ███████╗
       ██║   ██╔══██╗    ██╔══██╗    ██║   ██║    ██║    ██╔════╝
       ██║   ███████║    ██████╔╝    ██║   ██║    ██║    ███████╗
  ██   ██║   ██╔══██║    ██╔══██╗    ╚██╗ ██╔╝    ██║    ╚════██║
  ╚█████╔╝   ██║  ██║    ██║  ██║     ╚████╔╝     ██║    ███████║
   ╚════╝    ╚═╝  ╚═╝    ╚═╝  ╚═╝      ╚═══╝      ╚═╝    ╚══════╝
```

---

## Why Jarvis?

Claude is powerful, but every conversation starts from zero. You repeat context, preferences, and past decisions. Long conversations degrade quality. Reviews require manual prompting. Jarvis fixes all of this.

| Problem | Jarvis Solution |
|---------|-----------------|
| Claude forgets everything between sessions | 3-layer persistent memory |
| Claude agrees too easily | Sparring partner mode challenges your thinking |
| Claude makes confident claims without evidence | Source-grounded answers with citations |
| Reviews require manual prompting | 13 specialist reviewers auto-invoked |
| Uploading docs burns tokens | Tiered document cache (~90-98% savings) |
| Long conversations degrade quality | Anti-context-rot architecture |
| Generic, impersonal responses | Learns your voice, preferences, and domain |
| Manual context management | Auto-loads relevant docs per project |

---

## Quick Install

### One Command

```bash
curl -sSL https://raw.githubusercontent.com/Andy-ai-git/Jarvis-PM/main/install.sh | bash
```

This will:
1. Clone Jarvis OS to `~/.claude/jarvis`
2. Create memory directories
3. Set up a minimal working profile

### After Installation

**Step 1:** Add your name (30 seconds)
```bash
open ~/.claude/jarvis/memory/user-profile.md
# Change line 5: [Your name] → Your actual name
```

**Step 2:** Activate
```
/jarvis
```

That's it. You're ready.

### Manual Installation

```bash
# Clone to Claude config directory
git clone https://github.com/Andy-ai-git/Jarvis-PM.git ~/.claude/jarvis

# Initialize memory from templates
cp ~/.claude/jarvis/templates/user-profile-template.md ~/.claude/jarvis/memory/user-profile.md
cp ~/.claude/jarvis/templates/learnings-template.md ~/.claude/jarvis/memory/learnings.md
cp ~/.claude/jarvis/templates/cross-project-template.md ~/.claude/jarvis/memory/cross-project-knowledge.md

# Add to CLAUDE.md
echo -e "\n## Jarvis OS\nSee ~/.claude/jarvis/config/jarvis-core.md for full configuration.\nQuick start: Type /jarvis to activate." >> ~/.claude/CLAUDE.md
```

---

## Core Design Principles

### 1. No Ungrounded Claims

Jarvis **never states information as fact without a verifiable source**. This is non-negotiable.

**Required behaviors:**
- Every factual claim cites a specific source (URL, document, search result)
- When no source exists: "I don't have a source for this" or "I'd need to verify"
- Assumptions explicitly marked: "This is my inference, not confirmed"
- No filling gaps with plausible-sounding information

**Prohibited behaviors:**
- Confident statements without evidence
- Extrapolating from general knowledge
- Conflating similar but different concepts
- Making up API features or capabilities

### 2. Cache-Before-Cite

Before quoting any cached document:

```
1. Call source API for current lastModified timestamp
2. Compare to cached timestamp
3. If source is newer → refresh cache first
4. Then cite with confidence
```

**Guarantee:** You never receive stale information presented as current.

### 3. Anti-Context-Rot Architecture

Long conversations accumulate noise. Jarvis stays effective through delegation:

**Jarvis does directly:**
- Clarifying questions and brainstorming
- Decision-making and trade-off analysis
- Synthesizing subagent outputs
- Coordinating parallel work

**Jarvis always delegates:**
- Large file reading (>50KB → subagent)
- Multi-file research
- Multi-source research (Notion + Drive + etc.)
- Document drafting (first drafts)
- Reviews (technical, executive, user perspective)
- Deep analysis

**Why this works:**
- Subagents operate in isolated context
- Only synthesized outputs return to Jarvis
- Raw data never pollutes the main conversation
- Quality remains high across long sessions

---

## Features

### 1. 3-Layer Persistent Memory

```
┌─────────────────────────────────────────────────────┐
│  SESSION MEMORY (Current Conversation)              │
│  Lifecycle: Single conversation                     │
│  Contents: Working context, decisions, threads      │
└─────────────────────────────────────────────────────┘
                        ↓ persists to
┌─────────────────────────────────────────────────────┐
│  PROJECT MEMORY (~/.claude/jarvis/context/[slug]/)  │
│  Lifecycle: Per-project, across sessions            │
│  Contents: Cached docs, analysis outputs, summaries │
└─────────────────────────────────────────────────────┘
                        ↓ informs
┌─────────────────────────────────────────────────────┐
│  USER MEMORY (~/.claude/jarvis/memory/)             │
│  Lifecycle: Permanent, spans all projects           │
│  Contents: Profile, learnings, daily notes          │
└─────────────────────────────────────────────────────┘
```

**Memory Write Rules:**

| Event | Persists To |
|-------|-------------|
| User corrects Jarvis | `memory/learnings.md` |
| New preference discovered | `memory/user-profile.md` |
| Cross-project fact learned | `memory/cross-project-knowledge.md` |
| Document cached (Drive) | `context/[project]/drive-docs/` |
| Document cached (Notion) | `context/[project]/notion-pages/` |
| Subagent analysis complete | `context/[project]/analysis-outputs/` |
| Session ends | `memory/daily-notes/YYYY-MM-DD.md` |

**Example:**
```
Day 1: "I prefer bullet points over paragraphs."
Day 30: Jarvis automatically uses bullet points without being told.
```

---

### 2. Intellectual Sparring Partner

Jarvis is NOT a yes-machine. It actively:

- **Challenges assumptions** — "How do we know this?"
- **Finds blind spots** — "Have you considered X?"
- **Pushes for depth** — "What's the root cause?"
- **Points out inconsistencies** — "Earlier you said Y, but now..."
- **Steelmans alternatives** — "The strongest case against this is..."
- **Asks uncomfortable questions** — The ones you might be avoiding

**Example:**
```
You: I think we should build feature X first.

Jarvis: Before I agree, let me push back:
- What evidence supports that prioritization?
- You mentioned Y has higher user demand last week
- Have you validated X solves the actual problem?
- What's the cost of being wrong here?
```

---

### 3. Source-Grounded Answers

Every factual claim either cites a source or explicitly admits uncertainty.

**Prohibited:**
```
"The API supports pagination." (no source)
```

**Required:**
```
"The API supports pagination (per docs/api-reference.md:142)"

OR

"I don't have a source for this — would you like me to search?"
```

**Source Priority:**
```
1. Check local cache (~/.claude/jarvis/context/[project]/)
2. Validate cache freshness (API metadata check)
3. Search Notion (MCP semantic search)
4. Search Google Drive (MCP document search)
5. If not found → "I don't have a source for this"
```

---

### 4. 13 Specialist Sub-Agents

Jarvis delegates specialized work to 13 subagents. Each operates in isolated context and returns structured synthesis.

| Agent | Expertise | Invoked For |
|-------|-----------|-------------|
| **Executive** | Strategic alignment, stakeholder clarity, business impact | PRFAQ reviews, strategy docs, major decisions |
| **CTO** | Architecture, build-vs-buy, platform strategy | PRD reviews, system design, technical strategy |
| **Backend Engineer** | APIs, services, data models, scalability, security | PRD technical sections, API design, data flows |
| **Frontend Engineer** | UI implementation, components, state management | PRD frontend sections, component design |
| **Data Engineer** | Pipelines, analytics infrastructure, data quality | Data architecture, pipeline design, warehousing |
| **DevOps** | Infrastructure, CI/CD, deployment, monitoring | Infrastructure sections, deployment strategy |
| **Data Analyst** | Metrics definition, experiment design, statistical rigor | Success metrics, A/B tests, measurement plans |
| **User Researcher** | User validation, pain points, jobs-to-be-done | Feature validation, user stories, research plans |
| **UX Designer** | Usability, interaction design, accessibility | UI specs, wireframe review, interaction patterns |
| **Devil's Advocate** | Find flaws, attack assumptions, stress-test logic | Pre-mortems, decision validation, risk assessment |
| **Marketer** | Positioning, GTM, messaging, differentiation | Launch plans, messaging, competitive analysis |
| **Comms** | Writing in user's voice, stakeholder updates | LinkedIn posts, blog drafts, status updates |
| **Research Papers** | AI research trends, PM-focused paper summaries | "What's new in AI?", research context for decisions |

### Auto-Delegation Triggers

When you say these phrases, Jarvis spawns subagents automatically:

| Trigger Phrase | Subagents Spawned | Output |
|----------------|-------------------|--------|
| "review this PRD" | CTO + Backend + Frontend + Data Engineer + DevOps | Multi-perspective technical review |
| "review this PRFAQ" | Executive + Marketer | Strategic + messaging review |
| "validate this feature" | User Researcher + UX Designer | User value + usability assessment |
| "review strategy" | Executive + CTO | Strategic + technical alignment |
| "pre-mortem" / "devil's advocate" | Devil's Advocate | Risk assessment, failure modes |
| "draft LinkedIn post" | Comms | Content in your voice |
| "launch plan" | Marketer + Executive | GTM + stakeholder strategy |
| "what's new in AI?" | Research Papers | PM-focused paper summaries |

### Parallel Execution

When tasks are independent, Jarvis launches multiple subagents simultaneously:

```
PRD Review (parallel):
├── CTO → architecture assessment
├── Backend Engineer → API/data review
├── Frontend Engineer → UI implementation review
├── Data Engineer → pipeline/analytics review
└── DevOps → infrastructure review

All return findings → Jarvis synthesizes → You get unified review
```

### Extended Thinking for Subagents

Use extended thinking when tasks require deeper reasoning:

| Task Type | Thinking Level | When to Use |
|-----------|----------------|-------------|
| Quick review | Default | Routine checks, simple validations |
| PRD review | `think hard` | Technical feasibility, dependency analysis |
| PRFAQ review | `think hard` | Strategic alignment, market positioning |
| Architecture decisions | `ultrathink` | Complex trade-offs, multi-system impact |
| Pre-mortem / Devil's Advocate | `ultrathink` | Finding non-obvious failure modes |
| Strategy documents | `ultrathink` | Long-term implications, competitive dynamics |

---

### 5. Tiered Document Cache

| Level | Content | Tokens | When Used |
|-------|---------|--------|-----------|
| **0** | Metadata only (title, dates, author) | ~50 | Quick lookups, existence checks |
| **1** | Key facts summary (~500 words) | ~500 | Most questions (default) |
| **2** | Full document | ~16K | Deep analysis, comprehensive review |

**Cache Operations:**
```
Lazy Discovery:
1. User asks about topic not in cache
2. Jarvis searches Drive/Notion for keywords
3. Peeks at first 1,000 chars (previewOnly=true)
4. Caches relevant section at Level 1
5. Answers with citation

Proactive Caching (Drive + Notion):
1. Project has .jarvis.md with Critical Documents AND Key Notion Pages
2. On /jarvis activation, fetch each from both sources
3. Store at Level 1:
   - Drive docs → context/[project]/drive-docs/
   - Notion pages → context/[project]/notion-pages/
4. Ready for instant retrieval with unified search
```

**Auto-Cleanup Policy:**

| Location | Retention | Action |
|----------|-----------|--------|
| `analysis-outputs/` | 90 days | Auto-delete older files |
| `daily-notes/` | 30 days active | Archive to `daily-notes/archive/` |
| `drive-docs/` | Indefinite | Validated on cite |
| `notion-pages/` | Indefinite | Validated on cite |

---

### 6. Steering Wheel (Output Tuning)

Fine-tune Jarvis's output style across 6 dimensions:

| Dimension | Left ← → Right |
|-----------|----------------|
| Certainty | Exploratory ↔ Definitive |
| Originality | Novel ↔ Proven |
| Grounding | Abstract ↔ Concrete |
| Risk | Bold ↔ Safe |
| Scope | Expansive ↔ Focused |
| Style | Compelling ↔ Clear |

**Presets:** `Brainstorm`, `Final Draft`, `Strategy`, `Execution`

**Usage:** "Set steering wheel to Brainstorm" or "More bold, less safe"

---

### 7. Skill-Based Methodology

Jarvis uses skills to ensure document consistency:

| Skill | Template |
|-------|----------|
| `prfaq-writing` | Amazon-style PR/FAQ format |
| `prd-writing` | Structured PRD with Core Tenets |
| `strategy-doc` | Rumelt's Strategy Kernel |
| `stakeholder-update` | TL;DR + Progress + Blockers |

---

### 8. Session Event Logging

Jarvis automatically logs structured events during your session:

- **Decisions** — Detected from "decided", "agreed", "we'll go with"
- **Blockers** — Detected from "blocked", "waiting on", "need input"
- **Actions** — Detected from "next", "tomorrow", "action item"
- **Learnings** — Detected from corrections and new insights

Events are stored in JSONL format with timestamps, queryable via:
- `jarvis events` — Last 7 days
- `jarvis blockers` — Active blockers
- `jarvis actions` — Pending actions

---

### 9. MCP Integrations (Optional)

Connect external services for deeper integration:

| Integration | Capabilities |
|-------------|--------------|
| **Notion** | Search workspace, fetch/update pages, query databases |
| **Google Drive** | Fetch docs/sheets/slides, search, cache |
| **Gmail** | Search messages, read threads, draft emails |
| **Playwright** | Browser automation, screenshots, testing |

**Setup:** Configure globally in `~/.claude/settings.json`:

```json
{
  "mcpServers": {
    "google-drive": {
      "type": "http",
      "url": "https://api.anthropic.com/mcp/gdrive/mcp"
    },
    "gmail": {
      "type": "http",
      "url": "https://gmail.mcp.claude.com/mcp"
    },
    "notion": {
      "type": "http",
      "url": "https://mcp.notion.com/mcp"
    },
    "playwright": {
      "command": "npx",
      "args": ["-y", "@executeautomation/playwright-mcp-server"]
    }
  }
}
```

MCP setup is optional — Jarvis works great standalone.

---

## Usage

### Activation

```
/jarvis
```

Jarvis loads your memory, detects your project, and reports status:
```
       ██╗    █████╗     ██████╗     ██╗   ██╗    ██╗    ███████╗
       ██║   ██╔══██╗    ██╔══██╗    ██║   ██║    ██║    ██╔════╝
       ██║   ███████║    ██████╔╝    ██║   ██║    ██║    ███████╗
  ██   ██║   ██╔══██║    ██╔══██╗    ╚██╗ ██╔╝    ██║    ╚════██║
  ╚█████╔╝   ██║  ██║    ██║  ██║     ╚████╔╝     ██║    ███████║
   ╚════╝    ╚═╝  ╚═╝    ╚═╝  ╚═╝      ╚═══╝      ╚═╝    ╚══════╝

✓ Ready for [Project Name]

Context loaded:
• 3 critical documents cached
• User memory loaded (profile, learnings, daily notes)
• MCP integrations active (Drive, Notion, Gmail, Playwright)

Ground truth priority: Cache → Notion → Drive → "I don't know"
```

### Commands

| Command | Action |
|---------|--------|
| `/jarvis` | Initialize/re-initialize (runs auto-cleanup) |
| `jarvis status` | Show cache contents and freshness |
| `jarvis memory` | Show user memory contents |
| `jarvis learn [fact]` | Add to learnings.md |
| `jarvis events` | Show recent decisions, blockers, actions (last 7 days) |
| `jarvis blockers` | Show active blockers |
| `jarvis actions` | Show pending actions |
| `jarvis log [type]: [text]` | Manually log an event |
| `refresh cache for [doc]` | Re-fetch specific document |
| `jarvis clear cache` | Clear project cache |
| `jarvis projects` | List all projects with context |
| `jarvis cleanup` | Run retention policy manually |
| `jarvis cleanup --dry-run` | Preview what would be cleaned |
| `summarize session` | Auto-generate session summary |

### Project Configuration

Create `.jarvis.md` in your project root for automatic context loading:

```markdown
# Project: My Project

## Critical Documents (Auto-cache on /jarvis)
| Document | Drive ID |
|----------|----------|
| PRD | 1abc123def456... |
| PRFAQ | 1ghi789jkl012... |
| Dependencies | 1mno345pqr678... |

## Key Notion Pages
| Page | URL |
|------|-----|
| Wiki | https://notion.so/... |
| Roadmap | https://notion.so/... |

## Project Context
Brief description for Jarvis context. Key stakeholders,
strategic goals, current phase, known constraints...
```

---

## Example Interactions

### Brainstorming (Jarvis Direct)
```
You: I'm thinking about adding a notification system.

Jarvis: Before we dive in — what problem are you solving?
        - Is this user-requested or assumed need?
        - What's the cost of NOT having notifications?
        - Have you considered alternatives like email digests?
```

### PRD Review (Auto-Delegation)
```
You: Review this PRD.

Jarvis: Delegating to Engineering Team...

[CTO]: Architecture concern — this creates tight coupling between...
[Backend]: API design issue — the proposed endpoint doesn't handle...
[Frontend]: UI complexity — the notification center adds 3 new states...
[DevOps]: Infrastructure note — real-time requires WebSocket infra...

Jarvis: Key themes from review:
1. Coupling risk (CTO) — consider event-driven approach
2. API gap (Backend) — missing pagination for history
3. State complexity (Frontend) — propose simpler MVP
```

### Document Caching
```
You: I need to reference the competitor analysis frequently.

Jarvis: Fetching from Google Drive...
        Cached to ~/.claude/jarvis/context/product-x/competitor-analysis.md

        Summary: 12-page analysis covering Competitor A, B, C.
        Key insight: Competitor B launching similar feature Q2.

        Future references will use cache (saves ~8K tokens/use).
```

### Devil's Advocate
```
You: I'm confident we should proceed with Option A.

Jarvis: [Spawning Devil's Advocate]

Devil's Advocate:
- Why hasn't Competitor X tried this approach? What do they know?
- Your timeline assumes zero dependencies slip — what's the P90?
- Pre-mortem: 12 months from now, this failed because...
  1. The market shifted to Y before launch
  2. Team bandwidth was overcommitted
  3. Key assumption about user behavior was wrong

Verdict: PROCEED WITH CAUTION
- Assumptions #2 and #3 need validation before committing resources
```

---

## Directory Structure

```
~/.claude/jarvis/
├── memory/                          # USER LEVEL (permanent, private)
│   ├── user-profile.md             # Preferences, writing style, frameworks
│   ├── learnings.md                # Patterns, corrections, effective approaches
│   ├── cross-project-knowledge.md  # Company context, stakeholders, strategy
│   ├── daily-notes/                # Session continuity
│   │   └── YYYY-MM-DD.md          # ~500 tokens each, last 3 days loaded
│   ├── session-log-archive/        # Archived session logs
│   └── index.md                    # Memory architecture documentation
│
├── context/                         # PROJECT LEVEL (per-project, private)
│   ├── index.json                  # Registry of all projects
│   └── [project-slug]/
│       ├── session-summary.md      # Last session state
│       ├── drive-docs/             # Cached Google Drive documents
│       ├── notion-pages/           # Cached Notion pages
│       └── analysis-outputs/       # Subagent outputs (persisted)
│
├── subagents/                       # Specialist agent definitions (public)
│   ├── executive/SKILL.md
│   ├── cto/SKILL.md
│   ├── backend-engineer/SKILL.md
│   ├── frontend-engineer/SKILL.md
│   ├── data-engineer/SKILL.md
│   ├── devops/SKILL.md
│   ├── data-analyst/SKILL.md
│   ├── user-researcher/SKILL.md
│   ├── ux-designer/SKILL.md
│   ├── devils-advocate/SKILL.md
│   ├── marketer/SKILL.md
│   ├── comms/SKILL.md
│   └── research-papers/             # AI research trends
│       ├── SKILL.md
│       └── fetch-papers.sh          # arxiv + Semantic Scholar fetcher
│
├── templates/                       # Reusable templates (public)
│   ├── user-profile-template.md
│   ├── learnings-template.md
│   ├── cross-project-template.md
│   ├── jarvis-project-template.md
│   ├── task-brief-prd-review.md
│   ├── task-brief-prfaq-review.md
│   └── task-brief-multi-perspective.md
│
├── config/jarvis-core.md            # Core configuration
├── skill/
│   ├── SKILL.md                     # /jarvis activation skill
│   └── steering-wheel.md           # Output tuning system
├── comms/                           # Documentation and examples
├── cache/                           # Temporary cache storage
├── JARVIS-GUIDE.md                  # Detailed user guide
└── README.md                        # This file
```

---

## Token Efficiency

| Scenario | Without Jarvis | With Jarvis | Savings |
|----------|----------------|-------------|---------|
| 3 critical docs (160KB) | ~40,000 tokens | ~1,500 tokens | **96%** |
| 10 questions about docs | ~185,000 tokens | ~3,500 tokens | **98%** |
| PRD review (5 perspectives) | Serial context growth | Parallel, isolated | **~80%** |

---

## Customization

Start minimal, expand over time. The default profile works immediately.

**Minimal (default):**
```markdown
## Identity
- Name: Alex
- Role: Product Manager

## Communication
- Default: Brief and direct

## Preferences
- Challenge my assumptions
- Say "I don't know" when uncertain
```

**Full profile options:** See [Customization Guide](docs/CUSTOMIZATION.md)

### Adding Custom Subagents

```bash
mkdir ~/.claude/jarvis/subagents/my-agent
```

Create `SKILL.md` with:
```markdown
# [Agent Name]

## Purpose
What this agent specializes in.

## When to Invoke
Trigger phrases and scenarios.

## Review Framework
How the agent approaches analysis.

## Checklist
Specific items to evaluate.

## Output Template
Required structure for responses.

## Risk Rating Criteria
How to assess severity.
```

---

## Documentation

| Guide | Purpose |
|-------|---------|
| [Quick Start](QUICK-START.md) | 5-minute setup guide |
| [Jarvis Guide](JARVIS-GUIDE.md) | Comprehensive user guide |
| [Skill Registration](docs/SKILL-REGISTRATION.md) | How Claude Code discovers Jarvis |
| [Customization](docs/CUSTOMIZATION.md) | Expand your profile over time |
| [Troubleshooting](docs/TROUBLESHOOTING.md) | Common issues and fixes |

---

## Requirements

- [Claude Code](https://claude.ai/claude-code) CLI (Opus model recommended)
- Git
- macOS or Linux (Windows WSL works too)
- (Optional) MCP servers: Google Drive, Notion, Gmail, Playwright

---

## Contributing

Contributions welcome:
- New subagent definitions
- Template improvements
- MCP integration patterns
- Documentation

For major changes, open an issue first to discuss.

---

## License

MIT License — see [LICENSE](LICENSE)

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 2.3 | 2026-02-03 | Research Papers subagent (13 total), AI trends on demand |
| 2.2 | 2026-01-23 | Notion caching, auto-cleanup policy, session summary auto-generation |
| 2.1 | 2026-01-23 | 12 subagents, explicit grounding rules, anti-context-rot docs |
| 2.0 | 2026-01-20 | 3-layer memory, tiered cache, auto-delegation |
| 1.0 | 2026-01-14 | Initial release |

---

*Built with Jarvis OS*
