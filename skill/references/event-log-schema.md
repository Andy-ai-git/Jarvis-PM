# Session Event Log (session-log.jsonl)

Structured event log for machine-readable persistence across sessions. JSONL format (one event per line).

## Schema (v1)

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

## Event Types

| Type | Description | Auto-Extract Triggers |
|------|-------------|----------------------|
| `decision` | A choice was made | "decided", "agreed", "we'll go with", "final answer" |
| `blocker` | Something blocking progress | "blocked", "waiting on", "need input from", "can't proceed" |
| `action` | Follow-up task identified | "need to", "TODO", "follow up", "next step", "tomorrow" |
| `learning` | Reusable knowledge gained | "actually", "turns out", "TIL", "learned that" |
| `insight` | Non-obvious observation | "hypothesis", "noticed", "pattern", "interesting" |
| `milestone` | Significant completion | "done", "shipped", "completed", "launched" |
| `context` | Important background info | Explicit "for context", "background", "FYI" |

## Auto-Extraction

Jarvis automatically detects and logs events during conversation based on trigger phrases. Events are written immediately when detected.

## Manual Commands

- `jarvis log decision: [text]` - Force-write decision event
- `jarvis log blocker: [text]` - Force-write blocker event
- `jarvis log action: [text]` - Force-write action event
- `jarvis log insight: [text]` - Force-write insight event

## Loading (On Activation)

- Load last 7 days of events
- Filter to: decisions, blockers, pending actions
- Max 20 events to stay context-efficient
- Estimated cost: ~500-1000 tokens

## Retention

- Active: 90 days in `session-log.jsonl`
- Archive: Quarterly files in `session-log-archive/` (e.g., `2026-Q1.jsonl`)
- Auto-cleanup on `/jarvis` activation

## Example Entries

```jsonl
{"v":1,"ts":"2026-02-03T14:30:00Z","type":"decision","project":"support-workflow","content":"Agreed to restructure SLAs around ARR tiers","tags":["support","sla"]}
{"v":1,"ts":"2026-02-03T15:00:00Z","type":"blocker","project":"support-workflow","content":"Need CS health score data in Zendesk","owner":"RevOps"}
{"v":1,"ts":"2026-02-03T15:30:00Z","type":"action","project":"ai-onboarding","content":"Draft role-specific quick-start cards","status":"done"}
```
