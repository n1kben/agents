---
name: spike
description: A bounded technical experiment for reducing one consequential uncertainty. Use when a decision is blocked by unknown feasibility, behavior, performance, or compatibility.
---

# Spike

Start with one decision that cannot responsibly be made with the current evidence. A spike exists to reduce that uncertainty, not to begin the production implementation early.

## Frame the Question

State the decision, the unknown blocking it, and what evidence would change the decision. Make success, failure, and an inconclusive result distinguishable before running the experiment.

Set a bound proportional to the decision: time, scope, data volume, or number of approaches. If several independent questions remain, split them or choose the one with the greatest effect on the decision.

## Choose the Experiment

Use the smallest experiment capable of producing credible evidence. Depending on the unknown, that may be a focused prototype, benchmark, trace, compatibility check, source inspection, or proof of concept.

Keep the setup representative only where representation affects the answer. Use realistic inputs and constraints, but omit production architecture, polish, generalization, and error handling that do not improve the evidence.

Separate the experiment from production behavior. Mark disposable code clearly, avoid letting it establish accidental interfaces, and do not keep it merely because it already works.

## Check the Result

Ask:

- Did the experiment answer the stated question?
- Is the evidence strong enough for the decision being made?
- Which assumptions or environmental differences limit the result?
- Did the result validate, reject, or reshape the available options?
- Is another experiment genuinely necessary, or can the work proceed?

## Present the Finding

Report the question, experiment, evidence, limitations, and resulting decision. Distinguish observations from interpretation.

Learning is the deliverable. Production code, if warranted, begins as a separate implementation shaped by what the spike established—not by promoting the experiment unchanged.
