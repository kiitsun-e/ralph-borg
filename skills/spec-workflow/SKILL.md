# Spec Workflow Skill

A generalized skill for conducting feature specification interviews and generating implementation plans.

## Overview

This skill guides the creation of feature specifications through a structured interview process. It produces two artifacts:
1. A feature spec (`<feature>.md`) describing what to build
2. An implementation plan (`<feature>.implementation.md`) with phased execution steps

## Input Context

Before starting, gather context from:

- `SPEC.md` - Product vision and high-level features
- `CLAUDE.md` - Project-specific instructions and patterns
- Project config files (`package.json`, `Cargo.toml`, `go.mod`, etc.)
- Existing code structure and patterns

## Interview Process

### Phase 1: Problem Definition

Ask the user:
- "What problem does this feature solve?"
- "Who is the primary user of this feature?"
- "What's the current workaround (if any)?"

### Phase 2: User Stories

Ask the user:
- "Walk me through the main user workflow"
- "Are there different user types with different needs?"
- "What edge cases should we consider?"

### Phase 3: Scope Definition

Ask the user:
- "What's the minimum viable version (v1)?"
- "What's explicitly out of scope?"
- "Are there any hard constraints (time, tech, etc.)?"

### Phase 4: Technical Context

Ask the user:
- "What existing code or APIs does this depend on?"
- "Any preferred libraries or patterns?"
- "Are there security or performance requirements?"

### Phase 5: Success Criteria

Ask the user:
- "How will we know this feature is complete?"
- "What tests should pass?"
- "Any metrics to track?"

## Output: Feature Spec

Generate `specs/<feature-name>.md`:

```markdown
# Feature: <Feature Name>

## Overview

<2-3 sentence description of the feature>

## Problem Statement

<What problem this solves and for whom>

## User Stories

### <User Type 1>
- As a <user>, I want to <action> so that <benefit>
- ...

### <User Type 2> (if applicable)
- ...

## Functional Requirements

1. <Requirement 1>
2. <Requirement 2>
3. ...

## Non-Functional Requirements (if any)

- Performance: <requirements>
- Security: <requirements>
- ...

## Out of Scope

- <Item 1>
- <Item 2>

## Dependencies

- <Existing code/APIs required>
- <External services>

## Success Criteria

- [ ] <Criterion 1>
- [ ] <Criterion 2>
- ...
```

## Output: Implementation Plan

Generate `specs/<feature-name>.implementation.md`:

```markdown
# Implementation: <Feature Name>

## Overview

This document outlines the phased implementation of <feature name>.

---

## Phase 1: <Phase Title>

**Objective:** <What this phase accomplishes>

### Tasks

- [ ] <Task 1>
- [ ] <Task 2>
- [ ] <Task 3>

### Success Criteria

- <How to verify this phase is complete>

---

## Phase 2: <Phase Title>

**Objective:** <What this phase accomplishes>

### Tasks

- [ ] <Task 1>
- [ ] <Task 2>

### Success Criteria

- <How to verify this phase is complete>

---

(Continue for each phase...)

---

## Verification

Final checks before feature is complete:
- [ ] All phases completed
- [ ] Tests passing
- [ ] Documentation updated
- [ ] Code reviewed
```

## Phase Design Guidelines

When creating phases:

1. **Keep phases small**: Each phase should be completable by a single agent in one session (typically 10-30 minutes of work)

2. **Make phases independent**: Where possible, phases should not depend on later phases being complete

3. **Front-load foundations**: Put setup, config, and infrastructure in early phases

4. **Isolate risky work**: Put experimental or uncertain work in its own phase

5. **End with integration**: Final phase should wire everything together and verify

6. **Typical phase count**: Most features have 3-6 phases

### Example Phase Breakdown

For a "user authentication" feature:

```
Phase 1: Database & Models
  - Create users table migration
  - Create User model with validation
  - Add password hashing

Phase 2: Registration Flow
  - Create registration endpoint
  - Add input validation
  - Return user on success

Phase 3: Login Flow
  - Create login endpoint
  - Verify credentials
  - Return JWT token

Phase 4: Authentication Middleware
  - Create auth middleware
  - Verify JWT tokens
  - Attach user to request

Phase 5: Integration & Testing
  - Add protected route examples
  - Write integration tests
  - Update API documentation
```

## Project Type Detection

Auto-detect project type to customize recommendations:

| File | Project Type | Suggestions |
|------|--------------|-------------|
| `package.json` | Node.js/TypeScript | Express patterns, Jest tests |
| `Cargo.toml` | Rust | Actix/Axum patterns, cargo test |
| `go.mod` | Go | Standard library, go test |
| `pyproject.toml` | Python | FastAPI/Django, pytest |
| `Gemfile` | Ruby | Rails patterns, RSpec |

## Interview Tips

- Keep questions conversational, not interrogative
- Summarize understanding before moving to next phase
- Offer reasonable defaults based on context
- Note uncertainties to address in implementation
- Don't over-engineer v1; note future enhancements separately
