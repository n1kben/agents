---
name: implement
description: A conversation-led workflow for implementing code changes in observable slices with separate preparation and verification. Use when the user asks to implement a requested change or agreed plan.
disable-model-invocation: true
---

# Implement

Start with the requested behavior and carry it through in small, observable slices.

## Understand The Change

Trace the current behavior end to end. Identify what should change, where that behavior belongs, what must remain unchanged, and how the result will be verified.

Look for existing code, standard-library or platform features, and installed dependencies that already provide what the change needs. Reuse them when their existing meaning and contract fit; do not distort them to avoid writing local code.

Divide the work into the smallest observable vertical slices. Prefer end-to-end behavior over technical phases. Each slice should make one coherent change, leave the system working, and include the verification needed to trust it.

## Shape The Slice

Before editing, establish:

- the behavior this slice will change
- the code responsible for that behavior
- any structural friction that makes the change difficult
- the smallest behavior-preserving preparation, if one is needed
- how the preparation and behavior change will be verified separately

Present this shape to the user and wait for agreement before editing. An explicit, user-approved plan that already settles these points counts as agreement; do not ask the user to repeat decisions they have already made.

Shape one slice at a time. Leave decisions about later slices until their concrete needs are visible.

## Make The Change Easy

If the behavior change is already local and direct, skip preparation.

Otherwise, perform only the agreed behavior-preserving preparation and verify that behavior remains unchanged before proceeding.

Preparation may rearrange, inline, split, or privately expose behavior that already exists. It must not introduce a shared abstraction, reusable helper, strategy, mode, generalized interface, or structure for a possible future caller.

A new private boundary is acceptable only when it makes existing behavior visible or movable for this slice. Do not give it options it does not need, export it for reuse, or treat it as the final shared design. If preparation appears to require a new reusable concept, stop and raise that as a separate shaping decision.

## Make The Easy Change

Implement the agreed behavior where it is needed.

Verify the observable behavior. If an unexpected obstacle means the change is no longer easy, stop and return to shaping the slice with the user rather than expanding the preparation unilaterally.

Repeat the cycle for the next slice.

## Review The Result

After every requested slice is complete and verified, review the touched code for unfinished work, accidental complexity, and design questions raised by the implementation.

Report worthwhile follow-ups with the evidence that raised them and the strongest reason each may not be needed. Do not expand the completed change to address them without the user's agreement.
