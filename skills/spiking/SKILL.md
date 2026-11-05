---
name: spiking
description: Spiking playbook. Use before asking the user a question that running something could answer, when a decision is blocked by uncertainty a small test or inspection can resolve, or when the user asks to spike something.
---

# Spiking

If running something can answer a question, don't ask the user; propose a spike. Ask the user only about what they want.

## Propose the spike

State the question it will answer, what you will test or inspect, why the result matters, and when you will stop.

Use the smallest test that represents the real case. Ask a question only when missing information prevents a meaningful test.

Wait for the user's approval before starting.

## Run and report

Run every spike in a background agent. Give the agent a local worktree with the state it needs. If that is impractical, use the current checkout only when the spike will not conflict with ongoing work.

Spike code is throwaway. Don't polish it or ship it.

Inspect the evidence yourself. Report what you learned, what remains uncertain, and what you recommend doing next. Stop when the question is answered or the agreed boundary is reached.
