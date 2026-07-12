---
description: Run the full Shipkit pipeline — detect, plan, architect, build, review, ship
allowed-tools: ["Read", "Write", "Edit", "Glob", "Grep", "Bash"]
---

# Ship Command

Execute the Shipkit 6-phase pipeline on the given task.

## Task
$ARGUMENTS

## Pipeline

Follow these phases IN ORDER. Stop if any phase fails.

### Phase 1: Detect
Parse the request, classify intent/domain/scope, search for existing patterns.

### Phase 2: Plan
Break into atomic subtasks (≤30 min each), define acceptance criteria, flag risks.

### Phase 3: Architect
Design within existing patterns, validate interfaces, check dependencies.

### Phase 4: Build
Implement subtasks in order. Run tests after each. Follow code style exactly.

### Phase 5: Review
Security, quality, performance, accessibility checks. Reference file:line for issues.

### Phase 6: Ship
Run full test suite, build for production, create PR with structured description.

## Rules
- Never skip a phase
- If any phase fails, stop and report
- Never ship without passing review
- Use conventional commits
- Keep commits atomic (≤5 files)
