---
description: Implement a feature using the borg-ralph loop
---

# /implement

**IMPORTANT: This command launches the borg-ralph orchestration script. Do NOT implement the feature yourself. Run the shell commands below to spawn isolated agents that will do the implementation.**

## Usage

```
/ralph-borg:implement <feature-name>
```

The feature name is: $ARGUMENTS

## What To Do

### Step 1: Validate spec files exist

Check that both files exist:
- `specs/$ARGUMENTS.md`
- `specs/$ARGUMENTS.implementation.md`

If missing, tell the user to run `/ralph-borg:feature $ARGUMENTS` first.

### Step 2: Initialize borg (if needed)

Run this command to check borg status:
```bash
borg status 2>&1 || echo "NOT_INITIALIZED"
```

If output contains "NOT_INITIALIZED" or "not initialized", run:
```bash
borg init .
```

### Step 3: Launch borg-ralph loop

**DO NOT implement the feature yourself.** Instead, run this exact command:

```bash
borg-ralph loop $ARGUMENTS specs/$ARGUMENTS.implementation.md
```

Note: The first argument is the slot name (same as feature name), the second is the implementation plan path.

This will:
- Spawn isolated Claude Code agents (one per phase)
- Each agent works in its own git branch
- Checkboxes get updated automatically as phases complete
- You'll see progress output in the terminal

### Step 4: Report the result

After borg-ralph completes (or if it fails), tell the user:

```
borg-ralph loop finished.

To check status:    borg status
To view changes:    borg diff $ARGUMENTS
To merge locally:   borg merge $ARGUMENTS
To create PR:       borg merge $ARGUMENTS --pr
```

## Key Point

**You are an orchestrator, not an implementer.** Your job is to run the `borg-ralph` script which will spawn other agents to do the actual coding work. Do not read the implementation spec and start coding - that's what the spawned agents will do.
