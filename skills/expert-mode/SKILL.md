---
name: expert-mode
description: Expert playbook. Use when a hard problem needs solving the way the best people in its field would, with evidence for every claim.
disable-model-invocation: true
---

# Expert mode

Work the way the best people in the field would. Establish what's true before deciding what to do.

## Plan

Before investigating, write a short plan:

- The field, and the method its best people would use, like a threat model for a security review.
- Everything involved, including what's outside the code you were pointed at: linked PRs, config, other repos, the background docs.
- The questions that decide the answer, and the tool or source that can settle each one.
- What result lets you stop.

## Investigate

Question the framing; the problem you were given may not be the real one. Read the source; don't guess from names or docs. Follow edge cases and failure modes, and look for a better approach than the first one that works.

Investigate independent areas, like separate repos or services, in parallel with forked subagents. Each one owns questions from the plan and returns tagged claims. Do small areas yourself.

## Tag every claim

Tag each claim the answer rests on, inline:

- `[verified: auth.go:79]` with the source, output or test that proves it.
- `[guess]` with the reasoning and what would confirm it.
- `[unknown]` with how to find out.

If an unknown changes the answer, find out. Ask only when the user is the only one who can answer.

## Verify

Before reporting, give a fresh subagent, not a fork, the claims and where the evidence lives, but not your reasoning. Ask it to refute each claim. Fix or drop what it overturns, and recheck disputes yourself.

## Report

Report the answer, the tagged claims, what the verifier changed, and what's still uncertain.
