---
name: implementation-style
description: Code implementation style. Use when writing code.
disable-model-invocation: true
---

organize by use cases, not by techincal responsibiltiy

# Implementation Style

## Concrete first

Implement concrete code. Copy before abstracting: do not create shared code unless abstraction is the task, or the codebase already has a proven boundary.

Use default product boundaries when they fit: route, screen, page, component, API endpoint, command, handler, job, test, preview.

Reuse existing domain concepts. Preserve names, types, IDs, parsers, states, and workflows already present; reuse follows shared meaning, not similar shape.

## Types carry facts

Make important facts visible in types and signatures. Use result types, error pairs, typed throws, checked effects, branded values, units, enums, tagged unions, and resource handles.

Use explicit failure for expected outcomes. Do not hide them in untyped throws, panics, rejected promises, logs, nulls, or magic sentinels.

Use checked capabilities, not ambient dependencies. A dependency is explicit only when the function, component, handler, constructor, or effect contract says it needs it, and tooling checks that it is provided.

Typed ambient storage is still ambient. React Context, SwiftUI Environment, process env, globals, singletons, and service locators hide dependency requirements when callers can use the code without satisfying them.

Make illegal states unrepresentable. Prefer variants, tagged unions, enums, branded IDs, and domain values over boolean flags, optional-field soup, primitive obsession, and unchecked casts.

If an unsafe escape hatch is necessary, keep it local. State the invariant that makes it safe.

## Narrow as you go

Parse, don’t validate. Turn uncertain input into known data before the rest of the code depends on it.

As code goes deeper, the possible world should get smaller. Resolve optionals, translate external errors, eliminate sentinels, and handle exceptional cases once.

Keep behavior explicit. Use guard clauses, exhaustive switches, direct sequencing, and named options for behaviorally significant defaults.

## Effects are controlled

Separate effects from computation. Prefer read → compute → write; pull time, randomness, network, storage, and environment access away from deterministic logic.

Make effects safe to retry and interrupt. Use idempotency keys, operation IDs, explicit completion states, bounded retries, and clear handling for partial success or unknown outcome.

Bound work. Queues, buffers, batches, payloads, concurrency, accumulated results, retries, polling, and loops need explicit limits and behavior when the limit is reached.

Keep state and resources owned. Mutable state, transactions, files, timers, locks, connections, and async tasks need one obvious owner and one obvious cleanup path.

Keep transactions short. Do not hold a transaction across network calls, user interaction, or long-running work.

## Visual code is inspectable

For visual code, always create an isolated way to see and test it. Use a story, preview, sandbox, fixture, or equivalent.
