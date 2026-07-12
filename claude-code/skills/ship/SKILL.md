---
name: ship
description: Execute the full Shipkit pipeline. Use when the user says "ship this", "ship it", "run pipeline", or wants to go from idea to deployed code.
---

# Shipkit Pipeline

Execute the 6-phase pipeline in order:

1. **Detect** — Classify the request, identify domain, check for existing patterns
2. **Plan** — Break into atomic subtasks with acceptance criteria
3. **Architect** — Design within existing patterns, validate interfaces
4. **Build** — Implement subtasks, run tests after each
5. **Review** — Security, quality, performance, accessibility checks
6. **Ship** — Run full test suite, build, create PR

## Usage
The user can say:
- `ship this feature` — runs the full pipeline
- `ship fix for login bug` — runs pipeline with bugfix intent
- `ship review` — runs only the Review phase on current changes

## Output
Each phase produces structured output. The next phase consumes it.
If any phase fails, stop and report. Do not proceed to the next phase.
