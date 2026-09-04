# Review The Result

Look for useful abstractions. Start local, then consider sharing.

## Local abstraction

A local boundary stays inside one use case. It earns its indirection when it hides more knowledge than it adds; reuse is not required.

- **Wide input**: an operation uses only a valid subset of a large entity and repeatedly excludes irrelevant states. → introduce a narrow model, such as `Reservation` → `CancellationCandidate`.
- **Decision inside machinery**: policy is embedded in I/O, time, storage, loops, or retries. → extract a pure decision, such as `read → decideCancellation → save`.
- **Algorithm exposed**: callers must understand sorting, cursors, grouping, merging, parsing, or other intermediate state. → hide it behind a meaningful value transformation, such as `availableRanges(opening, blocked)`.
- **Protocol exposed**: callers coordinate a transaction, lock, state transition, resource lifetime, or required call order. → give the protocol one semantic owner, such as `reserveVehicle` or `withFile`.
- **Foreign system exposed**: provider terms, request shapes, responses, exceptions, or error taxonomies enter local reasoning. → translate them into a local contract at one seam, such as `Stripe` → `ChargePayment`.

## Shared abstraction

Sharing creates coupling between use cases.

- **Rule of Three**: the same behavior now has three concrete occurrences. → point out the coupling candidate; suggest sharing when the occurrences have one identity, one invariant, and one reason to change.

Spawn a subagent that reads [Tiger Style](tiger-style.md) and tries to find improvements to the code or useful local abstractions.

Report only worthwhile suggestions in chat. For each, name the evidence and explain why it would help; do not apply it. If none have earned a recommendation, say so.
