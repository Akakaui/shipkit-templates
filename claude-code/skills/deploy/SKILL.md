---
name: deploy
description: Run the Ship phase: tests, build, PR creation. Use when code is ready to ship.
---

# Deploy / Ship Phase

1. Run full test suite
2. Build for production
3. Generate changelog entry
4. Create PR with structured description:
   - What changed
   - Why it changed
   - How to test
   - Breaking changes (if any)

## Rules
- Never ship with failing tests
- Never ship without lint passing
- Always include rollback instructions for breaking changes
