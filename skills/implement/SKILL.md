---
name: implement
description: Implement an agreed code change locally with verification.
disable-model-invocation: true
---

# Implement

Read and apply the **coding-standards** skill throughout.

## Make the change easy

Before implementation, inspect the affected code and any existing implementation of similar
behavior. First check whether deleting, combining, or simplifying existing code would achieve the
requested behavior. Then identify any behavior-preserving refactors needed to make the remaining
change easy and local.

Pitch the refactors without applying them. Explain the problem in the current code and how each
refactor makes the requested change easier. Include before-and-after pseudocode showing the relevant
types and interfaces.

Wait until every refactor has been approved or rejected. Then apply the approved refactors one at a
time. Verify and commit each refactor before starting the next.

## Make the easy change

When all approved preparation is complete, make the agreed change locally in the feature that needs
it. Duplication is allowed.

Do not create or change shared code beyond approved preparation. You may use existing shared code
without changing its contract. Leave unrelated code alone.

## Verify and review

Verify the observable behavior. Perform an adversarial review against **coding-standards**. Fix
findings whose remedy is implied by the agreed change and remains within its scope. Pitch any
finding that requires a new decision. Finish the review before moving on.

After the review is complete, judge any optional abstractions discovered during implementation
against **coding-standards** and pitch them.
