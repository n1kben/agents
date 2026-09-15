---
name: shaping-an-abstraction
description: Decide whether concrete code should become a shared abstraction. Use when repeated code or a proposed common boundary needs evaluation. Stop before designing the API.
disable-model-invocation: true
---

# Shaping an abstraction

Start with one concrete suggestion. Read the code, its callers, and the relevant history before deciding what the abstraction should be.

## Decide whether to share

Compare each proposed abstraction with leaving the code where it is. Do not assume that repeated code needs a shared owner.

Name the part that was hard to get right or important to keep consistent. Choose the abstraction only when examples show that callers must follow the same rule or change together for the same reason.

Sharing ties the callers together. Compare that cost with the bugs, repeated work, or drift in the current code. If the case for sharing is weak, wait or reject the suggestion.

## Find the seam

Try more than one way of dividing the code. Look for parts that can be understood, tested, changed, and used on their own. The first boundary that comes to mind may not be the useful one.

Write down the assumptions the candidate makes about its callers, inputs, state, and dependencies. Check those assumptions against the code and history rather than treating them as part of the abstraction by default.

Keep each caller's choices with that caller. The shared part should have one meaning. Flag arguments, mode parameters, caller-specific switches, and growing configuration usually mean the proposed abstraction combines behavior that differs by caller.

Look for the smallest useful piece. Keep storage, framework, and service choices outside unless they are part of what the abstraction means.

Use a value or function when that is enough. Use a type when it carries an invariant. Use a stateful object or module only when state, identity, lifetime, or a protocol needs an owner.

## Check the result

Ask:

- Can the abstraction be understood without first understanding every caller?
- Can the separated parts stand on their own?
- Can callers keep their own decisions nearby?
- Would a change inside help every caller for the same reason?
- Is there evidence that this boundary is needed now?

If the answer is no, try another seam. It is fine to end by waiting or rejecting the suggestion.

## Present the abstraction

Present the proposed name, the rule or behavior it would contain, its callers, what stays local, the evidence for sharing, and the strongest argument against it.

If the abstraction is worth introducing, use `shaping-an-api` to define how callers should use it. Do not edit code until the user agrees with both the abstraction and its API.
