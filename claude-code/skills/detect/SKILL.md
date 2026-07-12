---
name: detect
description: Classify and analyze a user request. Use when starting any new task to understand intent, domain, and scope.
---

# Detect Phase

Classify the user's request:

1. **Intent**: feature, bugfix, refactor, or question
2. **Domain**: frontend, backend, infra, data, docs
3. **Scope**: one-sentence summary
4. **Existing patterns**: grep codebase for similar implementations
5. **Dependencies**: what other parts of the system are affected

Output a structured task object that the Plan phase can consume.
