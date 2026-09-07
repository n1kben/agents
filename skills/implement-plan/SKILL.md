---
name: implement-plan
description: Implement a plan
disable-model-invocation: true
---

Ok, lets implement this plan.

Make the change easy, then make the easy change.
Preparation may be hard. The final change should be boring.

Before editing, trace the real behavior end to end.

1. What behavior is actually changing?
2. Where does that behavior belong?
3. What structure makes the change local?
4. Make that structural change without changing behavior.
5. Make the now-easy behavior change.

Keep it simple, stupid.

1. Does this need to exist at all? Speculative need = skip it, say so in one line. (YAGNI)
2. Already in this codebase? A helper, util, type, or pattern that already lives here → reuse it. Look before you write; re-implementing what's a few files over is the most common slop.
3. Stdlib does it? Use it.
4. Native platform feature covers it? <input type="date"> over a picker lib, CSS over JS, DB constraint over app code.
5. Already-installed dependency solves it? Use it. Never add a new one for what a few lines can do.
6. Can it be one line? One line.
7. Only then: the minimum code that works.

We're after low coupling, high cohesion.

Want to reuse code or create a new abstraction?

1. Reuse existing code only when it's explicitly created for reuse.
2. Do not change the interface or implementation of the reusable code.
3. Need to change it, duplicate the code locally and modify it to fit the new use case.

- Vertical slices architecture
- Single responsibility principle
-
