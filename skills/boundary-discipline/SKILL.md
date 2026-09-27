---
name: boundary-discipline
description: Use only when `boundary-discipline` is specifically mentioned.
---

# Boundary discipline

Start with one complete, observable use case in one file. Let the file grow. Length alone is not a
reason to split it.

## Earn a boundary

Extract a rule when it is hard to get right, causes recurring bugs, is implemented inconsistently,
or is worth testing alone. One caller is enough.

Use the smallest construct that gives the rule one authoritative definition, preferably a pure
function. Its interface should hide a decision, enforce a guarantee, or change the representation.

Repeated syntax is not a reason to abstract. Keep ordinary orchestration local. Duplicate code when
callers have different reasons to change. Do not add extension points for callers that do not exist.

## Move decisions up

Move policy conditionals to the highest level that can select a complete behavior. Choose the path
once instead of passing flags or modes through lower layers. Keep conditionals that enforce a local
invariant inside the abstraction that owns it.

## Remove bad boundaries

Inline, split, or shrink an abstraction when it:

- forwards the same inputs and outputs;
- exists only to remove duplicate syntax;
- uses flags or option bags to combine unrelated workflows;
- couples callers with different reasons to change;
- has no clear owner;
- makes one use case require tracing unrelated files.

Keep rules with different invariants, failure modes, lifecycles, or owners separate. Avoid generic
shared and utilities modules.

## Count the cost

Every abstraction adds a name, call, dependency, and place to change. Keep it only when it prevents
enough mistakes or saves enough reader effort to repay that cost.

Choose data structures from how the code reads and changes them.

## Enforce the boundary

Name the owner, public entry point, and allowed dependency directions. Enforce them with module
visibility, package exports, import lint rules, or private definitions in one file. A directory is
not a boundary by itself.

Multiple files are fine when tooling blocks forbidden imports. Otherwise keep the use case together.

The creator of mutable state owns its lifetime and changes. Derive values instead of synchronizing
copies. Convert framework, transport, and storage values at the edge. Keep business rules in plain
program types.
