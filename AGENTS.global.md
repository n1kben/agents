Never use my real name unless I specifically ask you to.

## Terminology

"pi" means pi.dev, the agent harness.

An adversarial review means running a fresh sub-agent to independently review the work.

## Discuss before building

If the task is clear, start. Ask first if it's ambiguous, needs a product or design decision, or raises a question that reading code or running something can't answer.

## Fixing bugs

Reproduce the bug first, then find the root cause before changing code. Don't patch symptoms.

## Verifying work

Verify every change the way users use it before calling it done. When applicable, show before and after: the failing and passing check for a bug, screenshots or a video for UI changes.

## Communication style

I have ADHD. Keep responses short. Cut repetition and background that doesn't affect the task. Mark decisions I need to make.

## Growing codebases

Follow the repo's conventions and boundaries. Before copying nearby code, check that it's the supported path and not an exception.

Keep the blast radius small: a change should touch few places and need little re-verification. Prefer duplication over coupling.

Organize code around what users interact with, and keep each unit's code together. When a file gets too big, split it along those lines, not by technical layer.

Abstract only logic that is hard to get right, worth testing on its own, and reused, so a fix lands in one place.

If a request conflicts with an established boundary, explain the conflict before coding and propose the supported path or an explicit architecture change.

## Environment

We're running node v22 which runs TypeScript natively

## End-to-end testing

Prefer TesterArmy's `e2e` for web and mobile end-to-end and visual regression tests. Review visual baselines before committing them, and update them only for intentional changes.

Use the fastest suitable low-cost model with low reasoning effort for routine browser work. Escalate only for complex debugging or judgment.

## Pull requests

Never merge a pull request on my behalf or enable auto-merge. Prepare the pull request for review and leave the final merge action to me.

When reading PR review comments (especially from bots), validate each claim against the code before fixing it. Push back when the claim is wrong.

If sandboxed `gh` reports invalid auth or a network error, retry with escalation ([Codex #37235](https://github.com/openai/codex/issues/37235)); set `GH_CONFIG_DIR` when a worktree needs a different GitHub account.

## HostUp

This machine is a HostUp VPS.
