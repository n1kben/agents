# Boundary Style

A local boundary is compression, not coupling. Use a boundary to shrink a reasoning **world**: the facts, states, capabilities, effects, failures, protocols, and control flow code must consider.

A boundary earns its indirection when it removes more knowledge than it adds. Abstraction does not require reuse; a one-caller function can earn its boundary.

Prefer deep modules: small semantic interfaces that hide substantial facts, protocols, effects, or decisions. Avoid shallow modules that add names without hiding complexity.

## Compression test

Create a boundary only when at least one sentence is substantial:

> Inside the boundary, this code no longer needs to consider **\_\_**.

> Outside the boundary, callers no longer need to understand **\_\_**.

Then name the cost:

> What new concept, name, or indirection must we understand instead?

If the cost is bigger than the removed knowledge, keep the code concrete. Moving code is not compression.

## Good boundaries

Narrow the world. Use inputs and outputs that expose only the facts, states, capabilities, failures, and effects the boundary actually needs.

Narrow the model. Create a smaller value or stronger state when an operation needs only part of a larger concept, or needs impossible states removed.

Use semantic capabilities. Pass the capability the operation needs, not an application context, service locator, client bag, or dependency graph.

Create test seams at useful boundaries. The highest useful seam lets tests observe behavior while implementation details remain free to change.

Extract pure decisions. Keep policy separate from I/O, time, storage, network, loops, and retries.

Hide algorithmic state behind value transformations. Sorting, cursors, grouping, merging, parsing, and interval math can live behind a function that returns a meaningful value.

Replace protocols with semantic operations. If callers must coordinate transactions, locks, resource lifetimes, or call order, give that protocol one owner.

Translate foreign systems at a seam. Adapters own provider terms, request shapes, response shapes, exceptions, error taxonomies, and idempotency rules.

### Identity layers at boundaries

Identity is domain knowledge, not just a primitive type. Prefer boundaries that expose only the identities needed for the decision.

Prefer the aggregate business identity (root identity) as the main external input/output.
- Business identity: the name your domain uses for the concept (`OrderId`, `CustomerId`).
- Internal entity identity: useful inside the aggregate when operations target children (`OrderLineId`, `ReservationId`).
- Technical identity: infrastructure or storage-focused IDs when the persistence model requires them.

A boundary is stronger when callers can work with business identity and never see storage identifiers unless they are domain-meaningful.

If a caller must operate on a child entity, make that boundary explicit (`remove item line`, `reprice line`) and pass that child identity intentionally.

## Bad boundaries

Similarity is not compression. Do not create a boundary because code looks alike; create one because it shrinks the reasoning world.

Do not wrap awkward APIs unless the wrapper removes real knowledge.

Do not create broad services, managers, helpers, or utils as boundary homes.

Do not make callers pass flags, modes, booleans, or optional callbacks to recover behavior you abstracted too early.
