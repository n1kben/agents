# API Design

Design APIs as contracts.

Good APIs express intent, make correct usage natural and evolve safely.

## Express the model

Model domain concepts explicitly.

Replace primitives with value objects when the domain gives them meaning.

Make impossible states impossible.

## Parse, don't validate

Treat parsing as the boundary between untrusted and trusted data.

Construct trusted values once.

Push errors toward construction instead of every use.

## Design for the pit of success

Make the common path the correct path.

Expose capabilities instead of implementations.

Prefer small, cohesive interfaces.

## Evolution

Prefer additive change.

Preserve backwards compatibility whenever practical.

Respect Hyrum's Law: every observable behaviour becomes part of your API.

## Smells

- Primitive obsession.
- Boolean blindness.
- Flag arguments.
- Stringly typed APIs.
- Large interfaces.
- Leaking implementation details.
- Runtime checks protecting invariants.

Every runtime check is a design opportunity.
