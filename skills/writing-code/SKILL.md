---
name: writing-code
description: Concrete code, vertical slice architecture, zero sharing. Use when writing or changing code.
---

Write concrete code using vertical slice architecture. Feature code lives with the use case, not in technical-layer buckets.

Keep high cohesion and low coupling. Coupling is the root of change pain.

Use implementation style inside the slice. Read [`implementation-style.md`](implementation-style.md).

Abstraction and sharing are different moves. Abstract to shrink a reasoning world; share only when duplicated knowledge proves shared meaning.

DRY is considered harmful until sharing earns itself. Default to zero sharing: the wrong abstraction costs more than duplication. Read [`sharing-style.md`](sharing-style.md) before creating shared code.

Local abstraction is refactoring, not implementation. Read [`abstraction-style.md`](abstraction-style.md) when the user asks for abstraction work or a refactoring step needs a boundary.

