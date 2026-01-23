# Jarvis Quick Start

Get Jarvis running in 5 minutes.

---

## Step 1: Install (1 minute)

```bash
curl -sSL https://raw.githubusercontent.com/Andy-ai-git/Jarvis-PM/main/install.sh | bash
```

You should see:
```
╔═══════════════════════════════════════╗
║  ✓ Jarvis OS installed successfully   ║
╚═══════════════════════════════════════╝
```

---

## Step 2: Add Your Name (1 minute)

Open the profile:
```bash
open ~/.claude/jarvis/memory/user-profile.md
```

Change line 5 from:
```markdown
- **Name:** [Your name]
```

To:
```markdown
- **Name:** Alex
```

Save and close. That's the only required change.

---

## Step 3: Activate (30 seconds)

In Claude Code, type:
```
/jarvis
```

Jarvis will confirm activation:
```
Jarvis OS activated.
- Memory: Loaded
- Profile: Alex, Product Manager
- Ready for sparring.
```

---

## You're Done!

Jarvis is now active with:

| Feature | Status |
|---------|--------|
| Persistent memory | ✓ Ready |
| Source attribution | ✓ Active |
| Sparring partner mode | ✓ Active |
| Specialist reviewers | ✓ Available |

---

## What Can Jarvis Do?

### Challenge Your Thinking
```
Me: I think we should build feature X first.
Jarvis: What evidence supports that prioritization?
        Have you considered Y and Z as alternatives?
```

### Review Documents
```
Me: Review this PRD for technical feasibility.
Jarvis: [Delegates to Engineering Team: CTO, Backend, Frontend, DevOps]
        Returns consolidated feedback with specific concerns.
```

### Cache Documents
```
Me: I'll be working with the Q4 roadmap doc frequently.
Jarvis: [Fetches from Drive/Notion, caches locally]
        Future references use cache (90% token savings).
```

### Remember Learnings
```
Me: Actually, we decided against OAuth - use SAML instead.
Jarvis: [Updates learnings.md]
        I'll remember that for future auth discussions.
```

---

## Next Steps (When Ready)

| Task | Guide |
|------|-------|
| Customize your profile | [docs/CUSTOMIZATION.md](docs/CUSTOMIZATION.md) |
| Understand how skills work | [docs/SKILL-REGISTRATION.md](docs/SKILL-REGISTRATION.md) |
| Fix issues | [docs/TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md) |

---

## Quick Commands

| Command | What it does |
|---------|--------------|
| `/jarvis` | Activate Jarvis |
| `jarvis status` | Show loaded context |
| `refresh cache for [doc]` | Re-fetch a document |
| `jarvis clear cache` | Clear project cache |

---

## Uninstall

If you ever need to remove Jarvis:
```bash
rm -rf ~/.claude/jarvis
```

Your Claude Code installation is unaffected.
