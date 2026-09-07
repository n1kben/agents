---
name: make-change-easy
description: Prepare code for a feature, fix, or modification with the smallest useful behavior-preserving structural refactoring, then make the now-easy behavior change.
disable-model-invocation: true
---

Make the change easy, then make the easy change.

Before changing behavior, identify the structural friction specific to the requested change. If there is any, read [Structural Tidyings](references/tidyings.md), apply only the smallest relevant tidying, and verify that behavior is unchanged.

Then make and verify the behavior change separately. If the change is already easy, skip tidying. Do not turn preparation into general cleanup.
