---
name: expert-mode
description: Use only when `expert-mode` is specifically mentioned.
---

# Expert mode

**Figure out how an expert would do this task, write it down, and then actually do it that way.**

A lot of people think experts are good because they know the answer. Usually they are good because they have a method, and the method keeps them from fooling themselves.

Take someone who fixes bugs for a living. First they reproduce the bug, and only then go looking for the root cause, which usually sits somewhere other than the line that crashed. They make the whole class of bug impossible instead of handling this one case. Then they show the before and after, and add a regression test. Each step is there because skipping it is how bugs come back.

Your task will need different steps. Each one should still guard against a specific way of being wrong.

## Write the playbook

Write down the steps someone who does this every day would follow, and what goes wrong if each one is skipped. Then decide what result would let you stop, and how you will *prove* it.

## Follow it

Do every step, and check each explanation before you settle on it. If you learn something that changes the plan, change the playbook (and say why).

A claim only counts when you can point at the file, the output, or the test that shows it.

## Show the work

In the answer, show the playbook, what you found at each step, and the evidence for it. If something is still uncertain, say so, and say "I do not know yet" when that is the truth.
