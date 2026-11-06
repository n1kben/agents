---
name: spiking
description: Spiking playbook. Use before asking the user a question that running something could answer, when a decision is blocked by uncertainty a small test or inspection can resolve, or when the user asks to spike something.
---

# Spiking

If running something can answer the question, do not ask the user. Run a spike. (Only ask them about what they want.)

## Plan the spike

Write down the question, what you will test, why the answer matters, and when you will stop.

Use the smallest test that still looks like the real case. Ask something only if a missing fact would make the test meaningless.

## Run and report

Run every spike in a background agent, in its own local worktree with the state it needs. If that is impractical, the current checkout is fine as long as it will not collide with ongoing work.

Spike code is throwaway. Do not polish it or ship it.

Check the evidence yourself. Then say what you learned, what is still uncertain, and what you would do next. Stop when the question is answered or you hit the boundary you set.
