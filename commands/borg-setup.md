---
description: Output shell PATH setup instructions for borg commands
---

# /borg-setup

Display instructions for adding the ralph-borg scripts to your terminal PATH.

## Usage

```
/ralph-borg:borg-setup
```

## What This Command Does

Outputs the shell configuration needed to run `borg` commands directly from your terminal.

## Instructions

When this command is invoked:

### Step 1: Detect Plugin Path

The plugin install path is available via `$CLAUDE_PLUGIN_ROOT`. Use this to construct the scripts path.

### Step 2: Output Setup Instructions

Output the following instructions to the user:

```
To use borg commands in your terminal, add this line to your shell profile:

  For ~/.zshrc (macOS default):
    export PATH="$HOME/.claude/plugins/ralph-borg/scripts:$PATH"

  For ~/.bashrc (Linux/older macOS):
    export PATH="$HOME/.claude/plugins/ralph-borg/scripts:$PATH"

Then apply the changes:
  source ~/.zshrc   # or source ~/.bashrc

After setup, you can run:
  borg --help       # Show available commands
  borg status       # Check worktree status
  borg merge <name> # Merge completed feature
```

### Step 3: Verify Current Session

Also mention that within the current Claude Code session, the PATH is already configured via the SessionStart hook, so Claude can run `borg` commands. This setup is only needed for the user's terminal outside of Claude Code.

## Notes

- The SessionStart hook handles PATH configuration within Claude Code sessions
- This command is for users who want to run `borg` commands directly in their terminal
- Common use case: running `borg status` or `borg merge` after implementation completes
