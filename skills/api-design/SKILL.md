---
name: api-design
description: Design or redesign an API by sketching the most precise and most evolvable versions, then letting the user choose a practical point between them. Use for code interfaces, endpoints, schemas, and serialized contracts.
---

# API design

Start from requirements, not the current API. Inspect existing callers, producers, stored data, and
release boundaries as evidence. Then ask what you would build if the API did not exist.

Identify the states, operations, and failures callers must distinguish. Parse external data into
program types, distinguish values that cannot be exchanged safely, and handle closed variants
exhaustively. Translate dependency errors at the boundary. Determine whether producers, consumers,
and stored data can change atomically.

## Draw the extremes

Design both from scratch:

- **Maximum precision.** Assume the dependency graph changes atomically. Use types to make invalid
  states unrepresentable, even past the point you would normally consider practical.
- **Maximum evolution.** Assume producers, consumers, and stored data change independently. Preserve
  old meanings and favor additive changes, tolerant readers, and shared old-and-new representations.
  Use optional, open, or flat data only when it helps evolution.

Use concrete signatures or schemas. Show what each design makes easy, impossible, and expensive.

## Build the ladder

Start from the evolvable design. Pitch cumulative moves toward precision, highest value first. For
each move, show:

- the mistakes or invalid states it removes;
- the effect on ordinary callers;
- the compatibility cost;
- whether it requires an atomic migration.

Pitch one move at a time. The user decides when the next gain no longer justifies its cost.

Keep the common surface small. When a real exceptional caller needs more control, offer an explicit
advanced surface instead of burdening everyone. Build the simple surface on the same core so their
behavior cannot drift.

Finish with the selected API and its migration or versioning consequences. Keep in-process types
strict even when a wire or storage boundary must stay tolerant, unless the user chooses otherwise.
