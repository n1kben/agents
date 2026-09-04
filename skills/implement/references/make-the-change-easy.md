# Make The Change Easy

Before changing code, inspect the planned behavior and the code it must change.

Look for a wrong abstraction that makes the change difficult: shared code whose callers need flags, modes, booleans, or optional callbacks to recover distinct behavior, or whose change has an unrelated blast radius. The preparation may inline, split, or localize that behavior.

Explain what makes the change difficult. Propose the smallest behavior-preserving preparation that would make it straightforward. Discuss the proposal with the user until you agree on the preparation and the easy change it enables.

If the change is already easy, explain why and agree to skip preparation.

Do not edit code until the shared idea is clear and the user agrees with it.

Then perform only the agreed preparation. Preserve behavior and verify that it still works. Keep the preparation separate from the behavior change in version history when commits are part of the workflow.
