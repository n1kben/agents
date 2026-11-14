---
name: you-got-this
description: Playbooks for getting work done. Use only when "you got this" is specifically mentioned.
---

Pick the playbook that fits and read only that file:

- New or changed behavior: `feature.md`
- Something broken: `bug.md`
- Same behavior, better code: `refactor.md`
- None of these: use the expert-mode skill

If the work spans more than one, split it into one change per playbook, refactor first.

Take the work to a pull request without the user's help. Decide reversible things yourself. Ask before anything that can't be undone, like merging, deploying, deleting data or sending messages. If you're blocked, say what blocks you and what you need.

## Writing code

### Laziness

Aim for the most result with the least code and complexity. Be lazy about the solution, never about understanding the problem.

- Skip what nobody needs yet, including guards against failures you can't describe concretely. Mention the ones you skipped. Don't scaffold for later.
- Before writing new code, reuse what the codebase, standard library, platform or installed dependencies already provide, after checking their docs and types, but only as-is. Don't add a flag or mode to existing code to fit a new case; write a separate version instead.
- Prefer deletion: look for removals before additions.

Never simplify away input validation, data-loss protection, security, or accessibility.

### Growing codebases

Follow the repo's conventions and boundaries.

Agents now ship many times faster, so optimize for changes you can verify in one place. Prefer cohesion and isolation over coupling, so a change's blast radius stays small. Couple code only when keeping it apart would be clearly foolish. Reuse what the repo already shares, but don't couple features to avoid duplication: copies may drift and a bug may need fixing twice, and that's the trade.

Build the smallest version that works end to end first, and keep it working as you add to it.

Organize code around what users interact with, such as routes, screens or features, and keep each unit's code together. When a file gets too big, split it along those lines, not by technical layer.

Abstract only problems that are hard to get right, worth testing on their own, and reused, so a fix lands in one place.

When replacing an API, migrate every caller and delete the old one in the same change.

### UI

Use native components the way the platform intends: pick the component built for the job, keep its default behavior, and follow the platform's design guidelines. Don't restyle or wrap a component to imitate a different one.

## Handback

Hand back with the playbook's template, written for someone who wasn't there, as a one-minute read. Use it for the PR description and the chat reply. Claim nothing you didn't check. Assess merge risk with the merge-risk skill.

In chat, end with:

```markdown
- PR: {link}
- Done: {committed, pushed, merged, deployed}
- Not done: {what's left}
- Needs you: {one decision}
```

The chat handback may run past the usual length limit. Go back to the limit after it.

Rebase on the latest base branch before pushing. Attach images and videos with `gh pr create --attach <file>` or `gh pr edit --attach <file>`. When anything changes, update the description instead of commenting. After pushing, wait for CI and fix what fails. Pending is not green.
