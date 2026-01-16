#!/usr/bin/env bash
# Auto-configure PATH for ralph-borg scripts
# Called by SessionStart hook

PLUGIN_ROOT="$1"

if [ -n "$CLAUDE_ENV_FILE" ] && [ -n "$PLUGIN_ROOT" ]; then
  # Add scripts directory to PATH for this session
  echo "export PATH=\"$PLUGIN_ROOT/scripts:\$PATH\"" >> "$CLAUDE_ENV_FILE"
fi

exit 0
