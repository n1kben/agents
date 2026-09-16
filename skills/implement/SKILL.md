---
name: implement
description: Implement an agreed code change in observable vertical slices with verification.
disable-model-invocation: true
---

# Implement

1. Apply the **make-change-easy** skill.
2. Implement and verify the agreed change, applying the **make-local-change** and **coding-standards** skills.
3. Perform an adversarial review against **coding-standards** and fix issues within the agreed change.
4. For abstractions discovered from the completed local change, judge them against **coding-standards**, then apply **pitching** to present them one at a time.

Do not create or change abstractions while implementing the requested change. Keep the change local, then defer any abstraction proposals to step 4.
