---
name: adr
description: Write or update an architecture decision record.
disable-model-invocation: true
---

# ADR

Follow the repository's existing ADR conventions. If none exist, put ADRs in `docs/adr/` and number them sequentially, such as `0001-use-postgres.md`. Create the directory with the first ADR. Use the next number after the highest existing one.

Use this format:

```md
# {Short title of the decision}

{In one to three sentences, state the context, the decision, and why it was chosen.}
```

Keep it short. A single paragraph is enough.

Add these only when needed:

- Add status frontmatter when tracking the decision's lifecycle. Use `proposed`, `accepted`, `deprecated`, or `superseded by ADR-NNNN`.
- Add `## Considered options` when rejected alternatives are worth recording.
- Add `## Consequences` when the effects are not clear from the decision.

Use facts from the discussion and repository. Do not invent reasons, alternatives, or consequences. Ask one focused question if a required fact is missing.
