# Jarvis OS - User Guide
**Version:** 3.0
**Updated:** 2026-02-13

## Quick Start

```
/jarvis
```

That's it. Jarvis loads your memory, detects your project, caches critical docs, and is ready.

---

## What Jarvis Does

| Capability | How It Works |
|------------|--------------|
| **Knows you** | Loads user-profile, learnings, preferences |
| **Remembers sessions** | Daily notes (last 3 days) |
| **Knows your projects** | Per-project cache with critical docs |
| **Grounded answers** | Every claim cites a source |
| **Auto-delegates** | "Review PRD" → spawns Engineer + Executive + User Researcher |
| **Saves tokens** | Tiered cache (~90% reduction) |

---

## 3-Layer Memory

```
┌─────────────────────────────────────────────┐
│  SESSION (This Conversation)                │
│  Current task, working decisions            │
└─────────────────────────────────────────────┘
                    ↓ persists to
┌─────────────────────────────────────────────┐
│  PROJECT (~/.claude/jarvis/context/[slug]/) │
│  Cached docs, subagent outputs              │
└─────────────────────────────────────────────┘
                    ↓ informs
┌─────────────────────────────────────────────┐
│  USER (~/.claude/jarvis/memory/)            │
│  Profile, learnings, daily notes            │
└─────────────────────────────────────────────┘
```

**On `/jarvis`:**
1. Load user memory (profile, learnings, last 3 daily notes)
2. Detect project from directory
3. Load project cache
4. Fetch any stale/missing critical docs
5. Report status

---

## Commands

| Command | Action |
|---------|--------|
| `/jarvis` | Initialize/re-initialize |
| `jarvis status` | Show cache, metrics |
| `jarvis memory` | Show user memory |
| `jarvis learn [fact]` | Add to learnings |
| `add today's notes` | Write daily summary |
| `refresh cache for [doc]` | Re-fetch document |
| `jarvis clear cache` | Clear project cache |

---

## Auto-Delegation

Say these phrases and Jarvis spawns subagents automatically:

| Trigger | Subagents |
|---------|-----------|
| "review PRD" | CTO + Backend + Frontend + Data + DevOps |
| "review PRFAQ" | Executive + Marketer |
| "validate feature" | User Researcher + UX Designer |
| "review strategy" | Executive + CTO |
| "pre-mortem" | Devil's Advocate |
| "write post/update" | Comms |
| "assess this prompt" | Prompt Assessor |

### Subagent Focus Areas (14 Specialists)

| Agent | Focus |
|-------|-------|
| **Executive** | Strategic alignment, stakeholder clarity |
| **CTO** | Architecture, build-vs-buy, platform |
| **Backend Engineer** | APIs, services, data models |
| **Frontend Engineer** | UI implementation, components |
| **Data Engineer** | Pipelines, analytics infrastructure |
| **DevOps** | Infrastructure, CI/CD, deployment |
| **User Researcher** | User value, adoption, validation |
| **UX Designer** | Usability, interaction patterns |
| **Data Analyst** | Metrics, experiment design |
| **Devil's Advocate** | Find flaws, attack assumptions |
| **Marketer** | Positioning, GTM, launch |
| **Comms** | Writing in your voice, updates |
| **Research Papers** | AI research trends, paper summaries |
| **Prompt Assessor** | Prompt analysis, anti-pattern detection |

---

## Tiered Cache

| Level | Content | Tokens | When |
|-------|---------|--------|------|
| **0** | Metadata | ~50 | Quick lookups |
| **1** | Summary | ~500 | Most questions |
| **2** | Full doc | ~16K | Deep analysis |

**Default:** Level 1 summaries (90% token savings)
**Hydration:** Auto-fetches Level 2 when Level 1 insufficient

---

## Project Configuration

Create `.jarvis.md` in project root (optional):

```markdown
# Project: My Project

## Critical Documents
| Document | Drive ID |
|----------|----------|
| PRD | 1abc123... |
| PRFAQ | 1def456... |

## Context
Brief description...
```

Jarvis auto-caches these on init.

---

## Ground Truth Priority

1. **Check cache** → Level 1 summaries
2. **Validate freshness** → Check source `lastModified` before citing
3. **Hydrate** → Level 2 if needed
4. **Search Notion** → Exact then semantic
5. **Search Drive** → MCP search
6. **Admit ignorance** → "I don't have a source"

### Auto-Validation (Validate-Before-Cite)

Before citing any cached doc, Jarvis automatically:
1. Checks current `modifiedTime` from Drive (~50ms)
2. Compares to cached `lastModified`
3. Refreshes if stale, then cites

**You'll never get outdated information from cache.**

**Jarvis NEVER makes claims without sources.**
**Jarvis NEVER cites stale data without validation.**

---

## Directory Structure

```
~/.claude/jarvis/
├── memory/                     # USER (permanent)
│   ├── user-profile.md        # Preferences, style
│   ├── learnings.md           # Patterns, corrections
│   ├── cross-project-knowledge.md
│   └── daily-notes/           # Last 3 days loaded
│       └── YYYY-MM-DD.md
│
├── context/                    # PROJECT (persistent)
│   ├── index.json             # Registry
│   └── [project-slug]/
│       ├── session-summary.md
│       ├── drive-docs/        # Level 1 cache
│       └── analysis-outputs/  # Subagent reviews
│
├── subagents/                  # 14 specialist agents
│   ├── executive/SKILL.md
│   ├── cto/SKILL.md
│   ├── backend-engineer/SKILL.md
│   ├── prompt-assessor/SKILL.md
│   ├── research-papers/SKILL.md
│   └── ... (14 total)
│
├── skills/                    # Writing methodology skills
│   ├── prd-writing/SKILL.md
│   ├── prfaq-writing/SKILL.md
│   ├── strategy-doc/SKILL.md
│   └── stakeholder-update/SKILL.md
│
├── templates/                  # Task briefs
├── skill/SKILL.md             # Activation skill
└── comms/jarvis-readme.md     # Technical docs
```

---

## Daily Notes

Jarvis loads last 3 days of notes on init for session continuity.

**Write notes:**
```
add today's notes
```

**Format:** ~50 lines max (context efficient)

---

## Token Efficiency

| Scenario | Tokens |
|----------|--------|
| Full docs (160KB) | ~40,000 |
| Level 1 cache | ~3,750 |
| **Savings** | **~90%** |

---

## Troubleshooting

| Issue | Fix |
|-------|-----|
| "No context loaded" | Normal for new project. Create `.jarvis.md` for auto-cache |
| "Can't find document" | Check Drive ID, verify sharing permissions |
| "Context stale" | Auto-validated on cite. Manual: `refresh cache for [doc]` |
| "Refreshing cache..." | Normal — doc changed since last cache, auto-refreshing |
| MCP fails | Works from cache, warns you |
| Validation slow | Only happens on cite; metadata call is ~50ms |
| **MCP not showing in `/mcp`** | MCP servers are project-specific by default. Add to `~/.claude/settings.json` for global access. Restart Claude Code after config change. |
| **MCP configured but tools missing** | Check authentication. Re-authenticate if needed, then restart session. |

---

## Best Practices

**Do:**
- Create `.jarvis.md` for regular projects
- Let Jarvis discover docs lazily
- Trust citations (always sourced)
- Use `add today's notes` at session end

**Don't:**
- Manually edit cache files
- Cache hundreds of docs
- Bypass Jarvis for company facts
- Skip source verification on decisions

---

## Reference

- **Technical docs:** `~/.claude/jarvis/comms/jarvis-readme.md`
- **Activation skill:** `~/.claude/jarvis/skill/SKILL.md`
- **Global config:** `~/.claude/CLAUDE.md`

---

*Jarvis OS v3.0 - Your personal PM operating system*
