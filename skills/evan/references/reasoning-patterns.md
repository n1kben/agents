# Reasoning patterns

Use these reusable structures when the task needs analysis, critique, or design.

## Reframe a loaded term

1. Give the term’s technical meaning.
2. Show a minimal example where that meaning applies.
3. Show why the current dispute is actually about syntax, convenience, guarantees, or preference.
4. Replace the loaded label with a narrower description.

This prevents taste from masquerading as an objective theorem.

## Trace the history of a surprising constraint

1. What immediate problem created the first mechanism?
2. What later ecosystem need caused it to spread?
3. Which behavior was accidental rather than promised?
4. What consequences appeared in practice?
5. Which current boundary preserves the valuable guarantee?

Judge the present design after reconstructing this path.

## Evaluate a proposed abstraction

1. Put the real cases side by side.
2. Draw the dependency direction.
3. Change one case and see what else must move.
4. Identify the invariant the abstraction would own.
5. If the cases are only similar, keep them separate.
6. Revisit when the same pressure recurs in working code.

## Turn vague feedback into evidence

Ask for:

- the person’s background and goal;
- the exact artifact they saw;
- what they expected;
- what happened instead;
- the time or cost of the confusion;
- a minimal reproducible case;
- how common the case appears to be.

Then fix the system at the narrowest layer that addresses the evidence.

## Compare languages or tools generously

1. Ask why people love each option.
2. Name the user or organization each serves well.
3. Compare the total experience, not isolated features.
4. Include staffing, ecosystem, and adoption constraints when relevant.
5. State which objective drives the recommendation.

## Respond to “why don’t you just…”

1. Recover the useful goal.
2. State that the proposal is plausible at first glance.
3. Reveal the hidden cases with a concrete example.
4. Explain which guarantee, workload, or coordination cost would change.
5. Offer a smaller experiment or existing route.

## Decide whether to communicate uncertain work

Estimate the downstream cost of a tentative statement: premature migrations, polarized debate, support burden, and mistaken promises. Share early when feedback can be structured around a specific question. Otherwise wait until the design is stable enough that public context helps more than it churns.

## Analyze adoption or project health

Keep these variables separate:

- technical quality;
- learning and onboarding time;
- hiring practice;
- decision-maker incentives;
- funding source and headcount;
- maintenance capacity;
- growth metrics;
- user value;
- maintainer sustainability.

Do not infer one from another without evidence.
