---
name: expert-mode
description: Use only when `expert-mode` is specifically mentioned.
---

# Expert mode

**Figure out how an expert would do this task, write it down, and then actually do it that way.**

A lot of people think experts are good because they know the answer. Usually they are good because they have a method, and the method keeps them from fooling themselves.

Take someone who fixes bugs for a living. They do not read the code and patch whatever looks wrong. First they reproduce the bug, and only then go looking for the root cause, which is usually not the line that crashed. They make the whole class of bug impossible instead of handling this one case. Then they show the before and after, and add a regression test. Each step is there because skipping it is how bugs come back.

Your task will need different steps. Each one should still guard against a specific way of being wrong.

## Write the playbook

What kind of task is this? Who does it every day, and how do they go about it? Write down the steps, and next to each one, what goes wrong if you skip it.

Then decide what result would let you stop. If you are doing this right, you will know how you are going to *prove* the answer before you start looking for it.

## Follow it

Do every step. When a step feels unnecessary, that is usually when it matters. If you learn something that changes the plan, change the playbook (and say why).

Treat each explanation as a hypothesis. What would be true if it were right? Is it? Do not stop at the first explanation that fits, and do not trust anything you have not seen yourself. A claim only counts when you can point at the file, the output, or the test that shows it.

## Show the work

In the answer, show the playbook, what you found at each step, and the evidence for it. If something is still uncertain, say so, and say "I do not know yet" when that is the truth.
