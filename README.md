# ralph-borg

<p align="center">
  <img src="ralph-borg.jpg" alt="ralph-borg" width="600">
</p>

Spec-driven development with parallel agent orchestration for Claude Code.

> "Resistance is futile. Your specs will be assimilated."

## Vision

Anyone with Claude Code + an empty repo + a SPEC.md can go from idea to implemented features using parallel agent orchestration.

## Prerequisites

**Required:**
- **Git repository** - Your project must be a git repo (`git init`)
- **Claude Code CLI** - Installed and working
- **Bash 4.0+** and **Git 2.0+**
- **gh CLI** (optional) - For creating pull requests

If you don't have a git repo yet:
```bash
mkdir my-project && cd my-project
git init
```

## Installation

### Option 1: Via Claude Code Marketplace (Recommended)

```bash
# Add the marketplace
/plugin marketplace add kiitsun-e/ralph-borg

# Install the plugin
/plugin install ralph-borg
```

Scripts are automatically available after installation - no PATH setup needed.

### Updating

To get the latest version:

```bash
/plugin marketplace update ralph-borg
/plugin update ralph-borg
```

### Option 2: Manual Installation

Clone the repository:

```bash
git clone https://github.com/kiitsun-e/ralph-borg ~/.claude/plugins/ralph-borg
```

Use the plugin with Claude Code:

```bash
claude --plugin-dir ~/.claude/plugins/ralph-borg
```

Scripts are automatically added to PATH when the plugin loads.

### Option 3: Development Mode

For local development, use the `--plugin-dir` flag:

```bash
claude --plugin-dir /path/to/ralph-borg
```

## Quick Start

```bash
# 1. Initialize your project for spec-driven development
/ralph-borg:init my-project

# 2. Edit specs/SPEC.md to describe your product vision
# (manually edit the file)

# 3. Create a detailed feature spec via interview
/ralph-borg:feature user-auth

# 4. Implement the feature with parallel agents
/ralph-borg:implement user-auth

# 5. Check progress
/ralph-borg:status

# 6. Review and merge changes
borg diff user-auth
borg merge user-auth --pr
```

## User Workflows

### Workflow A: Full Scaffolding (New Projects)

For users starting from scratch:

```bash
# Create and initialize project
mkdir my-app && cd my-app && git init

# Full scaffolding
/ralph-borg:init my-app        # Creates specs/, SPEC.md, CLAUDE.md
# Edit specs/SPEC.md with your vision
/ralph-borg:feature auth       # Interview -> specs/auth.md
/ralph-borg:implement auth     # Build with parallel agents
```

### Workflow B: Bring Your Own Spec (Proactive Planners)

For users who prefer to create their own specifications:

```bash
# You already have a git repo with your own specs/SPEC.md
# Just initialize borg for parallel agent orchestration
borg init .

# Extract features from YOUR spec via interview
/ralph-borg:feature user-auth

# Implement
/ralph-borg:implement user-auth
```

**What goes in your SPEC.md:**
- Product vision and goals
- Feature descriptions
- Technical stack preferences
- Constraints and non-goals

### Workflow C: Implementation Only

For users with existing specs who just want orchestration:

```bash
# You have specs/feature.implementation.md already
borg init .
borg-ralph loop my-feature specs/my-feature.implementation.md
```

### Entry Points Summary

| You have... | Start with... |
|-------------|---------------|
| Empty repo | `/ralph-borg:init` |
| Your own SPEC.md | `borg init .` then `/ralph-borg:feature` |
| Feature specs (.md) | `/ralph-borg:implement` |
| Implementation plans (.implementation.md) | `borg-ralph loop` directly |

## Commands

### /ralph-borg:init

Initialize a spec-ready project structure.

```bash
/ralph-borg:init [project-name]
```

Creates:
- `specs/SPEC.md` - Product vision and requirements (source of truth)
- `specs/README.md` - Index and workflow guide
- `CLAUDE.md` - Project instructions

### /ralph-borg:feature

Create a feature specification through interactive interview.

```bash
/ralph-borg:feature <feature-name>
```

Produces:
- `specs/<feature-name>.md` - What to build
- `specs/<feature-name>.implementation.md` - How to build it (phases)

### /ralph-borg:implement

Run the borg-ralph loop to implement a feature.

```bash
/ralph-borg:implement <feature-name>
```

This spawns isolated agents (one per phase) that work in parallel branches.

### /ralph-borg:status

Show progress of all feature implementations.

```bash
/ralph-borg:status
/ralph-borg:status <feature-name>  # Detailed view
```

## How It Works

```
┌──────────────────────────────────────────────────────────────────────────────┐
│  1. /ralph-borg:init            → specs/SPEC.md, specs/README.md, CLAUDE.md  │
│  2. User edits specs/SPEC.md    → Define product vision                      │
│  3. /ralph-borg:feature auth    → specs/auth.md + auth.implementation.md     │
│  4. /ralph-borg:implement auth  → borg-ralph loop on isolated branch         │
│  5. borg merge auth --pr        → PR created, feature complete               │
└──────────────────────────────────────────────────────────────────────────────┘
```

### The Refinement Flow

```
specs/SPEC.md (explores options)
    ↓
Feature Spec (makes opinionated choices)
    ↓
Implementation Plan (phased tasks)
    ↓
Implementation (builds it)
    ↓
Update CLAUDE.md + SPEC.md (reflect reality)
```

## Scripts

The plugin includes two shell scripts that power the orchestration:

### borg

Multi-agent orchestration tool for running isolated Claude Code agents.

```bash
borg init .              # Initialize workspace
borg spawn my-task       # Spawn an agent
borg status              # Show all agents
borg logs my-task        # View agent output
borg diff my-task        # Show changes
borg merge my-task --pr  # Create PR
borg clean               # Cleanup
```

### borg-ralph

Phase-based implementation loop (Ralph Loop methodology).

```bash
borg-ralph loop <slot> specs/feature.implementation.md
borg-ralph status specs/feature.implementation.md
```

Features:
- Parses phases from implementation spec
- Spawns fresh agent per phase (clean context)
- Updates checkboxes on completion
- 10-minute timeout per phase
- Tracks costs across phases

## Directory Structure

After using ralph-borg, your project will have:

```
your-project/
├── CLAUDE.md                        # Project instructions
├── specs/
│   ├── SPEC.md                      # Product vision (source of truth)
│   ├── README.md                    # Index and workflow guide
│   ├── user-auth.md                 # Feature spec
│   └── user-auth.implementation.md  # Implementation phases
├── src/                             # Your code
└── .borg/                           # Borg workspace (gitignored)
    ├── reference.git/
    ├── slots/
    ├── state/
    └── logs/
```

## Plugin Structure

```
ralph-borg/
├── .claude-plugin/
│   ├── plugin.json          # Plugin manifest
│   └── marketplace.json     # Marketplace catalog
├── commands/
│   ├── init.md              # Initialize project
│   ├── feature.md           # Create feature spec
│   ├── implement.md         # Run implementation loop
│   └── status.md            # Show progress
├── hooks/
│   └── hooks.json           # SessionStart hook for PATH setup
├── skills/
│   └── spec-workflow/       # Interview skill for specs
├── scripts/
│   ├── borg                 # Multi-agent orchestration
│   ├── borg-ralph           # Ralph Loop wrapper
│   └── setup-path.sh        # Auto-configure PATH
└── README.md
```

## Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `BORG_HOME` | `~/.borg` | Workspace directory |
| `BORG_PHASE_TIMEOUT` | `600` | Timeout per phase (seconds) |

## Troubleshooting

### Agent seems stuck

```bash
borg logs <feature-name> -f  # Follow logs
borg status --watch          # Monitor status
```

### Phase failed

Check the logs, then either:
- Fix the issue and re-run `/ralph-borg:implement`
- Manually complete the task and update the checkbox

### Want to restart

```bash
borg clean <feature-name>    # Remove agent workspace
# Reset checkboxes in .implementation.md
/ralph-borg:implement <feature-name>
```

## License

MIT
