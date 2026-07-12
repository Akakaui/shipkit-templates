# Shipkit Build Standards

## Implementation Rules
- Implement one subtask at a time
- Run relevant tests after each change
- If a subtask fails, stop and report — do not skip ahead
- Follow existing code style exactly

## Function Rules
- Max 30 lines per function
- Single responsibility
- Early returns over nested conditionals
- No magic numbers — use named constants

## File Rules
- Max 300 lines per file
- One component/class per file
- Organize: imports → types → constants → functions → exports

## Error Handling
- Always handle async errors
- Use typed error returns
- Log errors with context, never swallow silently
- Validate at boundaries, trust internal data
