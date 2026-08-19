# Vertical Slice Design

A slice is a tracer bullet.

Each slice should deliver value independently while proving the architecture end-to-end.

## Vertical slices

Prefer end-to-end slices over technical phases.

Each slice should be independently valuable, releasable and testable.

## Walking skeleton

Prove the architecture with the thinnest possible end-to-end implementation.

## Safe evolution

Prefer feature flags, backwards compatibility, expand-and-contract migrations and parallel change when they reduce delivery risk.

Favor reversible changes.

## Smells

- Horizontal slices.
- Big bang releases.
- Long-lived branches.
- Slices without user value.
- Irreversible migrations.

A slice is done when it is live, not when the code works.
