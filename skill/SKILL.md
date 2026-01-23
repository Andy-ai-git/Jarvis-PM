---
name: jarvis
description: Activate Jarvis OS - personal PM assistant with 3-layer memory, auto-delegation, and source-grounded answers.
---

# Jarvis OS Activation

## When to Use

User invokes `/jarvis` to:
- Initialize Jarvis for current project
- Load 3-layer memory (user → project → session)
- Enable grounded, source-cited answers
- Activate auto-delegation to subagents

## 3-Layer Memory Architecture

```
┌─────────────────────────────────────────────────────┐
│  SESSION MEMORY (Conversation Context)              │
│  - Current task, working decisions                  │
│  Lifecycle: Single conversation                     │
└─────────────────────────────────────────────────────┘
                        ↓ persists to
┌─────────────────────────────────────────────────────┐
│  PROJECT MEMORY (~/.claude/jarvis/context/[slug]/)  │
│  - Cached docs, subagent outputs, session summary   │
│  Lifecycle: Per-project, persists across sessions   │
└─────────────────────────────────────────────────────┘
                        ↓ informs
┌─────────────────────────────────────────────────────┐
│  USER MEMORY (~/.claude/jarvis/memory/)             │
│  - user-profile.md, learnings.md, cross-project    │
│  Lifecycle: Permanent, spans all projects           │
└─────────────────────────────────────────────────────┘
```

## Activation Flow

When user types `/jarvis`:

### 1. Load User Memory (ALWAYS FIRST)
```bash
USER_MEMORY="$HOME/.claude/jarvis/memory"
# Read these files:
# - user-profile.md: Identity, preferences, writing style
# - learnings.md: Decision patterns, corrections, effective approaches
# - cross-project-knowledge.md: Company context, stakeholders
# - daily-notes/[last 3 days]: Recent session context (minimal load)
```

**Daily Notes (Last 3 Days - Context Efficient):**
```bash
# Load only last 3 days to minimize context usage
for i in {0..2}; do
  DATE=$(date -v-${i}d +%Y-%m-%d)
  NOTE="$USER_MEMORY/daily-notes/$DATE.md"
  [ -f "$NOTE" ] && cat "$NOTE"
done
```

**Note:** Keep notes concise (~50 lines max). Older notes available on request.

### 2. Detect Project
```bash
if git rev-parse --git-dir > /dev/null 2>&1; then
  PROJECT_ROOT=$(git rev-parse --show-toplevel)
else
  PROJECT_ROOT=$(pwd)
fi
PROJECT_SLUG=$(basename "$PROJECT_ROOT" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
```

### 3. Load Project Memory
```bash
CONTEXT_DIR="$HOME/.claude/jarvis/context/$PROJECT_SLUG"
mkdir -p "$CONTEXT_DIR"/{drive-docs,notion-pages,analysis-outputs}
# Read session-summary.md, cached docs, previous analyses
```

### 4. Check for Project Config
```bash
if [ -f "$PROJECT_ROOT/.jarvis.md" ]; then
  # Parse critical documents table
  # Extract Drive IDs from markdown
fi
```

### 5. Proactive Caching (If .jarvis.md exists)

For each document in Critical Documents table:

1. **Check cache status** in `index.json`
2. **If not cached or stale (>30 days):**
   - Fetch with `previewOnly=true` (~1000 chars)
   - Create Level 1 summary with metadata
   - Save to `drive-docs/[doc-name].md`
   - Update `index.json` status

**Tiered Cache Levels:**
```
Level 0: Metadata only        (~50 tokens)   - title, date, size, ID
Level 1: Key facts summary    (~500 tokens)  - extracted insights, quick answers
Level 2: Full document        (on demand)    - fetched when Level 1 insufficient
```

**Cache File Format:**
```markdown
# [Document Title] - Cached Summary

## Metadata (Level 0)
| Field | Value |
| Document ID | `...` |
| Last Modified | ... |
| Cache Level | 1 |

## Key Facts (Level 1 Summary)
- [Extracted key facts]
- [Quick answers]

---
*To fetch full document: Use Drive ID `...`*
```

**Token Savings:**
- Full docs: ~40,000 tokens (for 160KB)
- Level 1 summaries: ~3,750 tokens
- **Savings: ~90%**

### 6. Report Status
```
✓ Jarvis ready for [Project Name]

Memory loaded:
• User profile: [X] preferences
• Project cache: [Y] documents
• Subagent outputs: [Z] analyses

Ready for: fact checks, reviews, strategic questions
```

---

## Auto-Delegation (ENABLED)

Jarvis automatically spawns subagents when detecting trigger phrases.

### Trigger Detection

| User Says | Action |
|-----------|--------|
| "review PRD", "review this PRD" | → Engineer + Executive + User Researcher (parallel) |
| "review PRFAQ", "review this PRFAQ" | → Executive + Engineer (parallel) |
| "validate feature", "check feature spec" | → User Researcher |
| "review strategy", "check strategy" | → Executive + Engineer |
| "multi-perspective review" | → All three (parallel) |

### Subagent Skill Files

| Agent | Skill Location | Focus |
|-------|----------------|-------|
| **Engineer** | `~/.claude/jarvis/subagents/engineer/SKILL.md` | Technical feasibility, dependencies, risks |
| **Executive** | `~/.claude/jarvis/subagents/executive/SKILL.md` | Strategic alignment, stakeholder clarity |
| **User Researcher** | `~/.claude/jarvis/subagents/user-researcher/SKILL.md` | User value, adoption, validation |

### Task Brief Templates

Use templates from `~/.claude/jarvis/templates/`:
- `task-brief-prd-review.md`
- `task-brief-prfaq-review.md`
- `task-brief-multi-perspective.md`

### Acceptance Criteria

**Accept subagent output when:**
- [ ] All claims have document section references
- [ ] Concerns are risk-rated (High/Medium/Low)
- [ ] Recommendations are specific and actionable
- [ ] No section exceeds 200 words

**Resume with demands when:**
- Too vague ("looks fine")
- Missing section references
- No risk ratings
- Recommendations are abstract

**Circuit breaker:** After 3 resume attempts, escalate to user.

### Output Persistence

Save subagent outputs to:
```
~/.claude/jarvis/context/[project]/analysis-outputs/
├── [doc-name]-engineer-review-[date].md
├── [doc-name]-executive-review-[date].md
└── [doc-name]-user-researcher-review-[date].md
```

---

## Ground Truth Mode (ALWAYS ON)

For ANY factual claim:

1. **Check Level 1 cache** → `drive-docs/*.md` summaries
2. **Validate freshness** → Compare `lastModified` with source (see below)
3. **If need more detail** → Hydrate to Level 2 (fetch full doc)
4. **Search Notion** → Exact keyword first, then semantic
5. **Search Drive** → MCP document search
6. **If not found** → "I don't have a source for this"

### Validate-Before-Cite (Option C Freshness)

**Before citing any cached document, validate it's still current:**

```
About to cite cached doc
         ↓
Call Drive API: get file metadata (modifiedTime only)
         ↓
Compare: cached lastModified vs current lastModified
         ↓
         Same? → Use cache, proceed with citation
         ↓
         Different? → Refresh cache first
                      ↓
                      Re-fetch document
                      ↓
                      Update Level 1 summary
                      ↓
                      Update index.json timestamps
                      ↓
                      NOW cite the fresh data
```

**Why this works:**
- Metadata call is cheap (~50ms, ~100 tokens)
- Full doc fetch only when actually stale
- Guarantees we NEVER cite outdated information
- User doesn't need to remember to refresh

**Implementation:**
```python
# Pseudocode for validate-before-cite
def cite_cached_doc(doc_id):
    cached = read_index_json(doc_id)
    current = drive_api.get_file_metadata(doc_id)  # modifiedTime only

    if current.modifiedTime != cached.lastModified:
        # Stale! Refresh first
        refresh_cache(doc_id)

    return cached_content()
```

**When to validate:**
- ALWAYS before citing a cached doc in an answer
- NOT needed for quick metadata lookups (title, size)
- NOT needed during brainstorming (no factual claims)

### Hydration Flow (Updated)

```
Question → Check Level 1 summary exists?
         ↓
         Yes → VALIDATE FRESHNESS FIRST
         ↓
         Fresh? → Can answer from cache? → Yes → Answer
         ↓                                  ↓
         Stale? → Refresh cache            No → Hydrate to Level 2
         ↓                                       ↓
         Then answer from fresh cache      Answer with citation
```

**NEVER make claims without sources.**
**NEVER cite stale data without validation.**

## Lazy Discovery

When asked about something not in cache:

1. **Search** → Keyword search across Notion + Drive
2. **Peek** → `previewOnly=true` (1,000 chars)
3. **Cache** → Save to context folder
4. **Answer** → With citation and confidence

---

## Maintenance Commands

| Command | Action |
|---------|--------|
| `/jarvis` | Activate/re-activate |
| `jarvis status` | Show cached docs, metrics |
| `jarvis projects` | List all projects |
| `jarvis memory` | Show user memory contents |
| `jarvis learn [fact]` | Add to learnings.md |
| `add today's notes` | Write daily session summary |
| `refresh cache for [doc]` | Re-fetch document |
| `jarvis clear cache` | Remove project cache |
| `jarvis forget [project]` | Clear project entirely |

---

## Context Storage (3-Layer)

```
~/.claude/jarvis/
├── memory/                          # USER LEVEL (permanent)
│   ├── user-profile.md             # Identity, preferences
│   ├── learnings.md                # Patterns, corrections
│   ├── cross-project-knowledge.md  # Company facts
│   └── daily-notes/                # Session summaries by date
│       └── YYYY-MM-DD.md           # Load last 3 days (~50 lines max)
│
├── context/                         # PROJECT LEVEL
│   ├── index.json                  # Registry + metrics
│   └── [project-slug]/
│       ├── session-summary.md
│       ├── drive-docs/
│       ├── notion-pages/
│       └── analysis-outputs/
│
├── subagents/                       # SUBAGENT SKILLS
│   ├── engineer/SKILL.md
│   ├── executive/SKILL.md
│   └── user-researcher/SKILL.md
│
└── templates/                       # TASK BRIEFS
    ├── task-brief-prd-review.md
    ├── task-brief-prfaq-review.md
    └── task-brief-multi-perspective.md
```

## Memory Write Rules

| Event | Write To |
|-------|----------|
| User corrects Jarvis | `memory/learnings.md` |
| New preference discovered | `memory/user-profile.md` |
| Cross-project fact learned | `memory/cross-project-knowledge.md` |
| **Session ends** | `memory/daily-notes/YYYY-MM-DD.md` |
| Document cached | `context/[project]/drive-docs/` |
| Subagent analysis complete | `context/[project]/analysis-outputs/` |
| Project session state | `context/[project]/session-summary.md` |

### Daily Notes Format

At end of session (or when user says "add today's notes"), write to `memory/daily-notes/YYYY-MM-DD.md`:

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
- [Follow-ups needed]
```

**Retention:** Keep last 30 days, auto-prune older notes.

---

## Error Handling

| Scenario | Action |
|----------|--------|
| No `.jarvis.md` | OK - use lazy discovery |
| Invalid Drive ID | Skip, log, continue |
| MCP fails | Work from cache, warn user |
| Subagent fails 3x | Escalate to user |
| Cache > 30 days old | Re-validate before use |

---

## Integration

This skill implements the Jarvis OS defined in `~/.claude/CLAUDE.md`.

All behaviors (sparring partner mode, source attribution, orchestration rules) are defined there.
