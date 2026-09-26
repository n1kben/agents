# Plan verification

Write `.verification/<behavior>.feature`. Name it after the observable behavior.

Write Gherkin scenarios with a starting state, actions, and observable results. Prefer a few broad
scenarios over many narrow ones. Let one realistic flow verify several related outcomes. Add another
scenario only when it needs a different setup, path, or failure condition.

Match proof to the change:

- For a bug fix, include the failing behavior before the fix and the same steps after it.
- For a behavior-preserving change, compare the same behavior before and after.
- For a performance change, measure the same workload before and after.

Compilation, linting, and unrelated passing tests are supporting checks, not proof.

Cover the requested behavior, important failures, boundaries, permissions, and likely regressions.
Show the file to the user so they can correct or add scenarios.
