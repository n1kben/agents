---
name: domain-modeling
description: Build and sharpen a project's domain model. Use when discussing codebase terminology, writing or editing a CONTEXT.md, or recording or editing an ADR.
---

# Domain Modeling

Build the domain model as you learn about the problem. Do not try to get the taxonomy right up front. Start with concrete cases, ask what information is actually there, and let the terms, relationships, and boundaries come out of that.

A good habit is to consider a few different ways to represent the same situation before settling on one. Pay attention to data that keeps traveling together, states that should not be possible, and invariants that should always hold. The goal is not a clever model. It is a model where the important facts of the domain work out nicely.

## File structure

Use one root `CONTEXT.md` for the project's domain language, and `docs/adr/` for ADRs:

```text
/
├── CONTEXT.md
├── docs/
│   └── adr/
│       ├── 0001-event-sourced-orders.md
│       └── 0002-postgres-for-write-model.md
└── src/
```

Create files lazily. If there is nothing useful to write yet, do not create them.

## During the session

### Start with concrete scenarios

When a relationship is fuzzy, make it concrete. Walk through a real case and then try the awkward cases: cancellation after shipment, two users sharing an account, an address changing after an order was placed, whatever fits the domain.

Use the cases to discover the model rather than making the cases fit a model you already chose.

### Ask about identity

Ask what makes two things the same thing.

If two values contain exactly the same information, are they interchangeable? If all of the information changes, can it still be the same thing? Those questions usually tell you whether identity matters.

Also distinguish a current fact from a historical snapshot. A Customer's current address and the shipping address captured on an Order may look identical while representing different facts.

### Similar is not the same

Do not combine concepts just because they have the same fields or happen to behave the same way right now.

Ask whether they mean the same thing in the domain. Do they have the same invariants? Do they change for the same reasons? Can one change without the other? If the answers differ, keep them separate even if the representations happen to look similar.

### Find the invariants

When you hear "always", "never", "only", "at most", or "unless", there is probably something useful there.

Get clear on what should always hold and which states can actually exist. These guarantees often tell you more about the shape of the domain than trying to organize things directly.

### Challenge the language

When the user uses a term that conflicts with `CONTEXT.md`, call it out immediately:

"Your glossary defines 'cancellation' as X, but here you seem to mean Y. Are those actually the same thing?"

When a term is vague or overloaded, sharpen it:

"You're saying 'account'. Do you mean the Customer or the User? Those seem like different things."

Do not invent two terms when the domain really has one concept either. The goal is to make meaningful distinctions, not more vocabulary.

### Cross-reference with code

Treat the code as evidence about the current model, not automatically as the truth.

If the conversation and code disagree, surface the disagreement:

"Your code cancels an entire Order, but you just said individual Order Lines can be cancelled. Which reflects the domain?"

That contradiction is often where something useful is hiding.

### Update `CONTEXT.md` as things become clear

When a term or distinction crystallises, capture it right away. Do not batch these up for later.

Use [CONTEXT-FORMAT.md](./CONTEXT-FORMAT.md).

`CONTEXT.md` is the domain language: terms, meanings, distinctions, relationships, and domain facts. Keep implementation details out of it. Do not turn it into a spec, scratch pad, or design document.

### Offer ADRs sparingly

Only offer an ADR when all three are true:

1. **Hard to reverse** — changing the decision later would be meaningfully expensive.
2. **Surprising without context** — a future reader is likely to ask why it was done this way.
3. **A real trade-off** — there were genuine alternatives and one was chosen for a reason.

If any of these are missing, skip the ADR. Use [ADR-FORMAT.md](./ADR-FORMAT.md).
