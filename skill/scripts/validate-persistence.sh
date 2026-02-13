#!/bin/bash
# validate-persistence.sh — Deterministic check for Jarvis persistence artifacts
# Usage: ./validate-persistence.sh [project-slug]
#
# Checks that all mandatory persistence artifacts exist for today's session.
# Exit code = number of failures (0 = all good).

set -euo pipefail

PROJECT_SLUG="${1:-}"
JARVIS_DIR="$HOME/.claude/jarvis"
TODAY=$(date +%Y-%m-%d)
ERRORS=0
WARNINGS=0

echo "=== Jarvis Persistence Validation ==="
echo "Date: $TODAY"
echo "Project: ${PROJECT_SLUG:-"(none)"}"
echo ""

# --- Check 1: Daily note exists and has substance ---
NOTE="$JARVIS_DIR/memory/daily-notes/$TODAY.md"
if [ ! -f "$NOTE" ]; then
  echo "FAIL: Daily note missing: $NOTE"
  ERRORS=$((ERRORS + 1))
elif [ "$(wc -l < "$NOTE" | tr -d ' ')" -lt 10 ]; then
  echo "FAIL: Daily note has < 10 lines (likely incomplete): $NOTE"
  ERRORS=$((ERRORS + 1))
else
  LINES=$(wc -l < "$NOTE" | tr -d ' ')
  echo "OK:   Daily note exists ($LINES lines): $NOTE"
fi

# --- Check 2: Session log has today's entries ---
LOG="$JARVIS_DIR/memory/session-log.jsonl"
if [ ! -f "$LOG" ]; then
  echo "FAIL: Session log missing entirely: $LOG"
  ERRORS=$((ERRORS + 1))
else
  TODAY_ENTRIES=$(grep -c "$TODAY" "$LOG" 2>/dev/null) || TODAY_ENTRIES=0
  if [ "$TODAY_ENTRIES" -eq 0 ]; then
    echo "WARN: No session log entries for today"
    WARNINGS=$((WARNINGS + 1))
  else
    echo "OK:   Session log has $TODAY_ENTRIES entries for today"
  fi
fi

# --- Check 3: Project session summary (if project specified) ---
if [ -n "$PROJECT_SLUG" ]; then
  SUMMARY="$JARVIS_DIR/context/$PROJECT_SLUG/session-summary.md"
  if [ ! -f "$SUMMARY" ]; then
    echo "WARN: No session summary for project: $SUMMARY"
    WARNINGS=$((WARNINGS + 1))
  else
    # Check if modified today (macOS stat format)
    MOD_DATE=$(stat -f %Sm -t %Y-%m-%d "$SUMMARY" 2>/dev/null || echo "unknown")
    if [ "$MOD_DATE" = "$TODAY" ]; then
      echo "OK:   Session summary modified today: $SUMMARY"
    else
      echo "WARN: Session summary last modified $MOD_DATE (not today): $SUMMARY"
      WARNINGS=$((WARNINGS + 1))
    fi
  fi

  # --- Check 4: Project registered in index.json ---
  INDEX="$JARVIS_DIR/context/index.json"
  if [ ! -f "$INDEX" ]; then
    echo "FAIL: index.json missing: $INDEX"
    ERRORS=$((ERRORS + 1))
  elif ! grep -q "\"$PROJECT_SLUG\"" "$INDEX" 2>/dev/null; then
    echo "FAIL: Project '$PROJECT_SLUG' not registered in index.json"
    ERRORS=$((ERRORS + 1))
  else
    echo "OK:   Project '$PROJECT_SLUG' registered in index.json"
  fi
fi

# --- Check 5: .session-active flag (if Jarvis was activated) ---
FLAG="$JARVIS_DIR/.session-active"
if [ -f "$FLAG" ]; then
  echo "OK:   .session-active flag present"
else
  echo "INFO: No .session-active flag (may not be a Jarvis session)"
fi

# --- Summary ---
echo ""
echo "=== Results ==="
echo "Errors:   $ERRORS"
echo "Warnings: $WARNINGS"

if [ "$ERRORS" -gt 0 ]; then
  echo ""
  echo "ACTION REQUIRED: Fix $ERRORS error(s) before ending session."
fi

exit $ERRORS
