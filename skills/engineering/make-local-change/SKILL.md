---
name: make-local-change
description: Implement a feature without extracting shared code. Keep private helpers and types with their caller, allow duplication, and ask before changing shared APIs. Use only when explicitly invoked.
disable-model-invocation: true
---

# Make local change

Implement the request in the feature that uses it. Duplication is allowed.

## Start at the entry point

In a new project, start with the first screen, route, or endpoint the user requested. Put framework entry points in the locations the framework requires. Keep private types, helpers, and small components in the same file as their caller.

Do not create a file to:

- hold one private helper or type;
- keep another file below an arbitrary size;
- mirror layers such as controllers, services, repositories, or utilities;
- prepare code for a second caller that does not exist.

Split a file when the framework requires it or when the extracted code owns a data structure and rules that its caller no longer needs to know.

Test the split: if the second caller never appears, does the new file still need to exist? If not, keep the code in the caller.

## Ask before sharing

Unless the user has already approved the design, do not:

- create shared code for the change;
- broaden an existing shared API;
- move feature code into common or infrastructure code;
- modify existing callers to fit a new general design.

Using existing shared code without changing its contract is allowed.

Do not refactor code unrelated to the request.

## Finish before proposing shared code

Implement and verify the request before raising optional consolidation. Do not pause implementation for it.

Before reporting the task complete, check the duplication introduced by the change. Report a sharing candidate only when two current callers follow the same rule. Name the callers, state the rule that must stay identical, and show the smallest shared edit. Do not apply it without the user's agreement.

If local code cannot produce correct behavior, stop before editing shared code. Show the failing path, the local alternative, and the smallest shared edit that fixes it. Wait for the user's agreement.
