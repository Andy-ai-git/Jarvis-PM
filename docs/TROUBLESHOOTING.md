# Troubleshooting Jarvis OS

Common issues and how to fix them.

---

## Installation Issues

### "Git is required" error

**Problem:** Installer can't find git.

**Fix:**
```bash
# macOS
xcode-select --install

# Ubuntu/Debian
sudo apt install git

# Windows (WSL)
sudo apt install git
```

### Installation succeeds but `/jarvis` not found

**Problem:** Skill not discovered by Claude Code.

**Causes:**
1. Files in wrong location
2. Claude Code needs restart

**Fix:**
```bash
# Verify installation location
ls -la ~/.claude/jarvis/skill/SKILL.md

# If file exists, restart Claude Code
# If file missing, re-run installer:
curl -sSL https://raw.githubusercontent.com/andrey-shilin-parloa/jarvis-starter/main/install.sh | bash
```

### "Permission denied" during installation

**Problem:** Can't write to `~/.claude`.

**Fix:**
```bash
# Check directory permissions
ls -la ~/.claude

# Fix permissions if needed
chmod 755 ~/.claude

# Re-run installer
```

---

## Activation Issues

### `/jarvis` runs but doesn't load profile

**Problem:** Jarvis activates but doesn't show your name/preferences.

**Causes:**
1. Profile file empty or malformed
2. Profile in wrong location

**Fix:**
```bash
# Check profile exists and has content
cat ~/.claude/jarvis/memory/user-profile.md

# Should show your name on line 5
# If empty, re-run installer or copy from template
```

### "Memory not found" warning

**Problem:** Jarvis can't find memory directory.

**Fix:**
```bash
# Create memory structure
mkdir -p ~/.claude/jarvis/memory/daily-notes

# Verify
ls -la ~/.claude/jarvis/memory/
```

---

## Runtime Issues

### Jarvis not challenging assumptions (too agreeable)

**Problem:** Jarvis acts like a yes-machine.

**Causes:**
1. Profile doesn't emphasize sparring partner mode
2. Long conversation context diluting instructions

**Fix:**

Add to your `user-profile.md`:
```markdown
## Core Preferences
- ALWAYS challenge my assumptions before agreeing
- Ask "what if the opposite is true?" regularly
- Point out logical gaps even if I seem confident
- Steelman alternatives before accepting my direction
```

### Jarvis making claims without sources

**Problem:** Jarvis states facts without citations.

**Fix:**

Add to your `user-profile.md`:
```markdown
## Source Requirements
- NEVER state facts without citing a source
- If no source available, say "I don't have a source for this"
- Acceptable sources: URLs, documents from this conversation, explicit user statements
```

### Sub-agents not being invoked

**Problem:** Jarvis handles reviews directly instead of delegating.

**Causes:**
1. Subagent files missing
2. Task not matching delegation triggers

**Check subagents exist:**
```bash
ls ~/.claude/jarvis/subagents/
# Should show: cto.md, executive.md, user-researcher.md, etc.
```

**Explicit invocation:**
```
Me: Review this PRD with the Engineering Team.
```

### Context getting too large

**Problem:** Responses slow, hitting token limits.

**Causes:**
1. Large files read directly instead of delegated
2. Too much context accumulated

**Fix:**
```
Me: jarvis clear cache

Me: [Start fresh conversation]
```

For large files, explicitly delegate:
```
Me: Have a sub-agent analyze this 100KB spec and summarize key points.
```

---

## MCP Integration Issues

### Notion/Drive/Gmail not working

**Problem:** Jarvis can't access external services.

**Note:** MCP integrations are optional and configured separately from Jarvis.

**Check MCP status:**
```
Me: What MCP servers are connected?
```

**Fix:** See [Claude Code MCP documentation](https://docs.anthropic.com/claude-code/mcp) for setup instructions.

### "MCP connection failed" errors

**Problem:** Previously working MCP stops responding.

**Causes:**
1. Auth token expired
2. MCP server crashed
3. Network issues

**Fix:**
1. Restart Claude Code
2. Re-authenticate the MCP connection
3. Check MCP server logs

---

## Profile Issues

### Changes to profile not taking effect

**Problem:** You edited `user-profile.md` but Jarvis behaves the same.

**Causes:**
1. Jarvis cached old profile in conversation
2. Edit saved to wrong file

**Fix:**
```bash
# Verify you edited the right file
cat ~/.claude/jarvis/memory/user-profile.md | head -20

# Start a new conversation (profiles load at conversation start)
```

### Profile too complex, Jarvis confused

**Problem:** Jarvis behaves inconsistently with detailed profile.

**Fix:**
1. Simplify profile to core preferences
2. Move detailed rules to `learnings.md`
3. Be explicit about priorities when rules conflict

---

## Update Issues

### How to update Jarvis

```bash
cd ~/.claude/jarvis
git pull
```

### Update conflicts with local changes

**Problem:** `git pull` fails due to local modifications.

**Fix:**
```bash
# Option 1: Keep your changes, get updates
cd ~/.claude/jarvis
git stash
git pull
git stash pop

# Option 2: Discard your changes, get clean update
cd ~/.claude/jarvis
git checkout .
git pull
```

**Note:** Your `memory/` folder is gitignored, so your profile and learnings are safe.

---

## Uninstall / Reinstall

### Clean uninstall
```bash
rm -rf ~/.claude/jarvis
```

### Fresh reinstall
```bash
rm -rf ~/.claude/jarvis
curl -sSL https://raw.githubusercontent.com/andrey-shilin-parloa/jarvis-starter/main/install.sh | bash
```

### Reinstall keeping profile
```bash
# Backup memory
cp -r ~/.claude/jarvis/memory ~/jarvis-memory-backup

# Reinstall
rm -rf ~/.claude/jarvis
curl -sSL https://raw.githubusercontent.com/andrey-shilin-parloa/jarvis-starter/main/install.sh | bash

# Restore memory
rm -rf ~/.claude/jarvis/memory
mv ~/jarvis-memory-backup ~/.claude/jarvis/memory
```

---

## Getting Help

If none of these solutions work:

1. **Check the GitHub issues:** [jarvis-starter issues](https://github.com/andrey-shilin-parloa/jarvis-starter/issues)
2. **Open a new issue** with:
   - What you tried
   - Error messages (if any)
   - Output of `ls -la ~/.claude/jarvis/`

---

## Related Documentation

- [Skill Registration](SKILL-REGISTRATION.md) - How `/jarvis` works
- [Customization](CUSTOMIZATION.md) - Profile options
