#!/bin/bash
# validate-cache.sh — Check cache freshness for Jarvis project context
# Usage: ./validate-cache.sh [project-slug]
#
# Lists all cached documents with age and flags stale ones (>30 days).
# Exit code = number of stale documents.

set -euo pipefail

PROJECT_SLUG="${1:-}"
JARVIS_DIR="$HOME/.claude/jarvis"
TODAY_EPOCH=$(date +%s)
STALE_THRESHOLD=$((30 * 86400))  # 30 days in seconds
STALE=0

if [ -z "$PROJECT_SLUG" ]; then
  echo "Usage: validate-cache.sh <project-slug>"
  echo ""
  echo "Available projects:"
  ls -1 "$JARVIS_DIR/context/" 2>/dev/null | grep -v index.json || echo "  (none)"
  exit 1
fi

CONTEXT_DIR="$JARVIS_DIR/context/$PROJECT_SLUG"

if [ ! -d "$CONTEXT_DIR" ]; then
  echo "ERROR: Project context not found: $CONTEXT_DIR"
  exit 1
fi

echo "=== Cache Freshness Report ==="
echo "Project: $PROJECT_SLUG"
echo "Threshold: 30 days"
echo ""

# Check drive-docs
DRIVE_DIR="$CONTEXT_DIR/drive-docs"
if [ -d "$DRIVE_DIR" ] && [ "$(ls -A "$DRIVE_DIR" 2>/dev/null)" ]; then
  echo "--- Drive Documents ---"
  for f in "$DRIVE_DIR"/*.md; do
    [ -f "$f" ] || continue
    FILENAME=$(basename "$f")
    MOD_EPOCH=$(stat -f %m "$f" 2>/dev/null || echo 0)
    AGE_DAYS=$(( (TODAY_EPOCH - MOD_EPOCH) / 86400 ))

    if [ "$AGE_DAYS" -gt 30 ]; then
      echo "STALE ($AGE_DAYS days): $FILENAME"
      STALE=$((STALE + 1))
    else
      echo "OK    ($AGE_DAYS days): $FILENAME"
    fi
  done
  echo ""
else
  echo "--- Drive Documents ---"
  echo "  (none cached)"
  echo ""
fi

# Check notion-pages
NOTION_DIR="$CONTEXT_DIR/notion-pages"
if [ -d "$NOTION_DIR" ] && [ "$(ls -A "$NOTION_DIR" 2>/dev/null)" ]; then
  echo "--- Notion Pages ---"
  for f in "$NOTION_DIR"/*.md; do
    [ -f "$f" ] || continue
    FILENAME=$(basename "$f")
    MOD_EPOCH=$(stat -f %m "$f" 2>/dev/null || echo 0)
    AGE_DAYS=$(( (TODAY_EPOCH - MOD_EPOCH) / 86400 ))

    if [ "$AGE_DAYS" -gt 30 ]; then
      echo "STALE ($AGE_DAYS days): $FILENAME"
      STALE=$((STALE + 1))
    else
      echo "OK    ($AGE_DAYS days): $FILENAME"
    fi
  done
  echo ""
else
  echo "--- Notion Pages ---"
  echo "  (none cached)"
  echo ""
fi

# Check analysis-outputs
ANALYSIS_DIR="$CONTEXT_DIR/analysis-outputs"
if [ -d "$ANALYSIS_DIR" ] && [ "$(ls -A "$ANALYSIS_DIR" 2>/dev/null)" ]; then
  echo "--- Analysis Outputs ---"
  for f in "$ANALYSIS_DIR"/*.md; do
    [ -f "$f" ] || continue
    FILENAME=$(basename "$f")
    MOD_EPOCH=$(stat -f %m "$f" 2>/dev/null || echo 0)
    AGE_DAYS=$(( (TODAY_EPOCH - MOD_EPOCH) / 86400 ))

    if [ "$AGE_DAYS" -gt 90 ]; then
      echo "STALE ($AGE_DAYS days): $FILENAME"
      STALE=$((STALE + 1))
    else
      echo "OK    ($AGE_DAYS days): $FILENAME"
    fi
  done
  echo ""
else
  echo "--- Analysis Outputs ---"
  echo "  (none)"
  echo ""
fi

# Summary
echo "=== Results ==="
echo "Stale documents: $STALE"

if [ "$STALE" -gt 0 ]; then
  echo ""
  echo "Run 'refresh cache for [doc]' to update stale documents."
fi

exit $STALE
