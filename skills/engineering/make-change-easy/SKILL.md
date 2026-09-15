---
name: make-change-easy
description: Pitch behavior-preserving refactors that make a specified code change small and direct. Use only when explicitly invoked before implementation.
disable-model-invocation: true
---

# Make the change easy

Apply the **pitching** skill.

Inspect the code needed for the requested change. If the feature needs no refactor first, say `No preparation needed.` and stop.

Otherwise, pitch one behavior-preserving refactor at a time. For each pitch, show:

1. The problem in the current code.
2. Why it makes the requested change harder.
3. Before-and-after pseudocode with the relevant types and interfaces.

Do not pitch the feature implementation.
