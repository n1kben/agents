# Domain Modeling

Model the business, not the software.

## Ubiquitous Language

Treat the ubiquitous language as the model. Refine names until domain experts and developers mean the same thing.

If the business wouldn't say it, neither should the model.

## Discover the model

Discover concepts instead of inventing abstractions.

Reach for examples before abstractions. Event Storming and Example Mapping often reveal concepts, boundaries and events that are otherwise hidden.

## Concepts

Model entities, value objects, domain events, aggregates and policies when they clarify the domain.

Use aggregates to protect invariants, not organize code.

## Boundaries

Respect bounded contexts.

Separate concepts that evolve independently instead of forcing one shared model.

Make relationships between contexts explicit.

## Smells

- Implementation language replacing business language.
- Anemic models.
- Leaking bounded contexts.
- Shared models spanning unrelated concepts.
- Business rules scattered throughout the application.

The software serves the model, never the other way around.
