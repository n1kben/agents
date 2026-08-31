---
name: writing-code
description: Concrete code, vertical slice architecture, low coupling. Use when writing or changing code.
---

Write concrete code using vertical slice architecture. Feature code lives with the use case, not in technical-layer buckets.

Keep high cohesion and low coupling. Coupling is the root of change pain.

Use implementation style inside the slice. Read [`implementation-style.md`](implementation-style.md).

## Abstraction

Local abstraction and shared abstraction are different moves. Local abstraction creates a boundary inside one use case; shared abstraction creates file/module coupling between use cases.

Read [`boundary-style.md`](boundary-style.md) when extracting code or introducing a seam.

Read [`coupling-style.md`](coupling-style.md) when sharing code between modules or use cases.

DRY is considered harmful by default: the wrong abstraction costs more than duplication.
