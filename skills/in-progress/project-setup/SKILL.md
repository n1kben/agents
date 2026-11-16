---
name: project-setup
description: Set up a project that has no goals, non-goals or promises written down yet.
disable-model-invocation: true
---

The codebase will be the best doc, so only write down what code will never tell you. Assume agents write and maintain the code.

If the project already has code or a README, read them first and skip what they answer. Ask about what the project aims to be, not what it is today, one question at a time:

- Audience: who it's for, and roughly how many: a family of 3, around 50, or 10k+. Past that, nobody can say for sure
- Stakes: what a bug costs
- Lifespan: how long it has to last
- Non-goals: what it's deliberately not trying to be
- Trade-offs: ranked, for example reliability over speed
- Promises outside the repo: SLAs, contracts, public APIs, file formats
- Dependents: who builds on it from outside
- Regulation and legal duties

Write the answers into the README, one line each, following this template. If a README already exists, add the missing sections and keep the rest. Leave a section out if it has nothing in it.

```md
# <Name>

<One sentence: what it is and who it's for.>

## Goals

- <Audience: who it's for, roughly how many>
- <Stakes: what a bug costs>
- <Lifespan: how long it has to last>
- <Trade-offs, ranked: e.g. reliability over speed>

## Non-goals

- <What it's deliberately not trying to be>

## Promises

- <Who depends on it, and what they can count on: APIs, file formats, SLAs>
- <Regulation and legal duties>

## Getting started

<How to run it, in one or two commands.>
```
