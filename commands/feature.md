---
description: Create a feature spec through an interactive interview process
---

# /feature

Create a detailed feature specification through an interactive interview process.

## Usage

```
/ralph-borg:feature <feature-name> [options]
```

## Arguments

- `feature-name` (required): Name of the feature to spec (e.g., `user-auth`, `payment-flow`)

## Options

- `--skip-interview`: Skip interview, use SPEC.md context only
- `--template <path>`: Use custom implementation template

## What This Command Does

1. Reads context from `specs/SPEC.md` if it exists
2. Conducts an interview to understand the feature requirements
3. Creates `specs/<feature-name>.md` with feature specification
4. Creates `specs/<feature-name>.implementation.md` with phased implementation plan

## Instructions

When this command is invoked:

### Step 1: Validate Feature Name

- Feature name should be kebab-case (e.g., `user-auth`, not `userAuth`)
- Check if `specs/<feature-name>.md` already exists; if so, ask to overwrite or rename

### Step 2: Gather Context

Read the following files for context:
- `specs/SPEC.md` - Product vision and overview (source of truth)
- `specs/README.md` - Index of all specifications
- `CLAUDE.md` - Project-specific instructions
- `package.json` / `Cargo.toml` / `go.mod` - Detect project type

### Step 3: Conduct Feature Interview

Use the spec-workflow skill to interview the user about:

1. **Purpose**: What problem does this feature solve?
2. **User Stories**: Who uses it and how?
3. **Scope**: What's in/out of scope for v1?
4. **Dependencies**: What existing code/APIs does it need?
5. **Technical Approach**: Preferred patterns, libraries, or constraints?
6. **Success Criteria**: How do we know it's done?

### Step 4: Generate Feature Spec

Create `specs/<feature-name>.md` with:
- Feature overview
- User stories
- Functional requirements
- Non-functional requirements (if any)
- Out of scope items
- Dependencies

### Step 5: Generate Implementation Plan

Create `specs/<feature-name>.implementation.md` with:
- Phased implementation approach
- Each phase has:
  - Clear objective
  - Specific tasks with checkboxes `[ ]`
  - Success criteria
- Phases should be small (completable in one agent session)
- Typically 3-6 phases per feature

### Step 6: Output Summary

```
Feature spec created!

Files:
  - specs/<feature-name>.md (feature specification)
  - specs/<feature-name>.implementation.md (implementation phases)

Next steps:
  Run /ralph-borg:implement <feature-name> to start implementation

Or run directly:
  borg-ralph loop <feature-name> specs/<feature-name>.implementation.md
```

## Example Interview Flow

```
/ralph-borg:feature user-auth

> What problem does this feature solve?
Users need to log in to access protected resources.

> Who uses it and what's their workflow?
End users: sign up, log in, log out, password reset
Admins: view user list, disable accounts

> What's in scope for v1? What's explicitly out?
In: Basic email/password auth, JWT tokens, protected routes
Out: OAuth providers, 2FA, admin panel

> Any technical constraints or preferences?
Use existing Express app, store in PostgreSQL, bcrypt for passwords

> How will we know it's complete?
- Users can sign up and log in
- Protected routes reject unauthenticated requests
- Tokens expire and refresh correctly
```

## Error Handling

- If no feature name provided, prompt for one
- If specs/SPEC.md doesn't exist, suggest running `/ralph-borg:init` first
- If interview is interrupted, save partial progress
