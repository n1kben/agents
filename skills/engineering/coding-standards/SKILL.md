---
name: coding-standards
description: Shared defaults for structuring safe, maintainable production code. Use when writing, refactoring, implementing, or reviewing code.
disable-model-invocation: true
---

Follow explicit project conventions first. Otherwise use these standards as defaults. Treat design guidance as a judgment call; reserve absolute rules for correctness and safety.

## Write For The Reader

Organize around the reader's first pass. Put the important, high-level operation before its implementation details. Put helpers after the code that introduces their need.

Keep names in the language of the behavior. If a value, function, or type is difficult to name honestly, clarify the code before adding another name.

## Use The Smallest Boundary

Use the simplest construct that can do the job. Prefer a value or function when that is enough. Introduce a type when it carries a fact or rules out invalid states. Reach for a stateful object, component, or module when state, identity, lifetime, or a protocol needs an owner.

A boundary should remove something substantial from the caller's concerns. Keep it local unless a separate abstraction-shaping task has established that multiple callers should share it.

Test a proposed boundary by naming what it removes:

> Inside the boundary, this code no longer needs to consider **\_\_**.
>
> Outside the boundary, callers no longer need to understand **\_\_**.
>
> What new concept or indirection must we understand instead?

If neither side becomes meaningfully simpler, moving the code is not useful compression. The reasoning removed should justify the name, interface, and indirection introduced.

Keep one reason to change together. Separate code when its parts can change independently, not to satisfy a size limit or a preferred file shape.

## No Hidden Control Flow

Keep control flow in the highest-level function that knows which complete behavior to run. Push `if`s up and `for`s down: the parent chooses and tells the story; leaf functions perform focused work with little or no branching.

Do not pass a choice downward for several helpers to reinterpret. Keep caller-specific choices with the caller.

## Value Semantics At Boundaries

**State mutates inside its owner and crosses boundaries as values.**

Treat function arguments as immutable. Return a new value instead of mutating the caller's state.

Mutation needs an owner. Follow the Single Writer Principle: only the owner mutates its state. Never give unrelated code mutable access.

Keep state with its smallest owner. Each branch owns its state even when representations match. Coordinate by passing or copying values. Share an owner only when correctness requires atomic change.

## Separate Decisions From Effects

The owner reads and writes. Pure code computes what should happen where practical. Keep deterministic decisions separate from storage, network, time, randomness, UI frameworks, retries, and other effects. Keep the sequence visible in the orchestration.

Make dependencies visible at the boundary that uses them. Ask for the narrow value or capability required rather than an application container or ambient dependency.

Keep business behavior independent of its view. Give nonvisual behavior a nonvisual entry point that can be exercised without rendering the application. Make views inspectable with previews, stories, sandboxes, or the project's equivalent.

## Parse Early, Assert Late

External data starts uncertain. Do not spread that uncertainty through the program.

Avoid shotgun parsing. Parse once at the boundary into a type that captures what is known.

Turn strings, numbers, JSON, database rows, and SDK responses into structured values. Once a fact is known, stop representing it as uncertain.

State the assumptions that affect correctness and check that they are true. Put facts that must travel in types or constructed values. Assert internal invariants near their use when the type system cannot express them.

### Make Impossible States Impossible

Encode invariants as early as possible in compile-time-enforced types. Use identifiers, units, enums, and tagged variants to make the possible world smaller.

Every state admitted by a type is a state the rest of the program must understand. Avoid boolean flags, optional-field combinations, and primitive values when a more precise representation can rule out invalid states.

When compile-time types cannot enforce an internal invariant, assert it at the point of use. Type guarantees travel with values; assertions protect only the code they guard.

**A comment is not a constraint.**

## Errors As Values

**Expected failure is part of the contract.**

If a failure can happen during normal operation, put it in the owning use case's contract using the strongest checked mechanism the language provides.

Different failures are different facts. Do not erase the distinction before the caller has finished making decisions from it.

Translate foreign failures at the boundary. Domain code does not understand HTTP statuses, database codes, or SDK exceptions. Do not create a shared error taxonomy merely because use cases receive similar failures.

Expected failures are values. Broken invariants are defects. Do not confuse them.

## Own State And Work

Give mutable state and resources one clear owner. Keep acquisition and cleanup together.

Bound queues, buffers, batches, concurrency, retries, polling, and loops. Make partial completion and interruption explicit when they can occur.
