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
# - session-log.jsonl: Recent events (last 7 days, filtered)
```

**Session Log (Recent Events - Context Efficient):**
```bash
# Load last 7 days of decisions, blockers, pending actions
# Max 20 events to stay context-efficient
SESSION_LOG="$USER_MEMORY/session-log.jsonl"
CUTOFF=$(date -v-7d +%Y-%m-%dT00:00:00Z)
# Filter: last 7 days, relevant types, current project or cross-project
jq -c "select(.ts >= \"$CUTOFF\" and .type | IN(\"decision\",\"blocker\",\"action\"))" \
  "$SESSION_LOG" | tail -20
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

#### 5a. Drive Documents

For each document in Critical Documents table:

1. **Check cache status** in `index.json`
2. **If not cached or stale (>30 days):**
   - Fetch with `previewOnly=true` (~1000 chars)
   - Create Level 1 summary with metadata
   - Save to `drive-docs/[doc-name].md`
   - Update `index.json` status

#### 5b. Notion Pages (NEW)

For each page in Key Notion Pages table:

1. **Check cache status** in `index.json`
2. **If not cached or stale (>30 days):**
   - Fetch with `notion-fetch` tool
   - Create Level 1 summary with metadata
   - Save to `notion-pages/[page-name].md`
   - Update `index.json` status

**Notion Cache File Format:**
```markdown
# [Page Title] - Cached Summary

## Metadata (Level 0)
| Field | Value |
|-------|-------|
| Page ID | `...` |
| URL | `...` |
| Last Modified | ... |
| Cache Level | 1 |

## Key Facts (Level 1 Summary)
- [Extracted key facts]
- [Quick answers]

---
*To fetch full page: Use Notion ID `...`*
```

**Tiered Cache Levels:**
```
Level 0: Metadata only        (~50 tokens)   - title, date, size, ID
Level 1: Key facts summary    (~500 tokens)  - extracted insights, quick answers
Level 2: Full document        (on demand)    - fetched when Level 1 insufficient
```

**Cache File Format (Drive):**
```markdown
# [Document Title] - Cached Summary

## Metadata (Level 0)
| Field | Value |
|-------|-------|
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
       ██╗    █████╗     ██████╗     ██╗   ██╗    ██╗    ███████╗
       ██║   ██╔══██╗    ██╔══██╗    ██║   ██║    ██║    ██╔════╝
       ██║   ███████║    ██████╔╝    ██║   ██║    ██║    ███████╗
  ██   ██║   ██╔══██║    ██╔══██╗    ╚██╗ ██╔╝    ██║    ╚════██║
  ╚█████╔╝   ██║  ██║    ██║  ██║     ╚████╔╝     ██║    ███████║
   ╚════╝    ╚═╝  ╚═╝    ╚═╝  ╚═╝      ╚═══╝      ╚═╝    ╚══════╝

✓ Ready for [Project Name]

Memory loaded:
• User profile: [X] preferences
• Project cache: [Y] documents
• Subagent outputs: [Z] analyses
• Recent events: [N] items ([D] decisions, [B] blockers, [A] pending actions)

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

### Thinking Levels for Subagents

Use extended thinking when tasks require deeper reasoning:

| Task Type | Thinking Level | When to Use |
|-----------|----------------|-------------|
| Quick review | Default | Routine checks, simple validations |
| PRD review | `think hard` | Technical feasibility, dependency analysis |
| PRFAQ review | `think hard` | Strategic alignment, market positioning |
| Architecture decisions | `ultrathink` | Complex trade-offs, multi-system impact |
| Pre-mortem / Devil's Advocate | `ultrathink` | Finding non-obvious failure modes |
| Strategy documents | `ultrathink` | Long-term implications, competitive dynamics |

**How to specify in Task Brief:**
```markdown
## Thinking Level
Use extended thinking ("think hard") for this review.
```

**Example escalation:**
- First pass: Default thinking → Surface issues found
- Resume with demands: "think harder" → Deeper analysis
- Complex decisions: "ultrathink" → Comprehensive reasoning

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

1. **Check Level 1 cache** → `drive-docs/*.md` AND `notion-pages/*.md` summaries
2. **Validate freshness** → Compare `lastModified` with source (see below)
3. **If need more detail** → Hydrate to Level 2 (fetch full doc/page)
4. **Search Notion** → Exact keyword first, then semantic
5. **Search Drive** → MCP document search
6. **If not found** → "I don't have a source for this"

### Validate-Before-Cite (Option C Freshness)

**Before citing any cached document or Notion page, validate it's still current:**

```
About to cite cached doc/page
         ↓
Call source API: get metadata (lastEditedTime/modifiedTime only)
  - Drive: get file metadata
  - Notion: notion-fetch (metadata is in response)
         ↓
Compare: cached lastModified vs current lastModified
         ↓
         Same? → Use cache, proceed with citation
         ↓
         Different? → Refresh cache first
                      ↓
                      Re-fetch document/page
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
# Pseudocode for validate-before-cite (Drive)
def cite_cached_doc(doc_id):
    cached = read_index_json(doc_id)
    current = drive_api.get_file_metadata(doc_id)  # modifiedTime only

    if current.modifiedTime != cached.lastModified:
        # Stale! Refresh first
        refresh_cache(doc_id)

    return cached_content()

# Pseudocode for validate-before-cite (Notion)
def cite_cached_notion_page(page_id):
    cached = read_index_json(page_id)
    current = notion_api.fetch_page(page_id)  # lastEditedTime in response

    if current.lastEditedTime != cached.lastModified:
        # Stale! Refresh first
        refresh_notion_cache(page_id)

    return cached_content()
```

**When to validate:**
- ALWAYS before citing a cached doc/page in an answer
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
| `/jarvis` | Activate/re-activate (runs auto-cleanup) |
| `jarvis status` | Show cached docs, metrics |
| `jarvis events` | Show recent events (last 7 days) |
| `jarvis events --all` | Show all events for current project |
| `jarvis blockers` | Show active blockers |
| `jarvis actions` | Show pending actions |
| `jarvis log [type]: [text]` | Manually log event (decision/blocker/action/insight) |
| `jarvis projects` | List all projects |
| `jarvis memory` | Show user memory contents |
| `jarvis learn [fact]` | Add to learnings.md |
| `add today's notes` | Write daily session summary |
| `refresh cache for [doc]` | Re-fetch document |
| `jarvis clear cache` | Remove project cache |
| `jarvis forget [project]` | Clear project entirely |
| `jarvis cleanup` | Run retention policy (90d analysis, 30d notes, 90d events) |
| `jarvis cleanup --dry-run` | Preview what would be cleaned |
| `summarize session` | Auto-generate session summary (decisions, blockers, next steps) |

---

## Steering Wheel Refinement

Adjust output dimensions on-the-fly with these commands:

| Command | Effect |
|---------|--------|
| "make it more concrete" | Grounding → Concrete |
| "make it bolder" | Risk → Bold |
| "expand on this" | Scope → Expansive |
| "simplify" | Style → Clear, Scope → Focused |
| "make it punchier" | Style → Compelling |
| "more exploratory" | Certainty → Exploratory |
| "lock it in" | Certainty → Definitive |
| "be more conservative" | Risk → Safe |
| "try something different" | Originality → Novel |
| "stick to what works" | Originality → Proven |
| "give me the big picture" | Grounding → Abstract, Scope → Expansive |
| "get specific" | Grounding → Concrete, Scope → Focused |

### Presets (Shortcuts)

| Preset | Trigger Phrases | Settings Applied |
|--------|-----------------|------------------|
| **Brainstorm Mode** | "let's brainstorm", "help me think" | Exploratory, Novel, Abstract, Bold, Expansive, Compelling |
| **Final Draft** | "finalize", "polish this", "lock it in" | Definitive, Proven, Concrete, Safe, Focused, Clear |
| **Strategy Mode** | "strategy", "big picture" | Exploratory, Novel, Abstract, Bold, Expansive, Compelling |
| **Execution Mode** | "tactical", "action items", "next steps" | Definitive, Proven, Concrete, Safe, Focused, Clear |

See `~/.claude/jarvis/skill/steering-wheel.md` for full details.

---

## Context Storage (3-Layer)

```
~/.claude/jarvis/
├── memory/                          # USER LEVEL (permanent)
│   ├── user-profile.md             # Identity, preferences
│   ├── learnings.md                # Patterns, corrections
│   ├── cross-project-knowledge.md  # Company facts
│   ├── session-log.jsonl           # Structured events (decisions, blockers, actions)
│   ├── session-log-archive/        # Archived events (quarterly)
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
| **Decision made** | `memory/session-log.jsonl` |
| **Blocker identified** | `memory/session-log.jsonl` |
| **Action item created** | `memory/session-log.jsonl` |
| **Insight recorded** | `memory/session-log.jsonl` |
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

**Retention:** Keep last 30 days, auto-archive older notes to `daily-notes/archive/`.

### Session Summary Auto-Generation (NEW)

**Trigger:** End of significant work session, or explicit "summarize session"

**Auto-extraction logic:**
Jarvis scans conversation for:
1. **Decisions** - Look for: "decided", "agreed", "we'll go with", "final answer"
2. **Blockers** - Look for: "blocked", "waiting on", "need input from", "can't proceed"
3. **Next steps** - Look for: "next", "tomorrow", "follow up", "action item"
4. **Key outputs** - Files created, reviews completed, documents drafted

**Auto-generated format:**
```markdown
# Session Summary - [Project] - YYYY-MM-DD

## Decisions Made
- [Auto-extracted decisions with context]

## Blockers Identified
- [Auto-extracted blockers with owners if mentioned]

## Next Steps
- [ ] [Auto-extracted action items]

## Key Outputs
- [Files created/modified]
- [Reviews completed]

## Raw Session Notes
[Optional: user can add manual notes]
```

**Implementation:**
When session ends or user says "summarize session":
1. Scan conversation for trigger phrases
2. Extract relevant statements with context
3. Categorize into decisions/blockers/next-steps
4. Write to `memory/daily-notes/YYYY-MM-DD.md`
5. Also update `context/[project]/session-summary.md` for project continuity

### Session Event Log (session-log.jsonl)

Structured event log for machine-readable persistence across sessions. JSONL format (one event per line).

**Schema (v1):**
```json
{
  "v": 1,
  "ts": "ISO8601 timestamp",
  "type": "decision|blocker|action|learning|insight|milestone|context",
  "project": "project-slug or null (cross-project)",
  "content": "Event description",
  "context": "Optional reasoning/background",
  "owner": "For blockers/actions: person responsible",
  "status": "For actions: pending|done|cancelled",
  "tags": ["optional", "categorization", "tags"]
}
```

**Event Types:**

| Type | Description | Auto-Extract Triggers |
|------|-------------|----------------------|
| `decision` | A choice was made | "decided", "agreed", "we'll go with", "final answer" |
| `blocker` | Something blocking progress | "blocked", "waiting on", "need input from", "can't proceed" |
| `action` | Follow-up task identified | "need to", "TODO", "follow up", "next step", "tomorrow" |
| `learning` | Reusable knowledge gained | "actually", "turns out", "TIL", "learned that" |
| `insight` | Non-obvious observation | "hypothesis", "noticed", "pattern", "interesting" |
| `milestone` | Significant completion | "done", "shipped", "completed", "launched" |
| `context` | Important background info | Explicit "for context", "background", "FYI" |

**Auto-Extraction:**
Jarvis automatically detects and logs events during conversation based on trigger phrases. Events are written immediately when detected.

**Manual Commands:**
- `jarvis log decision: [text]` - Force-write decision event
- `jarvis log blocker: [text]` - Force-write blocker event
- `jarvis log action: [text]` - Force-write action event
- `jarvis log insight: [text]` - Force-write insight event

**Loading (On Activation):**
- Load last 7 days of events
- Filter to: decisions, blockers, pending actions
- Max 20 events to stay context-efficient
- Estimated cost: ~500-1000 tokens

**Retention:**
- Active: 90 days in `session-log.jsonl`
- Archive: Quarterly files in `session-log-archive/` (e.g., `2026-Q1.jsonl`)
- Auto-cleanup on `/jarvis` activation

**Example Entries:**
```jsonl
{"v":1,"ts":"2026-02-03T14:30:00Z","type":"decision","project":"support-workflow","content":"Agreed to restructure SLAs around ARR tiers","tags":["support","sla"]}
{"v":1,"ts":"2026-02-03T15:00:00Z","type":"blocker","project":"support-workflow","content":"Need CS health score data in Zendesk","owner":"RevOps"}
{"v":1,"ts":"2026-02-03T15:30:00Z","type":"action","project":"ai-onboarding","content":"Draft role-specific quick-start cards","status":"done"}
```

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
