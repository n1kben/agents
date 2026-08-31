# Abstraction Style

Use abstractions to divide a large reasoning **world** into smaller ones. A boundary earns its indirection when it removes more knowledge than it adds.

## Compression test

Create a boundary only when at least one sentence is substantial:

> Inside the boundary, this code no longer needs to consider **__**.

> Outside the boundary, callers no longer need to understand **__**.

Then name the cost:

> What new concept, name, or indirection must we understand instead?

If the removed knowledge is smaller than the new concept, keep the code concrete. Moving code is not compression.

Abstraction does not require reuse. A one-caller function can earn its boundary when it shrinks the reasoning world.

## Good local boundaries

Narrow the model. Create a smaller input type when an operation needs a stable subset of facts or stronger states than the larger value provides.

Use semantic capabilities. Pass the capability the operation needs, not an application context, service locator, client bag, or dependency graph.

Extract pure decisions. Keep policy separate from I/O, time, storage, network, loops, and retries.

Hide algorithmic state behind value transformations. Sorting, cursors, grouping, merging, parsing, and interval math can live behind a function that returns a meaningful value.

Replace protocols with semantic operations. If callers must coordinate transactions, locks, resource lifetimes, or call order, give that protocol one owner.

Translate foreign systems at a seam. Adapters own provider terms, request shapes, response shapes, exceptions, error taxonomies, and idempotency rules.

## Bad boundaries

Do not abstract because code looks similar. That is sharing pressure; use [`sharing-style.md`](sharing-style.md).

Do not wrap awkward APIs unless the wrapper removes real knowledge.

Do not create broad services, managers, helpers, or utils as abstraction homes.

Do not make callers pass flags, modes, booleans, or optional callbacks to recover behavior you abstracted too early.

## Apply

For each boundary, name the world it shrinks, the knowledge it hides, and the concept it adds.

Keep the code concrete unless the boundary earns its indirection.
