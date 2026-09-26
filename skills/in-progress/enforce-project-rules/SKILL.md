---
name: enforce-project-rules
description: Turn an explicit project rule or recurring correction into an automated check. Use only when `enforce-project-rules` is specifically mentioned.
disable-model-invocation: true
---

# Enforce project rules

Define one invalid example and its valid counterpart. Then choose the first option that can enforce
the rule without distorting the design:

1. A type or API that cannot represent the invalid case.
2. A compiler, lint, or build rule.
3. A runtime check at the boundary.
4. A CI script when the existing tools cannot enforce it.

Use the project's existing tools when possible. Keep its current rules and configuration. Prove
that the invalid example fails and the valid example passes. Report existing violations instead of
weakening the check.

Keep written instructions only for rules that require judgment. Remove an instruction when an
automatic check has made it redundant.

## Bundled lint rules

Apply these only when the user asks for the bundled rules.

For every owned source language:

- No comments of any kind, including documentation and lint-suppression comments.

Read the references that match the project:

- [React](references/react.md) for React source.
- [Swift](references/swift.md) for Swift source.
- [TypeScript](references/typescript.md) for TypeScript source.

Use syntax-aware checks so comment-like text inside strings or URLs remains valid. If a language
has no linter, choose one that fits its existing toolchain.
