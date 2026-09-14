---
name: domain-modeling
description: Build and sharpen a project's domain model. Use when discussing codebase terminology, planning features, stress-testing ideas, clarifying business rules, writing or editing a CONTEXT.md, or recording project language.
disable-model-invocation: true
---

# Domain Modeling

Actively build and sharpen the project's domain model as you design. This is the _active_ discipline: working through examples, challenging the language, and writing the glossary down the moment things crystallise.

Merely _reading_ `CONTEXT.md` for vocabulary is not this skill. This skill is for when you're changing the model, not just consuming it.

## File structure

The domain model lives in `CONTEXT.md` at the root:

```text id="u7wq2a"
/
├── CONTEXT.md
└── ...
```

Create it lazily. If no `CONTEXT.md` exists, create one when the first term is resolved.

## During the session

### Work through examples

Prefer concrete examples and counterexamples to abstract discussion. When something is unclear, make up a small scenario and ask what should happen.

Use examples to discover the model, not merely illustrate it. Probe boundaries, invariants, edge cases, and impossible states. Challenge `always`, `never`, `must`, and `only`: is this a domain invariant, or simply how things work today?

When an example doesn't fit, don't assume something is wrong. Ask what it teaches you about the model.

Work from examples toward language, then test the language with more examples.

### Sharpen the language

Treat `CONTEXT.md` as the current model, not established truth.

Challenge **similar vs same**, fuzzy or overloaded terms, hidden assumptions, and distinctions that may not actually matter. Don't collapse concepts because they look similar, and don't distinguish them merely because they have different names. A distinction should make a difference in the domain.

Treat contradictions as clues. When new information conflicts with the current model, ask whether the cases are actually different, a distinction is missing, or the existing language needs to change.

### Cross-reference with code

Use the code as another source of examples and counterexamples. When what the user says, `CONTEXT.md`, and the code disagree, surface it and work out what the disagreement teaches you about the model.

Don't assume the code is the truth. It may reflect an old model, an implementation constraint, or a case the current language doesn't yet explain.

### Update CONTEXT.md inline

When the language crystallises, update `CONTEXT.md` right there. Don't batch changes: capture them as they happen. Use the format in [CONTEXT-FORMAT.md](./CONTEXT-FORMAT.md).

`CONTEXT.md` should be totally devoid of implementation details. Do not treat it as a spec, scratch pad, or repository for implementation decisions. It is a glossary and nothing else.
