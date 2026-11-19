---
name: design-modules
description: Use only when "design modules" is specifically mentioned.
disable-model-invocation: true
---

Build the primitives up with me into deep modules. Propose where the seams go, then refine it together.

A deep module:

- Is deep: a small signature over a large implementation.
- Is cohesive: everything inside changes for one reason.
- Is self-contained: its dependencies never appear in its signature.
- Is replaceable: any implementation of its signature can stand in.
- Preserves invariants: every operation maps valid states to valid states.
- Is total: callers never handle its edge cases.
