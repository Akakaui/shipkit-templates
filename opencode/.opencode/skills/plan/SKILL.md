# Shipkit Planning Phase

## Detect Phase
1. Parse the natural language request
2. Classify intent: feature, bugfix, refactor, or question
3. Identify domain: frontend, backend, infra, data, docs
4. Search codebase for similar existing implementations
5. Flag dependencies and affected components

## Plan Phase
1. Break into atomic subtasks (max 30 min each)
2. Identify files to create, modify, or delete
3. Define acceptance criteria per subtask
4. Estimate complexity: simple, moderate, complex
5. Flag risks and unknowns

## Output Format
```
TASK:
  type: [feature|bugfix|refactor|question]
  domain: [frontend|backend|infra|data|docs]
  scope: [1-sentence summary]
  files_touched: [list]

SUBTASKS:
  1. [subtask] — complexity: [simple|moderate|complex] — files: [...]

RISKS:
  - [risk]

ACCEPTANCE_CRITERIA:
  - [ ] [criterion]
```

## Rules
- Never skip detection. Always classify before planning.
- Never assume. If ambiguous, output clarifying questions.
- Check existing code before proposing new patterns.
- Keep subtasks atomic and independently testable.
