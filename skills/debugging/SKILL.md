---
name: debugging
description: Debugging playbook. Use when diagnosing or fixing a bug, crash, error, failing test, or wrong behavior.
---

# Debugging

## Reproduce

Reproduce the bug the way users hit it, in the running system. This is non-negotiable. Before changing anything, capture the failure as output, a log, or a screenshot. That is the baseline; never edit it to make a fix pass.

If it won't reproduce, narrow the conditions, trigger it directly, or instrument the running system. Don't guess.

## Find the root cause

Start where the symptom appears and follow the calls to the code that does the work. Read that code; don't guess from names or docs. If it used to work, check the history for when it broke.

Treat each suspected cause as a hypothesis. State it, run a check that could refute it, and record the result. Pick the check that rules out the most candidates. When program state is unclear, log it and read it while the code runs. When evidence refutes a hypothesis, revert what it motivated.

Keep asking why until you reach the decision that let the bug happen, not just the line that failed.

If two fixes built on the same assumption have failed, stop and test the assumption.

## Fix

Make the bug impossible rather than handled. In order of preference:

1. Delete the code path or state that allows it.
2. Change types or data so the bad state can't be represented.
3. Fix the logic where the bad state is created.

Don't add a guard where it crashes; a nil check that silences a crash hides the bug. If a fix needs a long comment to justify it, the code is wrong.

Change only what you proved causes the bug. A change that "might help" is a hypothesis, not a fix. Search for the same pattern elsewhere and fix every instance.

If a regression test would catch a recurrence, add one that calls the code the way users do, and confirm it fails without the fix. Remove temporary logging and failed attempts.

## Prove

Rerun the original reproduction. Passing tests don't replace it.

Report the symptom, root cause, fix, before-and-after evidence, and what's still uncertain.
