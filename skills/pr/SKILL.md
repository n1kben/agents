---
name: pr
description: Open or update a pull request. Use when creating one or pushing to one.
---

Rebase on the latest base branch, then QA it and demo it.

The PR is a one-minute read for reviewers who weren't there: why, references, a short what, what it leaves out, a demo as proof, and the merge risk. Claim nothing you didn't check. Attach images and videos with `gh pr create --attach <file>` or `gh pr edit --attach <file>` (gh 2.101 or later).

After pushing, wait for CI and fix what fails. Pending is not green.

Hand off in chat with the demo, the merge risk, and what isn't done.
