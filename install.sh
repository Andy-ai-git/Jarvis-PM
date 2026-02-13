#!/bin/bash
# Jarvis OS Installer
# Self-contained installation from single repo

set -e

JARVIS_DIR="$HOME/.claude/jarvis"
REPO_URL="https://github.com/Andy-ai-git/Jarvis-PM.git"
RAW_URL="https://raw.githubusercontent.com/Andy-ai-git/Jarvis-PM/main"

echo ""
echo "╔═══════════════════════════════════════╗"
echo "║       Jarvis OS Installer             ║"
echo "╚═══════════════════════════════════════╝"
echo ""

# Check prerequisites
if ! command -v git &> /dev/null; then
  echo "❌ Git is required. Install it first."
  echo "   macOS: xcode-select --install"
  echo "   Linux: sudo apt install git"
  exit 1
fi

# Ensure .claude directory exists
if [ ! -d "$HOME/.claude" ]; then
  echo "→ Creating ~/.claude directory..."
  mkdir -p "$HOME/.claude"
  echo "✓ Created ~/.claude"
fi

# Clone or update Jarvis
if [ -d "$JARVIS_DIR/.git" ]; then
  echo "→ Updating existing installation..."
  cd "$JARVIS_DIR" && git pull --quiet
  echo "✓ Updated to latest version"
else
  if [ -d "$JARVIS_DIR" ]; then
    echo "→ Found existing Jarvis directory (not a git repo)"
    echo "   Backing up to ~/.claude/jarvis.backup..."
    mv "$JARVIS_DIR" "$HOME/.claude/jarvis.backup.$(date +%Y%m%d%H%M%S)"
  fi
  echo "→ Installing Jarvis OS..."
  git clone --quiet "$REPO_URL" "$JARVIS_DIR"
  echo "✓ Cloned to $JARVIS_DIR"
fi

# Create memory structure
echo "→ Setting up memory directories..."
mkdir -p "$JARVIS_DIR/memory/daily-notes"
mkdir -p "$JARVIS_DIR/context"
echo "✓ Directories created"

# Set up starter profile
echo "→ Setting up starter profile..."
if [ ! -f "$JARVIS_DIR/memory/user-profile.md" ]; then
  if [ -f "$JARVIS_DIR/starter-templates/user-profile-minimal.md" ]; then
    cp "$JARVIS_DIR/starter-templates/user-profile-minimal.md" "$JARVIS_DIR/memory/user-profile.md"
  else
    curl -sSL "$RAW_URL/starter-templates/user-profile-minimal.md" \
      -o "$JARVIS_DIR/memory/user-profile.md"
  fi
  echo "✓ Created user-profile.md (minimal starter)"
else
  echo "✓ user-profile.md already exists (preserved)"
fi

# Copy other templates from core repo if they exist
if [ -d "$JARVIS_DIR/templates" ]; then
  for template in learnings cross-project-knowledge; do
    target="$JARVIS_DIR/memory/$template.md"
    source="$JARVIS_DIR/templates/${template}-template.md"
    if [ ! -f "$target" ] && [ -f "$source" ]; then
      cp "$source" "$target"
      echo "✓ Created $template.md"
    elif [ ! -f "$target" ]; then
      # Create empty file if template doesn't exist
      touch "$target"
      echo "✓ Created $template.md (empty)"
    fi
  done
fi

# Set up writing skills
echo "→ Setting up writing skills..."
SKILLS_DIR="$HOME/.claude/skills"
for skill in prd-writing prfaq-writing strategy-doc stakeholder-update; do
  skill_dir="$SKILLS_DIR/$skill"
  if [ -d "$JARVIS_DIR/skills/$skill" ]; then
    mkdir -p "$skill_dir"
    cp "$JARVIS_DIR/skills/$skill/SKILL.md" "$skill_dir/SKILL.md"
    echo "✓ Installed $skill skill"
  fi
done

# Set up mental models template
if [ ! -f "$JARVIS_DIR/memory/mental-models.md" ] && [ -f "$JARVIS_DIR/templates/mental-models.md" ]; then
  cp "$JARVIS_DIR/templates/mental-models.md" "$JARVIS_DIR/memory/mental-models.md"
  echo "✓ Created mental-models.md"
fi

# Create learnings.md if it doesn't exist
if [ ! -f "$JARVIS_DIR/memory/learnings.md" ]; then
  cat > "$JARVIS_DIR/memory/learnings.md" << 'EOF'
# Learnings

Corrections and patterns Jarvis should remember.

## Format
- **Date:** What I learned
- **Date:** Correction to previous behavior

## Learnings
<!-- Add learnings here as Jarvis learns your preferences -->
EOF
  echo "✓ Created learnings.md"
fi

# Create cross-project-knowledge.md if it doesn't exist
if [ ! -f "$JARVIS_DIR/memory/cross-project-knowledge.md" ]; then
  cat > "$JARVIS_DIR/memory/cross-project-knowledge.md" << 'EOF'
# Cross-Project Knowledge

Facts and context that apply across all projects.

## Company/Team
<!-- Add company-wide context here -->

## Tools & Systems
<!-- Add tools you use across projects -->

## Stakeholders
<!-- Key people Jarvis should know about -->
EOF
  echo "✓ Created cross-project-knowledge.md"
fi

# Check CLAUDE.md
echo ""
if [ -f "$HOME/.claude/CLAUDE.md" ]; then
  if grep -qi "jarvis" "$HOME/.claude/CLAUDE.md" 2>/dev/null; then
    echo "✓ CLAUDE.md already references Jarvis"
  else
    echo "⚠️  Optional: Add this to ~/.claude/CLAUDE.md:"
    echo ""
    echo "   # Jarvis OS"
    echo "   See ~/.claude/jarvis/JARVIS-GUIDE.md for full documentation."
    echo "   Quick start: Type /jarvis to activate."
    echo ""
  fi
else
  echo "ℹ️  No ~/.claude/CLAUDE.md found"
  echo "   This is optional. Jarvis works without it."
fi

echo ""
echo "╔═══════════════════════════════════════╗"
echo "║  ✓ Jarvis OS installed successfully   ║"
echo "╚═══════════════════════════════════════╝"
echo ""
echo "Next steps:"
echo ""
echo "  1. Add your name to the profile:"
echo "     open ~/.claude/jarvis/memory/user-profile.md"
echo ""
echo "  2. Activate Jarvis in Claude Code:"
echo "     /jarvis"
echo ""
echo "Documentation:"
echo "  ~/.claude/jarvis/JARVIS-GUIDE.md"
echo ""
