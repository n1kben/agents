---
name: pr
description: Open or update a pull request. Use when creating one or pushing to one.
---

Rebase on the latest base branch before pushing. Run the verify skill, then the demo skill, after your last commit.

Write the description as a one-minute read for a reviewer who wasn't there. Claim nothing you didn't check. Drop a section only when it would be empty. Stay within the sizes in the comments.

```markdown
## Why

<!-- 1–2 sentences, plus links -->
{The problem or request.} {Links to the issue, thread or docs.}

## What

<!-- up to 5 lines -->
{What changed.}

Leaves out: {what it doesn't do, and why}.
Disables: {any check, test or lint rule it turns off, and why}.

## Demo

<!-- one clip or screenshot per behavior, from the demo skill -->
{Narration}
{clip}

## Tested

<!-- 3–5 cases that matter most, from the verify skill -->
- {Case}: {what you saw}
- Not tried: {what you didn't test, and why}

## Merge risk

<!-- from the merge-risk skill -->
```

Skip the demo when nothing user-facing changed, and say so under What.

Attach images and videos with `gh pr create --attach <file>` or `gh pr edit --attach <file>`. When anything changes, update the description instead of commenting.

After pushing, wait for CI and fix what fails. Pending is not green.

Hand back in chat with the PR link, the merge risk, and what isn't done.
