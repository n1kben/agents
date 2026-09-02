---
name: writing-code
description: Concrete code, vertical slice architecture, testing seams, low coupling. Use when writing or changing code.
disable-model-invocation: true
---

# Writing Code

## Vertical slices

Write concrete code using vertical slice architecture. Feature code lives with the use case, not in technical-layer buckets.

Keep high cohesion and low coupling. Coupling is the root of change pain.

## Coding style

Use implementation style inside the slice. Read [`implementation-style.md`](implementation-style.md).

## Testing style

Use testing style for checks after code exists. Read [`testing-style.md`](testing-style.md) when adding tests, previews, stories, sandboxes, fixtures, or concurrency/invariant checks.

## Abstraction style

Local abstraction creates a boundary inside one use case. Read [`boundary-style.md`](boundary-style.md) when extracting code, designing a deep module, or introducing a seam.

## Coupling style

Shared abstraction creates file/module coupling between use cases. Read [`coupling-style.md`](coupling-style.md) when sharing code between modules or use cases.

DRY is considered harmful by default: the wrong abstraction costs more than duplication.
