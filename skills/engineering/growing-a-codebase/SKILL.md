---
name: growing-a-codebase
description: Guidance for growing and reviewing code from concrete use cases while letting boundaries emerge from evidence. Use when adding or changing behavior, reviewing codebase organization or architecture, deciding where code belongs, splitting code, or considering reuse.
disable-model-invocation: true
---

# Growing A Codebase

Grow the codebase from concrete use cases. Start with the behavior that must exist, keep its parts together, and let structure emerge as the code reveals useful concepts.

## Start With the Use Case

Begin with a screen, route, endpoint, job, command, or other observable use case. Put the code that delivers it nearby, even when that crosses technical categories such as presentation, validation, persistence, and messaging.

Build each use case in the shape it needs. A small operation can stay simple; a complicated workflow can develop a richer model. Do not impose matching layers or boundaries merely to make neighboring features look alike.

Do not split code because a file feels long. Split when doing so creates a part that is easier to name, understand, test, change, or replace independently.

## Let Concepts Emerge

Notice evidence in the working code:

- data that repeatedly travels together;
- an invariant that needs one owner;
- behavior that forms a coherent operation;
- state, identity, or lifetime that needs a boundary;
- decisions that consistently change together.

Give a discovered concept the smallest useful form: perhaps a name, a local value, a helper function, or a private type. A useful boundary does not automatically need its own file, module, or public interface.

Keep the concept local to its use case until another caller needs the same meaning. Local structure is still structure.

## Share Meaning, Not Resemblance

When code looks duplicated, ask why it should be shared before asking how. Similar syntax may represent independent decisions that will evolve differently.

Share code when its callers need the same behavior, invariants, and reason to change. Keep caller-specific choices with each caller. If a proposed shared boundary needs modes, flags, or knowledge of every caller, the common meaning may not be strong enough yet.

A little duplication is often cheaper than coupling unrelated behavior. Prefer waiting for evidence over predicting reuse.

## Check the Design

Ask:

- Can this use case be understood and changed mostly in one place?
- Are things that change together kept together?
- Can unrelated behavior evolve without passing through this code?
- Does each boundary protect a concept rather than satisfy a layout convention?
- Could this feature be tested or removed without untangling the whole codebase?

Good design limits the consequences of a change. A developer should be able to enter one use case, make a change, verify it there, and have a clear view of what else could be affected.
