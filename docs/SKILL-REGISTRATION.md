# How Skills Work in Claude Code

Understanding how Claude Code discovers and executes the `/jarvis` skill.

---

## The Short Version

Claude Code automatically discovers skills in `~/.claude/`. When you type `/jarvis`, Claude Code finds and executes `~/.claude/jarvis/skill/SKILL.md`.

No manual registration required.

---

## How Skill Discovery Works

### 1. Skill Location

Claude Code looks for skills in these locations:
```
~/.claude/                    # Global skills (all projects)
.claude/                      # Project-specific skills
```

### 2. Skill File Structure

A skill is defined by a `SKILL.md` file in a named directory:
```
~/.claude/jarvis/
└── skill/
    └── SKILL.md    ← This defines the /jarvis command
```

### 3. Invocation

When you type `/jarvis` in Claude Code:
1. Claude Code searches for a matching skill directory
2. Finds `~/.claude/jarvis/skill/SKILL.md`
3. Loads and executes the skill instructions

---

## Jarvis Skill Structure

```
~/.claude/jarvis/
├── skill/
│   └── SKILL.md           # Skill definition (activation logic)
├── subagents/             # Specialist reviewer definitions
│   ├── cto.md
│   ├── executive.md
│   ├── user-researcher.md
│   └── ...
├── templates/             # Full profile templates
├── memory/                # Your persistent data
│   ├── user-profile.md
│   ├── learnings.md
│   └── daily-notes/
└── context/               # Project-specific caches
```

---

## Verifying Installation

### Check skill file exists:
```bash
cat ~/.claude/jarvis/skill/SKILL.md
```

You should see the Jarvis activation instructions.

### Check Claude Code recognizes it:

In Claude Code, type:
```
/
```

You should see `jarvis` in the autocomplete list.

---

## Troubleshooting

### `/jarvis` doesn't appear in autocomplete

**Possible causes:**
1. Skill file missing or in wrong location
2. Claude Code hasn't refreshed skill list

**Fix:**
```bash
# Verify file exists
ls -la ~/.claude/jarvis/skill/SKILL.md

# If missing, re-run installer
curl -sSL https://raw.githubusercontent.com/Andy-ai-git/Jarvis-PM/main/install.sh | bash
```

### `/jarvis` appears but doesn't activate properly

**Possible causes:**
1. SKILL.md has syntax errors
2. Memory files missing

**Fix:**
```bash
# Check memory files exist
ls -la ~/.claude/jarvis/memory/

# Should show:
# user-profile.md
# learnings.md
# cross-project-knowledge.md
# daily-notes/
```

### Skill works but can't find subagents

**Possible causes:**
1. Subagent definitions missing
2. Wrong directory structure

**Fix:**
```bash
# Check subagents exist
ls ~/.claude/jarvis/subagents/

# Should show multiple .md files
```

---

## Creating Custom Skills

You can create your own skills following the same pattern:

```bash
mkdir -p ~/.claude/my-skill/skill
touch ~/.claude/my-skill/skill/SKILL.md
```

Then define your skill in `SKILL.md`:
```markdown
# My Custom Skill

## Activation
When /my-skill is invoked...

## Behavior
[Define what the skill does]
```

---

## Related Documentation

- [Customization Guide](CUSTOMIZATION.md) - Expand your Jarvis profile
- [Troubleshooting](TROUBLESHOOTING.md) - Common issues and fixes
