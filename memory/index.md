# Jarvis Memory Architecture

## 3-Layer Memory System

```
┌─────────────────────────────────────────────────────┐
│  SESSION MEMORY (Conversation Context)              │
│  - Current task state                               │
│  - Working decisions                                │
│  - Temporary reasoning                              │
│  Lifecycle: Single conversation                     │
└─────────────────────────────────────────────────────┘
                        ↓ persists to
┌─────────────────────────────────────────────────────┐
│  PROJECT MEMORY (~/.claude/jarvis/context/[slug]/)  │
│  - Cached documents (drive-docs/, notion-pages/)    │
│  - Analysis outputs from subagents                  │
│  - Session summaries                                │
│  - Project-specific facts                           │
│  Lifecycle: Per-project, persists across sessions   │
└─────────────────────────────────────────────────────┘
                        ↓ informs
┌─────────────────────────────────────────────────────┐
│  USER MEMORY (~/.claude/jarvis/memory/)             │
│  - user-profile.md: Identity, preferences, style    │
│  - learnings.md: Corrections, patterns, insights    │
│  - cross-project-knowledge.md: Global facts         │
│  Lifecycle: Permanent, spans all projects           │
└─────────────────────────────────────────────────────┘
```

## Load Order on /jarvis Init

1. **User memory** (always) → `~/.claude/jarvis/memory/`
   - user-profile.md
   - learnings.md
   - cross-project-knowledge.md
   - daily-notes/ (last 3 days only)
2. **Project memory** (if exists) → `~/.claude/jarvis/context/[project-slug]/`
3. **Session starts fresh** → conversation begins

## Write Rules

| Event | Write To |
|-------|----------|
| User corrects Jarvis | learnings.md |
| New preference discovered | user-profile.md |
| Cross-project fact learned | cross-project-knowledge.md |
| **Session ends / "add today's notes"** | **daily-notes/YYYY-MM-DD.md** |
| Document cached | project/drive-docs/ |
| Analysis completed | project/analysis-outputs/ |
| Project session state | project/session-summary.md |

## Memory Files

```
~/.claude/jarvis/
├── memory/                          # USER LEVEL (permanent)
│   ├── index.md                    # This file
│   ├── user-profile.md             # Identity, preferences
│   ├── learnings.md                # Corrections, patterns
│   ├── cross-project-knowledge.md  # Global facts
│   └── daily-notes/                # Session continuity
│       └── YYYY-MM-DD.md           # ~50 lines max, last 3 days loaded
│
├── context/                         # PROJECT LEVEL
│   ├── index.json                  # Registry + metrics
│   └── [project-slug]/
│       ├── session-summary.md
│       ├── drive-docs/             # Level 1 cache
│       ├── notion-pages/
│       └── analysis-outputs/
│
├── subagents/                       # Skill definitions
│   ├── engineer/SKILL.md
│   ├── executive/SKILL.md
│   └── user-researcher/SKILL.md
│
└── templates/                       # Task briefs
    └── jarvis-project-template.md
```

## When to Update User Memory

- **user-profile.md**: When explicit preferences change
- **learnings.md**: When corrected or when pattern emerges
- **cross-project-knowledge.md**: When fact applies beyond current project
- **daily-notes/**: At session end or on `add today's notes` command

## Daily Notes

**Purpose:** Cross-session continuity at user level (not project-specific)

**Load:** Last 3 days on `/jarvis` init (~150 tokens × 3 = ~450 tokens)

**Write:** `add today's notes` or auto at session end

**Format:**
```markdown
# Daily Notes - YYYY-MM-DD

## What We Built/Worked On
- [Key accomplishments]

## Project: [Name]
- [Context]

## Decisions Made
- [Key decisions]

## Open Items
- [Follow-ups]
```

**Retention:** Keep 30 days, auto-prune older
