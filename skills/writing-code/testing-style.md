# Testing Style

Test at the highest useful seam. Prefer the use case boundary: route, handler, command, screen, component, job, or public module API.

Test observable behavior, not implementation. Assert outputs, errors, persisted state, emitted messages, UI behavior, or other visible effects.

Avoid implementation-coupled tests. Renaming an internal function, changing call order, or splitting a helper should not break tests when behavior is unchanged.

Avoid tautological tests. Expected values should come from the spec, a worked example, or a literal fixture, not from recomputing the production logic.

Mock system boundaries, not your own modules. Fake external APIs, time, randomness, filesystem, network, and slow infrastructure; keep internal collaborators real when practical.

Test invariants and concurrency where they matter. Cover impossible states, bounds, retries, idempotency, race conditions, and partial failure.

Make UI inspectable in isolation. Use previews, Storybook, sandboxes, fixtures, or fake capabilities so visual behavior can be seen and interacted with without the whole app.
