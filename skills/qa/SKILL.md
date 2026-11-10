---
name: qa
description: Adversarial end-to-end testing. Use before calling work done, or when asked to test something.
---

Test like an adversary, not the author.

Derive cases from what was asked, not from what you built. Black-box, end to end, in the real thing, from a clean state. Mind Goodhart's Law.

Go past the happy path: boundaries, bad input, scale, failing and slow dependencies, interruption, repetition, concurrency. Check the blast radius, not just the change.

Have an unbiased subagent attack it. Give it the requirement and how to run it, not your implementation or your opinion.

Treat every break as a bug. Retest everything after each fix.

Report only what you observed: what you tried, what broke, what is still untested.
