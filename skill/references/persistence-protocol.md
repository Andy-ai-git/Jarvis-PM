# Persistence Protocol (MANDATORY)

Previous sessions were lost because persistence relied on Jarvis "remembering" to write at session end. This is the same P^N decay problem we diagnose in prompt assessments — behavioral rules get dropped. The fix: persistence is a **mandatory side-effect** of specific actions, not a separate step.

## Rule 1: Log Events Inline (STRICT)

After any response that contains a decision, blocker, action item, or milestone → **MUST append to `session-log.jsonl` in the same tool-call batch.**

Not later. Not at end of session. Not "I'll log it when we wrap up." Same turn.

```
User says "let's go with option B"
  → Jarvis responds with analysis
  → IN THE SAME RESPONSE: Bash append to session-log.jsonl
```

## Rule 2: Auto-Cache on Fetch (STRICT)

Any document fetched via MCP (Drive `gdrive_fetch`, Notion `notion-fetch`) → **MUST be saved to project context immediately.**

- Drive docs → `context/[project]/drive-docs/[doc-name].md`
- Notion pages → `context/[project]/notion-pages/[page-name].md`
- Sub-agents that fetch docs → MUST return cache-worthy content in their output
- Minimum: Level 0 metadata (title, ID, lastModified, URL)
- Preferred: Level 1 summary (key facts, ~500 tokens)

**No fetch without cache. No exceptions.**

## Rule 3: Register Project on Activation (STRICT)

Every `/jarvis` activation → **MUST update `index.json`** with:
- Project slug, path, `lastAccessed` timestamp
- Create project directory structure if it doesn't exist
- Even if the project already exists (update `lastAccessed`)

## Rule 4: Incremental Session Summary (STRICT)

After completing a major deliverable → **MUST append to both:**
- `memory/daily-notes/YYYY-MM-DD.md`
- `context/[project]/session-summary.md`

Major deliverables include: document created/edited, review completed, analysis delivered, research synthesized.

End-of-session summary is a **backup**, not the primary mechanism. If all inline writes happened correctly, the end-of-session summary just confirms what's already recorded.

## Persistence Self-Check

Before ending a conversation turn that produced substantive work:

```
1. ☐ Any decisions/blockers/actions? → Logged to session-log.jsonl?
2. ☐ Any documents fetched via MCP? → Cached to project context?
3. ☐ Major deliverable completed? → Daily note + session summary updated?
4. ☐ New project detected? → Registered in index.json?
```

If ANY box is unchecked, **do the write before responding to the user.**

## Why This Works

- Persistence is a side-effect of actions, not a separate step to remember
- Each write is small (~100-500 tokens) — minimal context cost
- Worst case if a session ends abruptly: only the LAST turn is lost, not the entire session
- Eliminates the P^N problem: 4 structural rules > 50 behavioral "remember to save" rules

## Stop Hook (Session Exit Enforcement)

Structural enforcement at session exit — checks daily note, session summary, session log. Requires `.session-active` flag from Step 3b of activation.

### Deterministic Validation

Run `scripts/validate-persistence.sh [project-slug]` to verify all artifacts exist.
