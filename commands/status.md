---
description: Show the progress of all feature implementations
---

# /status

Show the progress of all feature implementations.

## Usage

```
/ralph-borg:status [feature-name]
```

## Arguments

- `feature-name` (optional): Show detailed status for a specific feature

## What This Command Does

1. Scans `specs/` directory for implementation files
2. Parses phase checkboxes to determine progress
3. Checks borg status for running agents
4. Displays formatted status report

## Instructions

When this command is invoked:

### Step 1: Scan for Features

Find all files matching `specs/*.implementation.md`.

For each file, extract:
- Feature name (from filename)
- Total phases (count of `## Phase` headers)
- Completed phases (count of `[x]` checkboxes)
- Pending phases (count of `[ ]` checkboxes)

### Step 2: Check Running Agents

Run `borg status` to check for active agents.

Match running agents to features by branch name (`borg/<feature-name>`).

### Step 3: Format Status Report

Display a status table:

```
Feature Status
==============

Feature          Progress    Status       Branch
-------          --------    ------       ------
user-auth        [####--]    5/7 phases   borg/user-auth (running)
payment-flow     [######]    4/4 phases   borg/payment-flow (complete)
notifications    [------]    0/3 phases   (not started)

Legend:
  # = completed phase
  - = pending phase

Summary:
  Total features: 3
  Complete: 1
  In progress: 1
  Not started: 1
```

### Step 4: Detailed View (specific feature)

If a feature name is provided, show detailed status:

```
Feature: user-auth
==================

Spec:           specs/user-auth.md
Implementation: specs/user-auth.implementation.md
Branch:         borg/user-auth
Status:         In Progress (5/7 phases)

Phases:
  [x] Phase 1: Set up database schema
  [x] Phase 2: Create user model
  [x] Phase 3: Implement registration endpoint
  [x] Phase 4: Implement login endpoint
  [x] Phase 5: Add JWT token generation
  [ ] Phase 6: Implement token refresh
  [ ] Phase 7: Add protected route middleware

Agent Status: Running (PID 12345)
Current Cost:  $0.42
Elapsed Time:  8m 32s

Commands:
  borg logs user-auth      # View agent output
  borg diff user-auth      # See changes so far
  borg status --watch      # Monitor in real-time
```

### Step 5: Show Next Actions

At the end of the status report, suggest next actions:

```
Next actions:
  /ralph-borg:implement notifications   # Start pending feature
  borg merge payment-flow --pr          # Merge complete feature
```

## Error Handling

- If no implementation files found, suggest running `/ralph-borg:init` and `/ralph-borg:feature`
- If specs/ directory doesn't exist, show helpful setup message
- If borg is not initialized, note that status is from spec files only
