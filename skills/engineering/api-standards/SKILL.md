---
name: api-standards
description: Shape and review APIs and their contracts from the caller's perspective. Use only when `api-standards` is specifically mentioned.
---

## Separate simple and advanced use

Keep the main API focused on normal use. Put lower-level controls needed by fewer callers in a separate advanced API. Callers of the main API should not need to learn or supply those controls.

The advanced API should expose its controls directly. Let both APIs accept the same core values when possible so callers can switch without translating their data.

For example, keep the normal operation direct:

```text
Messages.send(message)
```

Put lower-level choices in a separate API:

```text
Messages.Advanced.send(message, transport, retryPolicy)
```

## Pass data, not control flow

Arguments should provide the data an operation needs. Do not use an argument to select among separate operations hidden behind one function.

When the caller already knows which behavior it wants, move the conditional to the caller and expose a named operation for each behavior.

Instead of:

```text
save(document, mode)
```

prefer named operations:

```text
saveDraft(document)
publish(document)
```

Keep a mode argument only when the mode is part of the domain data and the operation has the same meaning in every mode.

## Make the contract explicit

State the inputs, outputs, expected failures, and invariants. Use types that admit only valid states when the language allows it. Parse external data once at the boundary.

Expected failures belong in the contract. A broken invariant is a defect.

For example, this contract names both its result and its expected failure:

```text
reserve(stock, quantity) -> Result<Reservation, InsufficientStock>
```

## Own the mechanics, expose the choices

Move repeated mechanics into the API. Keep decisions that vary between callers explicit. The caller describes what it wants, and the API handles how to produce it.

Elm's URL parser follows this split. The caller describes its routes:

```text
route = oneOf(
  map(Home, top),
  map(Blog, segment("blog") / int)
)
```

The API applies that description to a URL:

```text
result = Url.Parser.parse(route, url)
```

`Url.Parser` owns traversal and matching. The caller owns the routes and the values they produce. Adding a route changes the route description without adding more parsing machinery.

## Match the contract to where it is used

Contracts that cross release boundaries must let old and new code coexist. Continue accepting inputs that were previously valid. Continue producing outputs that satisfy existing guarantees.

Design these contracts for additive change. Records can gain fields when readers tolerate unknown information. Closed unions and enums require callers to handle each new case. Requiredness, nullability, defaults, and meaning are compatibility guarantees too.

Contracts whose producers and consumers ship together can use more precise types and change them in one release.
