# Cache File Formats

## Notion Cache File Format

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

## Tiered Cache Levels

```
Level 0: Metadata only        (~50 tokens)   - title, date, size, ID
Level 1: Key facts summary    (~500 tokens)  - extracted insights, quick answers
Level 2: Full document        (on demand)    - fetched when Level 1 insufficient
```

## Cache File Format (Drive)

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

## Token Savings

- Full docs: ~40,000 tokens (for 160KB)
- Level 1 summaries: ~3,750 tokens
- **Savings: ~90%**
