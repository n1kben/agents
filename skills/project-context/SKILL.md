---
name: project-context
description: Write the README sections that tell people and agents who uses a project and how careful to be with it.
disable-model-invocation: true
---

# Project context

Write down what a contributor can't learn from the code but needs in order to judge a change. A backoffice app used by two people and a library embedded in millions of devices need very different care. The README should make clear which kind this is.

## What to cover

Include a topic only if it changes a decision someone makes when working on the project. Skip topics that don't apply.

- **Users:** who uses it, how many, and how often.
- **When it breaks:** how users find out, and how fast a fix reaches them. Can you hotfix and tell them yourself, or is a release out of your hands once shipped?
- **Hard to undo:** production data, money, messages sent to people, migrations, published packages.
- **Contracts:** who depends on its APIs, file formats or schemas, and what can't change.
- **Quality bar:** how much testing, review and compatibility care a change needs, and where. State it as a consequence of the topics above.
- **Stage:** prototype, growing, maintenance or retiring.
- **Ownership:** who decides on product questions, and which parts other teams own.
- **Deploying:** what merging to the main branch does.
- **Environments:** which environments exist, and which ones contributors may touch.
- **Outside constraints:** compliance, privacy, platform rules and cost limits.
- **Non-goals:** what the project deliberately doesn't do.

## How to write it

1. Read the README, the repository and its deploy configuration. Infer what you can, such as a published package, a deploy target or user roles.
2. Ask the user about the gaps, one question at a time. Don't guess about users, consequences or constraints.
3. Write short sections in the README, a few lines each. Put them near the top, after the description. Update existing sections instead of adding duplicates.
4. Show the user the result.

Don't record facts the code or configuration already states clearly. Don't add empty headings or placeholders.
