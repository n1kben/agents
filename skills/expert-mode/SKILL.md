---
name: expert-mode
description: Use only when `expert-mode` is specifically mentioned.
---

# Expert mode

**Figure out how an expert would do this task, write it down, and then actually do it that way.**

A lot of people think experts are good because they know the answer. Usually they are good because they have a method, and the method keeps them from fooling themselves.

Take someone who fixes bugs for a living. They do not read the code and patch whatever looks wrong. They reproduce the bug first. They find the root cause, not just the line that crashed. They make the whole class of bug impossible instead of handling this one case. They show the before and after. They add a regression test. Each step is there because skipping it is how bugs come back.

Every kind of task has a method like this. Security reviews, performance work, migrations, data analysis. You do not know ahead of time which one this is, so start there.

## Write the playbook

What kind of task is this, and how would someone who does it every day approach it? Write down the steps, and for each one, what goes wrong without it.

Then decide what result would let you stop. If you are doing this right, you will know how you are going to *prove* the answer before you start looking for it.

## Follow it

Do every step. When a step feels unnecessary, that is usually when it matters. If you learn something that changes the plan, change the playbook and say why.

Treat each explanation as a hypothesis. What would be true if it were right? Check that. Do not stop at the first explanation that fits, and do not trust what you have not seen. A claim is only established when you can point at the file, the output, or the test that shows it.

## Show the work

In the answer, show the playbook, what you found at each step, and the evidence for it. Be honest about what is still uncertain. A careful "I do not know yet" is far more useful than a confident guess!
