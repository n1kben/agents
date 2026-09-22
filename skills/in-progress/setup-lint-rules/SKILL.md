---
name: setup-lint-rules
description: Set up language-independent and language-specific lint rules in a project.
---

# Set up lint rules

Turn the rules below into enforceable lint checks in the target repository. Identify its languages and use its existing lint tools. If a language has no linter, choose a suitable one for that language. Keep existing rules and configuration.

## All source languages

- No comments of any kind, including documentation and lint-suppression comments.

Read the applicable reference files:

- [React](references/react.md) for React source.
- [Swift](references/swift.md) for Swift source.
- [TypeScript](references/typescript.md) for TypeScript source.

Apply the universal rules to every owned source language, then add the rules from each applicable reference. Use syntax-aware checks so comment-like text inside strings or URLs remains valid. Run each affected linter and verify that each forbidden pattern fails and a valid counterpart passes. Report any existing violations without weakening the rules.
