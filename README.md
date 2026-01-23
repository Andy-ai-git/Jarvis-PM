# Jarvis OS Starter

**Your personal PM operating system for Claude Code.**

Jarvis transforms Claude into an intellectual sparring partner with persistent memory, source-grounded answers, and specialist reviewers on demand.

---

## What You Get

| Feature | Benefit |
|---------|---------|
| **Persistent Memory** | Jarvis remembers your preferences, past decisions, and learnings across sessions |
| **Source-Grounded Answers** | Every claim cites a source or explicitly says "I don't know" |
| **12 Specialist Reviewers** | CTO, UX Designer, Data Analyst, Devil's Advocate, and more |
| **Document Caching** | 90% token savings by caching frequently-used docs |
| **Sparring Partner Mode** | Challenges assumptions, finds blind spots, pushes for depth |

---

## Quick Install (1 command)

```bash
curl -sSL https://raw.githubusercontent.com/andrey-shilin-parloa/jarvis-starter/main/install.sh | bash
```

This will:
1. Clone Jarvis OS core to `~/.claude/jarvis`
2. Create memory directories
3. Set up a minimal working profile

---

## After Installation

### 1. Add your name (30 seconds)

Edit `~/.claude/jarvis/memory/user-profile.md` and add your name on line 4.

### 2. Activate Jarvis

In Claude Code, type:
```
/jarvis
```

That's it. You're ready.

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

## Optional: MCP Integrations

Jarvis works great standalone. For deeper integration, you can connect:

- **Notion** - Search and update your workspace
- **Google Drive** - Fetch and cache documents
- **Gmail** - Search and draft emails

MCP setup is optional and separate from Jarvis installation. See [Claude Code MCP documentation](https://docs.anthropic.com/claude-code/mcp) for details.

---

## Repository Structure

```
jarvis-starter/          ← You are here (onboarding)
│
└── Installs → jarvis-os-for-PMs/   ← Core system
              ├── skill/            ← Jarvis skill definition
              ├── subagents/        ← 12 specialist reviewers
              ├── templates/        ← Full profile templates
              └── memory/           ← Your data (created by installer)
```

---

## License

MIT License - see [LICENSE](LICENSE)

---

## Contributing

Jarvis Starter is the onboarding package. For core system contributions, see [jarvis-os-for-PMs](https://github.com/andrey-shilin-parloa/jarvis-os-for-PMs).
