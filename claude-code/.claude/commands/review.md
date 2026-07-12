---
description: Run Shipkit review phase on staged changes or a specific file
allowed-tools: ["Read", "Glob", "Grep", "Bash"]
---

# Review Command

Run a Shipkit quality review on the specified scope.

## Scope
$ARGUMENTS

If no arguments provided, review staged changes (`git diff --cached`).

## Review Checklist

### Security
- No secrets, keys, or tokens
- Input sanitization
- Parameterized queries
- XSS protection

### Code Quality
- Functions <30 lines
- Files <300 lines
- No `any` types
- Error handling complete
- No deprecated APIs

### Performance
- No N+1 queries
- Appropriate caching
- No unnecessary re-renders

### Testing
- Unit tests for business logic
- Integration tests for APIs
- Proper test naming

## Output
REVIEW:
  verdict: [PASS|FAIL]
  issues: [list with file:line, severity, description, suggestion]
