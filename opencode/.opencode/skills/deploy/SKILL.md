# Shipkit Deploy Phase

## Deployment Rules
- Run full test suite before any deployment
- Build for production environment
- Generate changelog entry from commits
- Create PR with structured description
- Never deploy without passing review phase

## PR Description Format
```
## What
[1-sentence summary]

## Why
[Reason for change]

## Changes
- [change 1]
- [change 2]

## Testing
- [ ] Unit tests pass
- [ ] Integration tests pass
- [ ] Manual testing completed

## Rollback
[How to rollback if needed]
```

## Changelog Format
- Use conventional commits: feat, fix, refactor, docs, test, chore
- Group by type
- Link to PR/issue
- User-facing changes only
