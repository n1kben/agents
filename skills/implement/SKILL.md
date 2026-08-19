---
name: implement
description: Implement a plan in small, reversible, reviewable steps
disable-model-invocation: true
---

Make the change easy, then make the easy change.

## Make the change easy — shape the ground

Prefer local changes over premature abstraction; a little duplication is cheaper than the wrong abstraction.

Group code by what changes together, so one conceptual change lands in one place — not scattered as shotgun surgery.

Go through a module's boundary, not into its guts — don't deepen coupling to land the change.

## Make the easy change — small, reversible steps

Prefer many small transformations over one large rewrite.

Each step should be easy to review, test and revert.

Wear one hat at a time — refactor or change behavior, not both in one commit.

Temporary code should pass the deletion test: one cut to remove, not a thread to unpick.

Commit early and often.

## Suggested abstractions

End with a list of suggested abstractions you found during the implementation.
