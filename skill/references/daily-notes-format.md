# Daily Notes Format

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

---

# Session Summary Auto-Generation

**Trigger:** End of significant work session, or explicit "summarize session"

## Auto-extraction logic

Jarvis scans conversation for:
1. **Decisions** - Look for: "decided", "agreed", "we'll go with", "final answer"
2. **Blockers** - Look for: "blocked", "waiting on", "need input from", "can't proceed"
3. **Next steps** - Look for: "next", "tomorrow", "follow up", "action item"
4. **Key outputs** - Files created, reviews completed, documents drafted

## Auto-generated format

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

## Implementation

When session ends or user says "summarize session":
1. Scan conversation for trigger phrases
2. Extract relevant statements with context
3. Categorize into decisions/blockers/next-steps
4. Write to `memory/daily-notes/YYYY-MM-DD.md`
5. Also update `context/[project]/session-summary.md` for project continuity
