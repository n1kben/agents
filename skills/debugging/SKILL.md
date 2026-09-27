---
name: debugging
description: Reproduce a reported bug, identify and fix its root cause, and prove the failure is gone. Use for debugging or requests to diagnose and fix a defect.
---

# Debugging

Reproduce the bug through the same interface and conditions where it was reported. Record the exact failure before changing code. If it does not reproduce, narrow the conditions or instrument the running system. Do not guess.

Trace the symptom to its root cause. List plausible causes, then eliminate them with evidence. Confirm the faulty mechanism and search for the same fault elsewhere.

Make the smallest fix the evidence supports. Fix the cause, not the symptom. Add a behavior-level regression test if it would catch a recurrence. Remove temporary instrumentation and discarded attempts.

Repeat the original reproduction through the same interface and conditions. Then run the relevant tests. A passing test suite does not replace proof that the original bug is gone. Report the symptom, root cause, fix, before-and-after evidence, and any remaining uncertainty.
