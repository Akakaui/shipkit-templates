---
description: Review current changes against Shipkit quality standards
---

# /review

Run the Shipkit Review phase on current uncommitted changes:

1. Check git diff for all modified files
2. Run security checks (secrets, injection, XSS)
3. Verify code quality (function length, file length, types)
4. Check test coverage for changed logic
5. Validate error handling
6. Check performance implications

Output structured review with PASS/FAIL verdict and specific issues.
