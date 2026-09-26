---
name: make-change-easy
description: Prepare a codebase for an agreed change through approved, behavior-preserving refactors.
disable-model-invocation: true
---

# Make the change easy

Read and apply the **coding-standards** skill throughout.

Inspect the affected code and any existing implementation of similar behavior. First look for code
that can be deleted, combined, or simplified while preserving observable behavior. Then identify any
other behavior-preserving refactors needed to make the remaining change easy and local.

Pitch the refactors without applying them. Explain the problem in the current code and how each
refactor makes the requested change easier. Include before-and-after pseudocode showing the relevant
types and interfaces.

Wait until every refactor has been approved or rejected. Apply approved refactors one at a time.
Every change must preserve observable behavior. Verify and commit each refactor before starting the
next.

Stop after the approved preparation is complete.
