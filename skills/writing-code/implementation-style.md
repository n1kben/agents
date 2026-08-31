# Implementation Style

## Explicit facts

Make important facts visible in types and signatures. Use result types, error pairs, typed throws, checked effects, branded values, units, enums, tagged unions, and resource handles.

Use explicit failure for expected outcomes. Translate external exceptions, rejected promises, and provider errors into known failures where they enter your code.

Use checked capabilities, not ambient dependencies. A dependency is explicit only when the function, component, handler, constructor, or effect contract says it needs it, and tooling checks that it is provided.

Typed ambient storage is still ambient. React Context, SwiftUI Environment, process env, globals, singletons, and service locators hide requirements when callers can use the code without satisfying them.

## Narrow world

Parse, don’t validate. Turn uncertain input into known data before the rest of the code depends on it.

Make illegal states unrepresentable. Prefer variants, tagged unions, enums, branded IDs, and domain values over boolean flags, optional-field soup, primitive obsession, and unchecked casts.

As code goes deeper, the possible world should get smaller. Resolve optionals, eliminate sentinels, handle exceptional cases once, and stop accounting for eliminated cases.

Keep unsafe escape hatches local. State the invariant that makes `any`, unchecked casts, non-null assertions, or ignored errors safe.

## Controlled effects

Separate effects from computation. Prefer read → compute → write; keep time, randomness, network, storage, and environment access out of deterministic logic.

Make effects safe to retry and interrupt. Use idempotency keys, operation IDs, explicit completion states, bounded retries, and clear handling for partial success or unknown outcome.

Bound work. Queues, buffers, batches, payloads, concurrency, accumulated results, retries, polling, and loops need explicit limits and behavior when the limit is reached.

Keep state and resources owned. Mutable state, transactions, files, timers, locks, connections, and async tasks need one obvious owner and one obvious cleanup path.

Keep transactions short. Do not hold a transaction across network calls, user interaction, or long-running work.

## Explicit behavior

Keep control flow obvious. Prefer guard clauses, exhaustive switches, direct sequencing, and named options for behaviorally significant defaults.

Use names that mean the thing. Preserve existing domain names, types, IDs, parsers, states, and workflows.

For visual code, always create an isolated way to see and test it: story, preview, sandbox, fixture, or equivalent.
