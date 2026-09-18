---
name: visual-pr
description: Use only when explicitly invoked as $visual-pr to draft, create, or update a pull request with a concise visual description.
disable-model-invocation: true
---

# Visual PR

Draft, create, or update the pull request for the current branch with a description that helps a reviewer understand why the change exists, how behavior changed, and where to look.

## Prepare

Read these references before writing:

- `references/pr-description-template.md`
- `references/visual-outline.md`

Inspect the repository's `AGENTS.md` and pull request template. Repository rules take precedence.

Find the current branch's pull request with:

```sh
gh pr view --json url,number,title,state,baseRefName,headRefName
```

If there is no pull request, inspect the branch, working tree, and commits. Do not commit, push, or create a pull request unless the user asked you to create or publish one. Never include unrelated working-tree changes.

## Understand the change

Read:

- the complete diff against the pull request base
- enough surrounding code to identify behavior and ownership
- linked tickets, plans, and task artifacts that are available
- existing tests and verification results relevant to the change

Use facts from the repository and task. Do not invent motivation, constraints, test results, or links.

## Write the description

Follow `references/pr-description-template.md` exactly, plus any repository-required sections.

- Keep **Why the change** to one sentence.
- Keep **Special things to note** to one to three reviewer-relevant bullets. Use `- None.` if nothing needs attention.
- Make **Change outline** a compact structural view. Include only the contracts, types, files, components, calls, state, or data flow needed to explain the change.
- Prefer `diff` blocks for changes to an existing shape. Show a complete block when most of the shape is new or diff notation hides ownership or order.
- For a user-interface change, include before-and-after screenshots from the app, sandbox, or story. If useful screenshots cannot be produced, say why.
- List every changed file under **Files changed**. Give each file one sentence of no more than 25 words. Show the changed public interface in a small `diff` block when the file changes one.
- Include importer counts when they materially help a reviewer judge the effect of a public-interface change and the counts can be verified.
- Keep implementation detail out unless it changes reviewer behavior or explains an important decision.

Write as one person talking to another. Use plain, concise language.

## Save and publish

Write the body to a repository task artifact when the repository has an established location. Otherwise, use a temporary file outside the repository so the PR description does not add an unrelated tracked file.

When the user asked to update or create the pull request:

1. Apply the description with `gh pr edit <number> --body-file <path>` or create the pull request with `gh pr create --body-file <path>`.
2. Read the published pull request back with `gh pr view`.
3. Confirm that the title, body, base branch, and head branch are correct.

When the user asked only for a draft, return the draft without changing GitHub.

## Report

Return:

- the pull request link, if one exists
- whether the description was drafted or published
- the description file, if it is a durable task artifact
- any missing screenshot, verification, ticket, or publishing context

Keep the handoff short. Do not repeat the full PR description in the final response when it is already available through a link or file.
