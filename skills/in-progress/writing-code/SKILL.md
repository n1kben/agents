---
name: writing-code
description: Always use when writing code.
---

Write concrete code using vertical slice architecture. Feature code lives with the use case, not in technical-layer buckets. Keep high cohesion and low coupling, because coupling is the root of change pain.

DRY is considered harmful. The wrong abstraction costs more than duplication. Default to zero sharing and use the rule of three to guide when to introduce sharing. Read [`sharing-style.md`](sharing-style.md) when making decision on ...?

Avoid using abstractions in the first pass, Read [`implementation-style.md`](implementation-style.md) on how to write concrete code.

When the implemention is good, we can start looking at creating local abstractions, refactring, read
read [`abstraction-style.md`](abstraction-style.md) and judge whether the boundary earns its indirection.
