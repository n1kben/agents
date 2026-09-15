---
name: api-standards
description: Standards for APIs that express caller intent, make invalid use difficult, and account for how callers update.
disable-model-invocation: true
---

## Start with caller code

The normal call should show what the caller wants to accomplish. Each operation should have one meaning. Common use should not require advanced configuration. Add options only when a real caller needs them.

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

## Remove work from callers

An API should handle mechanics that every caller would otherwise repeat. It should accept the rules or data that vary between callers instead of hiding those choices.

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

## Match the contract to how it changes

A closed contract can encode every valid case and reject everything else. This gives callers stronger guarantees, but adding a case becomes a breaking change.

When the provider and all callers ship together, prefer the contract that states the invariants most precisely. Update the contract and its callers in the same change.

When callers update separately or data outlives a release, future changes may matter more than exhaustive handling. Allow unknown fields or cases when consumers can preserve, ignore, or safely reject them. Keep old and new contracts able to coexist when the rollout requires it.

For example, code that ships together can use a closed type:

```text
Status = Draft | Published
```

A stored or external contract can retain a value introduced by a newer producer:

```text
Status = Known(Draft | Published) | Unknown(String)
```

Choose this tradeoff from the release process and the cost of an unknown case. Do not weaken a contract for changes that its consumers will never need to accept.
