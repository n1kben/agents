# Structural Tidyings

Use a tidying only when it directly makes the current behavior change local, explicit, or mechanically simple. Keep it behavior-preserving and verify it before changing behavior.

## Kent Beck

- **Guard Clause** — flatten control flow so the path that will change is direct.
- **Normalize Symmetries** — express equivalent cases in the same shape so they can change uniformly.
- **New Interface, Old Implementation** — introduce the interface the change needs while delegating to existing behavior.
- **Cohesion Order** — bring tightly related code together before changing it.
- **Explicit Parameters** — expose a hidden input or dependency at the boundary that needs it.
- **Extract Helper** — give the behavior that will change a small, named boundary.
- **One Pile** — inline scattered indirection until the whole behavior is visible, then draw the right boundary.

## Martin Fowler

- **Extract Function / Inline Function** — create or remove a function boundary to put the change in one place.
- **Move Function / Move Field** — put behavior or data with the code responsible for it.
- **Change Function Declaration** — reshape an internal interface around what the change actually needs.
- **Encapsulate Variable** — put access to shared data behind a seam that can change safely.
- **Split Phase** — separate entangled stages so only one stage needs to change.
- **Move Statements into Function / to Callers** — move work across a boundary to the side that owns it.
- **Extract Class / Inline Class** — create or remove an object boundary when responsibility is misplaced or fragmented.

Do not use this catalog for comments, formatting or statement chunking, reading order, explanation-only names, speculative cleanup, or behavior changes.

Sources: Kent Beck's *[Tidy First?](https://www.oreilly.com/library/view/tidy-first/9781098151232/)* and Martin Fowler's *[Preparatory Refactoring](https://martinfowler.com/articles/preparatory-refactoring-example.html)* and *[Refactoring](https://refactoring.com/catalog/)*.
