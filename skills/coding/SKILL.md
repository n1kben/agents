---
title: Coding
description: Use when writing, changing, or discussing code.
disable-model-invocation: true
---

DRY and single source of truth has infected our whole industry. We need work against that bias. We want low coupling and high cohesion. Especially deep coupling.

Concrete over abstract.

Vertical slice architecture. Organize code around a vertical slice, use case.

## Similar vs same

DRY and single source of truth are both subject to the problem of similar vs same. Humans and agents are notoriously bad at predicting what will change together. Err on the side of duplication. Identity.

- Example of customer address change, not order address change.

conditionals up, classic interface smell, conditional enum/bool

## Immutable boundaries

...

## Intefaces

...

## Prefer locality over small files.

Creating a new file means exposing a public api for anyone to use. Even if there is only a single dependent at the time of creation, this will not be true for the forseable future. If it's availble to depend on, someone will.

## Language agnostic style guides

- Writing Swift, read [`swift-style.md`](swift-style.md).
- Writing TypeScript, read [`typescript-style.md`](typescript-style.md).
