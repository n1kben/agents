---
name: improve-codebase
description: Use only when "improve codebase" is specifically mentioned.
disable-model-invocation: true
---

Walk into this codebase like a contractor on day one, find where it hurts most, and redesign it so the pain goes away.

1. Find the hotspots and take the top one.
2. Diagnose its design cause.
3. Redesign it with the strongest fix.
4. Check that the redesign removes every piece of evidence, and lay out a path there in small, safe steps.

A hotspot:

- Churns while complex: tangled code that keeps getting edited.
- Has a wide blast radius: changing it means changing files elsewhere, especially across module boundaries. Weigh this highest.
- Keeps breaking: fix commits keep landing in the same place.
- Buries decisions: the same condition is checked deep and often, through flag arguments, repeated checks or type switches, instead of once near the top.

Read the history before the code. Skip generated, vendored and lock files. Rank the candidates, each with its evidence, and read the top ones to confirm each is real pain, not just busy.

A design cause, found in the commits and fixes that touched it:

- Scattered: one reason to change touches many places.
- Tangled: unrelated reasons to change land in one place.
- Unenforced: fixes keep restoring a rule the types allow breaking.
- Misplaced: a decision is made deep down instead of once at the top.

A fix, strongest first:

1. Delete: the need goes away, so the code does too.
2. Unrepresentable: the types can't express the bad state.
3. Parsed: checked once at the boundary into a precise type, never again.
4. Guarded: a module's constructor protects the rule, and only it can break it.
5. Checked: a runtime assertion fails fast.
6. Tested: a test catches it.

When the cause is scattered or tangled, the seams are wrong: break the hotspot down to primitives and build them back up into deep modules, using the definitions in `../find-primitives/SKILL.md` and `../design-modules/SKILL.md`.
