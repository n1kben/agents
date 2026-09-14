---
name: data-modeling
description: A conversation-led workflow for shaping persistent data without losing facts, distinctions, or history. Use when designing schemas, records, events, storage formats, migrations, or analytical data.
disable-model-invocation: true
---

# Data Modeling

Start with one concrete need to record, change, or learn something. Ask what must remain knowable after the current operation is finished.

Read the existing model, representative records, producers, consumers, and relevant history before choosing a representation. Preserve what the system has learned, not merely what today's interface happens to show.

## Establish the Facts

Describe what was observed without committing to a storage shape. Separate facts from assumptions, defaults, and conclusions derived from those facts.

Work through concrete examples and counterexamples. Ask where each fact comes from, when it becomes true, whether it can change or be corrected, and which distinctions consumers may need. Treat unknown, absent, and not applicable as different states when they mean different things.

Identify stable identities and the cardinality of relationships. Do not infer identity from a mutable name or collapse one-to-many facts because the first example contains only one.

## Shape the Representation

Try more than one way of representing the facts before choosing tables, documents, columns, or event shapes. Separate identity, state, and time unless the facts require them to move together. When two parts can change independently, prefer representations that allow them to evolve independently.

Keep units, identifiers, uncertainty, and provenance explicit. Distinguish when something happened, when it became effective, and when it was recorded whenever those times can differ. Avoid overloaded fields, sentinel values, and strings whose format secretly carries several meanings.

Prefer the smallest meaningful facts from which larger concepts can be derived. Store an interpretation only when it must persist independently, and retain the facts and rules that produced it.

## Protect the Information

Identify which representation is authoritative and which values are derived. If several stored values describe the same fact, decide who keeps them consistent and how disagreement is detected or repaired.

Decide what a correction means. It may replace an error, supersede an earlier claim, or introduce a new fact effective at another time. Preserve the earlier record when sequence, provenance, auditability, or reconstruction matters. A current value is not a substitute for the facts that produced it.

Plan how existing data will evolve. Prefer additive changes while old records or consumers still carry meaning. Treat migration defaults carefully: a convenient default may invent a fact that was never known.

Before collapsing, replacing, or deleting data, name what would become impossible to recover. If the loss is not intentional and acceptable, try another migration.

## Check the Model

Ask:

- Which facts are observed, and which are interpretations?
- Can independently changing facts evolve independently?
- Are identity, cardinality, time, units, absence, and uncertainty represented honestly?
- Can corrections be distinguished from later changes?
- What information would this representation make impossible to recover?
- Which values are authoritative, and which are derived?
- How will existing records and consumers move to this model?

If the model answers today's query by destroying distinctions that may matter tomorrow, try another representation.

## Present the Model

Use this structure for the working proposal. Omit details that do not affect the decision.

```md
# {Model or change}

## Need
What must be recorded, changed, or remain knowable?

## Examples
Representative cases, including relevant absence, corrections, and history.

## Facts
- Meaning and source
- Identity and cardinality
- When it happened, became effective, and was recorded
- Whether it can change or be corrected

## Representation
The proposed schema, record, or event shape.

## Authority
Which data is authoritative, which is derived, and who maintains it.

## Evolution
How existing records and consumers move without inventing or losing facts.

## Open Questions
Remaining assumptions and the strongest reason this model may be wrong.
```

Do not create a separate permanent document by default; the agreed schema, events, constraints, and migrations become the source of truth.

Do not change persistent data while the model is still being discussed. Once the user agrees, implement only the agreed representation and migration, then verify it against representative old and new data.
