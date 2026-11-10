---
name: pull-requesting
description: Pull request playbook. Use when opening or updating a pull request, or getting its CI green.
---

# Pull requesting

Prefer several small pull requests to one large one. Each should be safe to merge on its own.

The description contains, in order:

- Why: the problem or goal behind the change.
- References: issues, threads, docs, related pull requests.
- What: a short summary of the change.
- Proof: before and after evidence that it works, such as screenshots, video, or output from logs, commands and manual checks.

Drop a section that has nothing to say. The reviewer has the diff, so don't list changes file by file.

Attach screenshots and videos so reviewers can see it working without running anything. `gh pr create` and `gh pr edit` take `--attach <file>` (gh 2.101 or later).

## CI

After pushing, wait for CI to finish and fix whatever fails. It is easy to walk away while it is still running. Pending is not green.
