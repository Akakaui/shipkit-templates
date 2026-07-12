---
description: Shipkit 6-phase development pipeline — enforce detect→plan→architect→build→review→ship
globs: ["**/*"]
alwaysApply: true
---

# Shipkit Pipeline — Claude Code Rules

## Pipeline Enforcement
You MUST follow these phases in order for every task:

1. **Detect** — Classify intent (feature/bugfix/refactor), domain (frontend/backend/infra), scope
2. **Plan** — Break into subtasks ≤30 min each, define acceptance criteria, flag risks
3. **Architect** — Design within existing patterns, validate interfaces, check dependencies
4. **Build** — Implement one subtask at a time, run tests after each
5. **Review** — Security, quality, performance, accessibility checks
6. **Ship** — Full test suite, build, create PR

Stop if any phase fails. Never skip a phase.

## Code Quality
- TypeScript strict mode, no `any`
- Functions <30 lines, files <300 lines
- Handle all error paths
- Validate inputs at boundaries
- Environment variables for config (never hardcode)
- Minimal comments — only non-obvious logic

## Git Standards
- Conventional commits: feat, fix, refactor, docs, test, chore
- Branch: `{type}/{ticket-id}-{slug}`
- One logical change per commit
- Never commit secrets, build artifacts, or .env files

## Security
- No secrets in code or git
- Sanitize all user inputs
- Parameterized queries only
- HTTPS only
- Rate limiting on public endpoints

## Testing
- Unit tests for business logic
- Integration tests for API endpoints
- Test naming: `should [behavior] when [condition]`
- Arrange-Act-Assert pattern

## Architecture
- Follow existing patterns before proposing new ones
- No new dependencies without justification
- Composition over inheritance
- Minimal, focused interfaces
