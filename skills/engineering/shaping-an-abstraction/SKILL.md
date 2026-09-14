---
name: shaping-an-abstraction
description: A conversation-led workflow for deciding whether concrete code deserves a shared abstraction. Use when implementation or code review exposes a specific sharing candidate, including repeated code or a proposed common boundary; not for general architecture review or when an interface already needs to exist.
disable-model-invocation: true
---

# Shaping An Abstraction

Start with one concrete suggestion. Read the code, its callers, and the relevant history before deciding what the abstraction should be.

## Why Share It?

Name the part that was hard to get right or important to keep consistent. Confirm that the callers need the same behavior and would become wrong for the same reason.

Sharing ties the callers together. Compare that cost with the bugs, repeated work, or drift already visible in the local versions. If the case for sharing is weak, wait or reject the suggestion.

## Find the Seam

Try more than one way of dividing the code. Look for parts that can be understood, tested, changed, and used on their own. The first boundary that comes to mind may not be the useful one.

Write down the assumptions the candidate makes about its callers, inputs, state, and dependencies. Check those assumptions against the code and history rather than treating them as part of the abstraction by default.

Keep each caller's choices with that caller. The shared part should have one meaning. Flag arguments, mode parameters, caller-specific switches, and growing configuration usually mean the boundary is holding different jobs together.

Look for the smallest useful piece. Keep incidental storage, framework, and service choices outside unless they are part of what the abstraction means.

Choose the simplest primitive that can hold that piece. Prefer a value or function when it is enough, a type when it carries an invariant, and a stateful object or module only when state, identity, lifetime, or a protocol needs an owner.

## Check the Result

Ask:

- Can the abstraction be understood without first understanding every caller?
- Can the separated parts stand on their own?
- Can callers keep their own decisions nearby?
- Would a change inside help every caller for the same reason?
- Is there evidence that this boundary is needed now?

If the answer is no, try another seam. It is fine to end by waiting or rejecting the suggestion.

## Present the Abstraction

Present the proposed name, the hard part it would hide, its callers, what stays local, the evidence for sharing, and the strongest argument against it.

If the abstraction is worth introducing, define how callers should use it in a separate interface-shaping discussion. Do not edit code until the user agrees with both the abstraction and its interface.
