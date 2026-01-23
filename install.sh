#!/bin/bash
# Jarvis OS Installer
# From: jarvis-starter repo
# Installs: jarvis-os-for-PMs (core system)

set -e

JARVIS_DIR="$HOME/.claude/jarvis"
CORE_REPO="https://github.com/andrey-shilin-parloa/jarvis-os-for-PMs.git"
STARTER_REPO="https://raw.githubusercontent.com/andrey-shilin-parloa/jarvis-starter/main"

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

# Clone or update core system
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
  echo "→ Installing Jarvis OS core..."
  git clone --quiet "$CORE_REPO" "$JARVIS_DIR"
  echo "✓ Cloned to $JARVIS_DIR"
fi

# Create memory structure
echo "→ Setting up memory directories..."
mkdir -p "$JARVIS_DIR/memory/daily-notes"
mkdir -p "$JARVIS_DIR/context"
echo "✓ Directories created"

# Download minimal profile from starter repo
echo "→ Setting up starter profile..."
if [ ! -f "$JARVIS_DIR/memory/user-profile.md" ]; then
  curl -sSL "$STARTER_REPO/starter-templates/user-profile-minimal.md" \
    -o "$JARVIS_DIR/memory/user-profile.md"
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
