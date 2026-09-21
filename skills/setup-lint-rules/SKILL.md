---
name: setup-lint-rules
description: Set up project lint rules from a short list of forbidden JavaScript, React, and TypeScript patterns.
---

# Set up lint rules

Turn the rules below into enforceable lint checks in the target repository. Follow its existing lint setup and package manager. Use Oxlint if the repository has no linter. Keep existing rules and configuration.

## All JavaScript and TypeScript source

- No comments: `//`, `/* */`, JSDoc, or lint-disable comments.

Read the applicable reference files:

- [React](references/react.md) for React source.
- [TypeScript](references/typescript.md) for TypeScript source.

Implement rules with the project's linter. Use syntax-aware checks; do not ban text inside strings or URLs. Run lint and verify that each forbidden pattern fails and a valid counterpart passes. Report any existing violations without weakening the rules.
