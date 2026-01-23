# Jarvis OS

**Your personal PM operating system for Claude Code.**

Jarvis transforms Claude into an intellectual sparring partner with persistent memory, source-grounded answers, and specialist reviewers on demand.

---

## Why Jarvis?

Claude is powerful, but every conversation starts from zero. You repeat context, preferences, and past decisions. Jarvis fixes this.

| Problem | Jarvis Solution |
|---------|-----------------|
| Claude forgets everything between sessions | Persistent memory across all conversations |
| Claude agrees too easily | Sparring partner mode challenges your thinking |
| Claude makes confident claims without evidence | Source-grounded answers with citations |
| Reviews require manual prompting | 12 specialist reviewers auto-invoked |
| Large docs consume tokens | Document caching (90% savings) |
| Generic responses | Learns your voice, preferences, domain |

---

## Features

### 1. Persistent Memory

Jarvis remembers across sessions:

```
~/.claude/jarvis/memory/
├── user-profile.md          # Your identity, preferences, communication style
├── learnings.md             # Corrections and patterns Jarvis learned
├── cross-project-knowledge.md  # Facts that apply everywhere
└── daily-notes/             # Session summaries
```

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

---

### 4. Specialist Reviewers (12 Sub-Agents)

Jarvis automatically delegates to specialists based on task type:

| Specialist | Auto-Invoked For |
|------------|------------------|
| **CTO** | Architecture decisions, technical strategy |
| **Backend Engineer** | APIs, services, data models |
| **Frontend Engineer** | UI implementation, components |
| **Data Engineer** | Pipelines, analytics, schemas |
| **DevOps** | Infrastructure, CI/CD, deployment |
| **Data Analyst** | Metrics, experiments, dashboards |
| **User Researcher** | User validation, research synthesis |
| **UX Designer** | Usability, flows, interaction design |
| **Executive** | Stakeholder alignment, strategy |
| **Marketer** | Positioning, launches, messaging |
| **Devil's Advocate** | Destruction testing, risk finding |
| **Comms** | Writing in your voice, updates |

**Example:**
```
You: Review this PRD for technical feasibility.

Jarvis: [Delegates to Engineering Team]
        → CTO: Strategic architecture review
        → Backend: API and data model assessment
        → Frontend: UI implementation concerns
        → DevOps: Infrastructure requirements

        [Returns consolidated feedback]
```

---

### 5. Document Caching

Frequently-used docs are cached locally, saving 90%+ tokens.

```
You: I'll be referencing the Q4 roadmap a lot.

Jarvis: [Fetches from Notion/Drive]
        [Caches to ~/.claude/jarvis/context/project-name/]
        Done. Future references use cache.
```

**Commands:**
- `jarvis status` — Show cached docs
- `refresh cache for [doc]` — Re-fetch specific document
- `jarvis clear cache` — Clear project cache

---

### 6. Skill-Based Methodology

Jarvis uses skills to ensure consistency:

| Skill | Template |
|-------|----------|
| `prfaq-writing` | Amazon-style PR/FAQ format |
| `prd-writing` | Structured PRD with Core Tenets |
| `strategy-doc` | Rumelt's Strategy Kernel |
| `stakeholder-update` | TL;DR + Progress + Blockers |

---

### 7. MCP Integrations (Optional)

Connect external services for deeper integration:

| Integration | Capabilities |
|-------------|--------------|
| **Notion** | Search workspace, fetch/update pages, query databases |
| **Google Drive** | Fetch docs/sheets/slides, search, cache |
| **Gmail** | Search messages, read threads, draft emails |
| **Playwright** | Browser automation, screenshots, testing |

MCP setup is optional — Jarvis works great standalone.

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

---

## How It Works

### Activation Flow

```
You type: /jarvis

Jarvis:
1. Detects current project (git root or cwd)
2. Loads user memory (profile, learnings)
3. Loads project context (cached docs)
4. Reports status
5. Enters sparring partner mode
```

### Memory Architecture

```
~/.claude/jarvis/
├── skill/                   # Jarvis activation logic
├── subagents/               # 12 specialist definitions
├── templates/               # Full profile templates
│
├── memory/                  # USER LEVEL (permanent)
│   ├── user-profile.md     # Identity, preferences
│   ├── learnings.md        # Corrections, patterns
│   ├── cross-project-knowledge.md
│   └── daily-notes/
│
└── context/                 # PROJECT LEVEL (per-project)
    └── [project-slug]/
        ├── session-summary.md
        ├── cached-docs/
        └── analysis-outputs/
```

### Delegation Logic

Jarvis stays thin — sub-agents do heavy lifting:

| Task | Jarvis Does | Sub-Agent Does |
|------|-------------|----------------|
| PRD Review | Coordinates, synthesizes | CTO + Backend + Frontend analyze |
| Large file analysis | Delegates | Sub-agent reads, summarizes |
| Research | Assigns scope | Explore agent searches |
| Document drafting | Reviews, approves | Specialist writes first draft |

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

---

## Documentation

| Guide | Purpose |
|-------|---------|
| [Quick Start](QUICK-START.md) | 5-minute setup guide |
| [Skill Registration](docs/SKILL-REGISTRATION.md) | How Claude Code discovers Jarvis |
| [Customization](docs/CUSTOMIZATION.md) | Expand your profile over time |
| [Troubleshooting](docs/TROUBLESHOOTING.md) | Common issues and fixes |

---

## Requirements

- [Claude Code](https://claude.ai/claude-code) (Anthropic's official CLI)
- Git
- macOS or Linux (Windows WSL works too)

---

## Commands Reference

| Command | Action |
|---------|--------|
| `/jarvis` | Activate Jarvis |
| `jarvis status` | Show loaded context, cached docs |
| `jarvis memory` | Show user-level memory contents |
| `jarvis learn [fact]` | Add to learnings.md |
| `refresh cache for [doc]` | Re-fetch specific document |
| `jarvis clear cache` | Clear current project cache |

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

---

## License

MIT License — see [LICENSE](LICENSE)

---

## Contributing

Issues and PRs welcome. For major changes, open an issue first to discuss.
