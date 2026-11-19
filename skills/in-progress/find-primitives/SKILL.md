---
name: find-primitives
description: Use only when "find primitives" is specifically mentioned.
disable-model-invocation: true
---

Break it down with me from first principles to its primitives, and show what doesn't belong. Propose a breakdown, then refine it together.

A primitive:

- Is essential: it exists because of the problem, not the code or tools.
- Is parametric: it works for any type and knows nothing about what it holds.
- Is lawful: a few laws describe all its behavior.
- Is orthogonal: it can't be built from the others and doesn't depend on them.
- Is small: a few core operations, everything else derived from them.
- Is total: defined for every input, with no special cases.
- Is canonical: each concept has one representation.
