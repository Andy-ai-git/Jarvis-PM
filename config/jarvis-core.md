# Jarvis Core Configuration
**Version:** 2.2
**Last Updated:** 2026-01-23

## Purpose
This configuration enables Jarvis OS - a memory + grounding layer for Claude that:
1. Remembers context across sessions (solves context rot)
2. Grounds all answers in sources (solves hallucinations)
3. Discovers new documents automatically (solves missing docs)

## Activation
**Trigger:** User says "jarvis" or "/jarvis"

When triggered, Jarvis:
1. Detects current project (via git root or working directory)
2. Checks for project-specific config (`.jarvis.md` in project root)
3. Loads cached context from `~/.claude/jarvis/context/`
4. Initializes session workspace

## Project Detection
```
Priority order:
1. Git root (if in git repo)
2. Current working directory
3. User home directory (fallback)
```

## Context Storage
**Location:** `~/.claude/jarvis/context/`

**Structure:**
```
~/.claude/jarvis/context/
├── index.json                    # Index of all projects and cached docs
├── [project-slug]/               # Per-project context
│   ├── session-summary.md       # Latest session state
│   ├── drive-docs/              # Cached Drive documents
│   ├── notion-pages/            # Cached Notion pages
│   └── analysis-outputs/        # Subagent analysis files
```

## Ground Truth Priority
1. Check cache → `~/.claude/jarvis/context/[project]/`
2. **Validate freshness** → Check source `lastModified` before citing (see Adaptation)
3. Search Notion → Semantic search across workspace
4. Search Drive → Targeted document search
5. If not found → Explicitly state "I don't have a source"

## Project-Specific Config
**Optional file:** `.jarvis.md` in project root

**Format:**
```markdown
# Jarvis Project Configuration

## Critical Documents (Auto-cache on session start)
- [RTT Migration PRD](drive-id)
- [Agent Copilot PRFAQ](drive-id)

## Key Notion Pages
- Product Wiki: [URL]
- Dependencies: [URL]

## Project Context
Brief description of the project for Jarvis to understand...
```

## Proactive Caching
On session start (when user says "jarvis"), automatically:
1. Check project config for critical docs list (Drive AND Notion)
2. Fetch and cache each critical doc/page (if not already cached or stale)
3. Run auto-cleanup (90d retention for analysis, 30d for notes)
4. Write session summary
5. Report: "Jarvis ready. Cached X Drive docs, Y Notion pages."

## Lazy Discovery
When user asks about something not in cache:
1. **Search** → grep keyword across Notion + Drive
2. **Peek** → Preview 1,000 chars (not full doc)
3. **Cache** → Save relevant sections
4. **Answer** → With citation

## Adaptation

**Automatic (Validate-Before-Cite):**
- Before citing any cached doc, check source `lastModified` via Drive API (~50ms)
- If stale → auto-refresh cache, then cite fresh data
- **Guarantees we NEVER cite outdated information**
- Lazy discovery finds new docs when asked
- Session builds knowledge incrementally

**Manual:**
- User says "refresh cache for [doc]" → re-fetch and cache
- User updates `.jarvis.md` → new docs auto-cached next session

## MCP Integrations

Jarvis uses these MCP servers. **Configure them globally** in `~/.claude/settings.json` (not per-project) so they work in any directory:

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

**Capabilities:**
- **Notion** - Search workspace, fetch/update pages
- **Google Drive** - Fetch files, search documents
- **Gmail** - Search emails, read threads
- **Playwright** - Browser automation, screenshots, web scraping

**Troubleshooting:** If MCP tools don't appear after config, restart Claude Code. Verify with `/mcp`.

## Subagents
Available specialists:
- **Engineer** - Technical feasibility, dependencies, APIs
- **Executive** - Strategic framing, business case, competitive positioning
- **User Researcher** - User needs, validation, SLOs

Auto-delegation triggers:
- PRD review → Engineer
- PRFAQ review → Executive
- Strategic questions → All three in parallel

## Skills
Document templates enforced:
- **/prfaq** - Amazon-style PR/FAQ
- **/prd** - PRD format
- **/strategy** - Rumelt's Strategy Kernel

## Token Efficiency
- Peek before full read (1,000 chars)
- Reference cached files (10 tokens vs 18,000)
- File-based subagent outputs (not returned in context)
- Target: 46-96% reduction vs vanilla Claude

## Maintenance
- **Weekly:** Review session summary, clear stale files
- **Monthly:** Audit cache freshness, update critical docs list
- **After major changes:** Update `.jarvis.md` config

## Auto-Cleanup Policy

**Retention Rules:**

| Location | Retention | Action |
|----------|-----------|--------|
| `analysis-outputs/` | 90 days | Auto-delete older files |
| `daily-notes/` | 30 days active, then archive | Move to `daily-notes/archive/` |
| `drive-docs/` | Indefinite (validated on cite) | Keep until manually removed |
| `notion-pages/` | Indefinite (validated on cite) | Keep until manually removed |
| `session-summary.md` | Keep latest only | Overwrite per session |

**Cleanup Triggers:**
1. **On `/jarvis` activation:** Check and apply retention rules
2. **Manual:** `jarvis cleanup` command

**Cleanup Implementation:**
```bash
# Auto-cleanup on jarvis activation
cleanup_old_files() {
    CONTEXT_DIR="$HOME/.claude/jarvis/context/$PROJECT_SLUG"

    # 1. Analysis outputs > 90 days
    find "$CONTEXT_DIR/analysis-outputs" -type f -mtime +90 -delete 2>/dev/null

    # 2. Archive daily notes > 30 days
    ARCHIVE_DIR="$HOME/.claude/jarvis/memory/daily-notes/archive"
    mkdir -p "$ARCHIVE_DIR"
    find "$HOME/.claude/jarvis/memory/daily-notes" -maxdepth 1 -type f -mtime +30 -exec mv {} "$ARCHIVE_DIR/" \; 2>/dev/null
}
```

**Manual Cleanup Commands:**
- `jarvis cleanup` - Run retention policy now
- `jarvis cleanup --dry-run` - Show what would be deleted
- `jarvis cleanup --force` - Skip confirmation
