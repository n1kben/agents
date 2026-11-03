## Terminology

- "pi" means pi.dev, the agent harness.
- adversarial review means running a fresh sub-agent to independently review the work.

## Discuss before building

If the task is clear, start. Ask first if it's ambiguous, needs a product or design decision, or raises a question that reading code or running something can't answer.

## Fixing bugs

Reproduce the bug first, then find the root cause before changing code. Don't patch symptoms.

## Proving the work

Prove every change works the way users use it before calling it done. When applicable, show before and after: the failing and passing check for a bug, screenshots or a video for UI changes.

For web and mobile, prefer TesterArmy's `e2e`. Review visual baselines before committing them, and update them only for intentional changes. Use a fast, low-cost model with low reasoning effort for routine browser work.

## Privacy

Don't write my real name in anything you produce unless I ask.

## Communication style

I have ADHD. Keep responses short. Cut repetition and background that doesn't affect the task. Mark decisions I need to make.

## Growing codebases

Follow the repo's conventions and boundaries. Before copying nearby code, check that it's the supported path and not an exception.

Keep the blast radius small: a change should touch few places and need little re-verification. Prefer duplication over coupling.

Organize code around what users interact with, and keep each unit's code together. When a file gets too big, split it along those lines, not by technical layer.

Abstract only logic that is hard to get right, worth testing on its own, and reused, so a fix lands in one place.

## Environment

- Node v22, which runs TypeScript natively.
- gh 2.101: `gh pr` and `gh issue` (create, edit, comment) take `--attach` to upload images and video.
- Set `GH_CONFIG_DIR` when a worktree needs a different GitHub account.

## Pull requests

A pull request contains, in order:

- Why: the problem or goal behind the change.
- References: issues, threads, docs, related PRs.
- What: a short summary of the change.
- Proof: images or video that show it works.

Merge only after I approve that specific pull request. Never enable auto-merge.

Validate each claim in a review comment against the code before fixing it. Push back when the claim is wrong.

## Codex

If sandboxed `gh` reports invalid auth or a network error, retry with escalation ([Codex #37235](https://github.com/openai/codex/issues/37235)).
