---
name: make-local-change
description: Keep a requested feature local. Allow duplication, keep private code with its caller, and ask before creating or changing shared code. Use only when `make-local-change` is specifically mentioned.
---

# Keep the change local

Implement the requested behavior in the feature that needs it. Duplication is allowed.

## Start at the entry point

In a new project, start with the requested screen, route, or endpoint. Put the entry point where the framework requires it. Keep its private types, helpers, and small components in the same file.

Do not create a file to:

- hold one private helper or type;
- keep another file below an arbitrary size;
- mirror layers such as controllers, services, repositories, or utilities;
- prepare for a second caller that does not exist.

Split when the extracted code has a separate responsibility that needs one authoritative definition or a deliberate interface.

If the second caller never appears, should the new file still exist? If not, keep the code with its caller.

## Ask before sharing

Unless the user has already approved the design, do not:

- create shared code for the change;
- broaden an existing shared API;
- move feature code into common or infrastructure code;
- modify existing callers to fit a new general design.

You may use existing shared code without changing its contract.

Leave unrelated code alone.

## Finish before suggesting sharing

Implement and verify the request first. Do not pause to discuss optional sharing.

Before reporting the task complete, check the duplication introduced by the change. Mention a shared refactor only when two current callers must follow the same rule. Name the callers and the rule, then show the smallest shared edit. Do not apply it without the user's agreement.

If a local implementation cannot be correct, stop before changing shared code. Show the failing path and the local alternative. Then propose the smallest shared edit and wait for the user's agreement.
