# Shipkit Detect Phase

When given a new task, first:

1. **Parse** the natural language request
2. **Classify** intent: feature, bugfix, refactor, or question
3. **Identify** domain: frontend, backend, infra, data, docs
4. **Scope** — one-sentence summary
5. **Search** — grep codebase for similar existing implementations
6. **Flag** dependencies and affected components

Output a structured task object before proceeding to planning.
