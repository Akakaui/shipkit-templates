---
description: Run the full Shipkit pipeline on the current request
---

# /ship

Execute the 6-phase Shipkit pipeline:

1. **Detect** — Classify and analyze the request
2. **Plan** — Break into atomic subtasks
3. **Architect** — Design the solution
4. **Build** — Implement with tests
5. **Review** — Quality gate checks
6. **Ship** — Build, test, create PR

The pipeline stops if any phase fails. Report status after each phase.
