---
name: implement
description: Implement an agreed, prepared code change without adding unapproved abstractions.
disable-model-invocation: true
---

# Implement

Read the repository instructions and apply the **coding-standards** skill.

The behavior is agreed and the preparatory refactors are complete. Make the simplest local change
that delivers it. Duplication is allowed. Do not add abstractions or change shared contracts unless
approved during preparation.

Work in vertical slices. Each slice delivers one observable behavior end to end. Run its fast checks
and commit it before starting the next. Do not organize commits by technical layer.

Handle unspecified implementation details without interrupting the user. Record material decisions,
why you made them, and any uncertainty. Stop if continuing would change the agreed behavior, scope,
or architecture, or require an unsafe action.
