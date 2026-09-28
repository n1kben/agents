# Plan verification

Write `.verification/<behavior>.feature`. Name it after the observable behavior.

Write a small number of Gherkin scenarios that a user can quickly review. Usually two to five
scenarios are enough. Give each scenario a starting state, actions, and observable results.

Describe expected behavior from the user's request and decisions. Do not derive expected behavior
from the current implementation. Keep technical edge cases in automated tests unless the user needs
to approve them as product behavior.

Match proof to the change:

- For a bug fix, include the failing behavior before the fix and the same steps after it.
- For a behavior-preserving change, compare the same behavior before and after.
- For a performance change, measure the same workload before and after.

Compilation, linting, and unrelated passing tests are supporting checks, not proof.

Show the file to the user so they can correct or add scenarios.
