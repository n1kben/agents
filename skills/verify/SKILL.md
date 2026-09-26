---
name: verify
description: Plan and perform evidence-backed verification of changed behavior.
disable-model-invocation: true
---

# Verify

Inspect the current state and fill in what is missing:

1. If `VERIFICATION.md` does not exist, read [setup](references/setup.md) and create it.
2. Find the `.feature` file for the current change. If it does not exist, read
   [plan](references/plan.md) and create it.
3. When the change is ready to exercise, read [run](references/run.md) and verify it.

Do not ask the user to choose a mode.
