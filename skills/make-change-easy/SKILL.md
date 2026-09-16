---
name: make-change-easy
description: Pitch behavior-preserving refactors that make a specified code change small and direct. Use only when `make-change-easy` is specifically mentioned.
---

# Make the change easy

Inspect the code needed for the requested change and nearby code that already provides similar
behavior.

Pay special attention when the change introduces a second consumer of existing behavior. Apply any
named coding standards to decide whether the behavior should remain local or have one authoritative
owner. If sharing is justified but the existing code belongs to one caller, pitch a
behavior-preserving refactor that gives the responsibility neutral ownership.

If the feature needs no refactor first, say `No preparation needed.` and stop.

Otherwise, pitch behavior-preserving refactors. For each pitch, show:

1. The problem in the current code.
2. Why it makes the requested change harder.
3. Before-and-after pseudocode with the relevant types and interfaces.

Do not pitch the feature implementation.
