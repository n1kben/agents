---
name: spiking
description: Use when a decision is blocked by uncertainty that can be resolved through a small test or inspection, or when the user asks to spike something.
---

# Spiking

## Propose the spike

State the question it will answer, what you will test or inspect, why the result matters, and when you will stop.

Prefer the smallest investigation that represents the real case. Ask a question only when missing information prevents a meaningful test.

Wait for the user's approval before starting.

## Run and report

Run every spike in a background agent. Use a cloud agent when available and the test can run from committed code. Otherwise, give the agent a local worktree with the state it needs. If that is impractical, use the current checkout only when the spike will not conflict with ongoing work.

Inspect the evidence yourself. Report what you learned, what remains uncertain, and what you recommend doing next. Stop when the question is answered or the agreed boundary is reached.
