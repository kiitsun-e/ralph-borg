---
description: Initialize a spec-ready project with SPEC.md template and specs/ directory
---

# /init

Initialize a spec-ready project structure for spec-driven development.

## Usage

```
/ralph-borg:init [project-name]
```

## Arguments

- `project-name` (optional): Name for the project. Defaults to the current directory name.

## What This Command Does

1. Creates `specs/` directory for specifications
2. Creates `specs/SPEC.md` - product vision and requirements (source of truth)
3. Creates `specs/README.md` - index and workflow guide
4. Creates/updates `CLAUDE.md` with ralph-borg workflow instructions
5. Initializes git repository if not already present
6. **Initializes borg workspace** by running `borg init .`

## Instructions

When this command is invoked:

### Step 1: Check Prerequisites

Check if we're in a git repository. If not, offer to initialize one.

### Step 2: Create specs/ Directory

Create the `specs/` directory if it doesn't exist.

### Step 3: Create specs/SPEC.md

If `specs/SPEC.md` doesn't exist, create it from the template at `skills/spec-workflow/templates/SPEC.template.md`.

Replace `{{PROJECT_NAME}}` with the provided project name or directory name.

### Step 4: Create specs/README.md

Create `specs/README.md` as an index file with the following content:

```markdown
# Specifications

Index of specification documents for {{PROJECT_NAME}}.

## Base Specification

| Document | Description | Status |
|----------|-------------|--------|
| [SPEC.md](./SPEC.md) | Complete product specification covering vision, features, technical architecture, and roadmap | Living document |

## Feature Specs

*Feature-specific specifications will be added here as they're created.*

| Document | Feature | Status |
|----------|---------|--------|
| | | |

## Implementation Plans

*Step-by-step implementation guides that reference their parent spec.*

| Document | Spec |
|----------|------|
| | |

## How This Works

- **SPEC.md** is the source of truth for product vision and requirements
- Feature specs are created when implementing specific sections of SPEC.md
- Each feature spec references its parent section in SPEC.md

## Spec Workflow

### The Refinement Flow

```
SPEC.md (explores options)
    ↓
Feature Spec (makes opinionated choices)
    ↓
Implementation Plan (phased tasks)
    ↓
Implementation (builds it)
    ↓
Update CLAUDE.md + SPEC.md (reflect reality)
```

### Document Roles

| Document | Purpose | Technology Stance |
|----------|---------|-------------------|
| **SPEC.md** | Product vision, explores options | Lists alternatives, doesn't mandate |
| **Feature specs** | Implementation plan for specific feature | **Opinionated** - makes specific choices |
| **CLAUDE.md** | Agent guidance for working in codebase | Reflects what's actually built |

### Why This Matters

- **SPEC.md** stays flexible for future features
- **Feature specs** make decisions so implementation can proceed without ambiguity
- **CLAUDE.md** must reflect reality or it misleads the agent

### Adding a New Feature Spec

1. Run `/ralph-borg:feature <name>` to create via interview, OR
2. Create manually: `specs/<feature-name>.md` and `specs/<feature-name>.implementation.md`
3. Add an entry to the Feature Specs table above
4. Update status as work progresses: `Draft` → `In Progress` → `Complete`

### After Implementation

When a feature is built:
1. Update **CLAUDE.md** with patterns, file locations, and working guidance
2. Update feature spec status to `Complete`
```

### Step 5: Create/Update CLAUDE.md

Create or update `CLAUDE.md` with the following content:

```markdown
# CLAUDE.md

## What This Is

{{PROJECT_NAME}} - [brief description].

## Commands

```bash
# Add your project commands here
```

## Spec Workflow

This project uses spec-driven development.

- **specs/SPEC.md** - Source of truth for product vision and requirements
- **specs/README.md** - Index of all specifications
- **specs/<feature>.md** - Feature specifications
- **specs/<feature>.implementation.md** - Phased implementation plans

### Working from Implementation Plans

When working from an implementation plan (`.implementation.md` files):

1. Before starting: read the implementation plan to understand scope
2. After completing each checkbox item: **immediately update the plan** by changing `- [ ]` to `- [x]`
3. This keeps progress visible and prevents duplicate work across sessions

## Available Commands

- `/ralph-borg:feature <name>` - Create feature spec via interview
- `/ralph-borg:implement <name>` - Run implementation loop with parallel agents
- `/ralph-borg:status` - Show all feature progress
```

### Step 6: Initialize Borg Workspace

Run this command to initialize the borg multi-agent system:

```bash
borg init .
```

This sets up the isolated agent workspace and stores the current repo path so branches can be pushed back when features complete.

If `borg` is not found, inform the user:

```
borg command not found. Run /ralph-borg:borg-setup to configure your terminal PATH.
```

### Step 7: Output Summary

After completing setup, output:

```
Spec-ready project initialized!

Created:
  - specs/SPEC.md (edit this to define your product)
  - specs/README.md (index and workflow guide)
  - CLAUDE.md (project instructions)

Next steps:
  1. Edit specs/SPEC.md to describe your product vision
  2. Run /ralph-borg:feature <name> to spec out your first feature
  3. Run /ralph-borg:implement <name> to build it with parallel agents
```

## Error Handling

- If specs/SPEC.md already exists, skip creation and inform the user
- If specs/ already exists, skip directory creation
- If CLAUDE.md exists, append ralph-borg section if not already present
