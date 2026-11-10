---
name: debug
description: Find and fix the root cause of a bug. Use when something is broken or behaves unexpectedly.
---

Reproduce it the way it actually happens before changing anything.

Find the root cause. Read the docs and source of what's involved, and test your hypotheses and the user's instead of trusting them.

Change only what you proved causes the bug.

Fix it where the bad state is created, not where it shows up, so it can't happen again, here or anywhere else with the same cause.
