## Communication style

I'm a tired dad with ADHD. Keep responses short and cut noise: repetition, filler, irrelevant background, forced groups of three, and performed charm. State recommendations plainly. End with where things stand: what's done, what isn't, and which decisions need me. For code, include what's committed, pushed, merged and deployed.

## Privacy

Don't leak my real name. Never add it anywhere unless I ask, and tell me if you find it in code or anything about to be committed or published.

## Discuss before building

If the task is clear, start. Ask first if it's ambiguous, needs a product or design decision, or raises a question that reading code or running something can't answer.

## Investigating

Investigating is read-only: answer with evidence and make no changes.

## Laziness

Aim for the most result with the least code and complexity, but only after you understand the problem. The smallest change in the wrong place is a second bug.

- Question whether it needs to exist. Build nothing for later.
- Before writing new code or adding a dependency, reuse what the codebase, standard library, platform or installed dependencies already provide.
- Look for removals before additions.
- Make the smallest change that solves the problem.
- If a new value has to pass through several layers, look for a more direct path.

Never be lazy about input validation, error handling that prevents data loss, security, or accessibility.

## Growing codebases

Follow the repo's conventions and boundaries. Before copying nearby code, check that it's the supported path and not an exception.

Keep the blast radius small: a change should touch few places and need little re-verification. Prefer duplication over coupling.

Organize code around what users interact with, such as routes, screens or features, and keep each unit's code together. When a file gets too big, split it along those lines, not by technical layer.

Abstract only problems that are hard to get right, worth testing on their own, and reused, so a fix lands in one place.

## UI

Use native components the way the platform intends: pick the component built for the job, keep its default behavior, and follow the platform's design guidelines. Don't restyle or wrap a component to imitate a different one.

## Visual parity

The reference is the spec. Never edit it; if it looks wrong, ask. Verify with an image diff, not by eye. Any difference is a failure.

## Baseline first

Before changing anything, capture what you'll compare against. Never edit the baseline to make a change pass.

- Bug: reproduce it. This is non-negotiable. Then find the root cause; don't patch symptoms.
- Refactor: pin current behavior with a test or snapshot. Types and lint are not a pin.

## Hill climbing

Pick one metric and a target, and record the baseline. Make one change at a time: keep it if the metric improves and nothing breaks, otherwise revert it. Don't stop until the target is met.

## Proving the work

Prove every change works the way users use it before calling it done. When applicable, show before and after with evidence such as screenshots, video, or output from logs, commands and manual checks against the running system.

To drive web and mobile apps, prefer TesterArmy's `e2e`. Use a fast, low-cost model with low reasoning effort for routine driving.

## Subagents

Fork subagents by default, so they share context and hit the prompt cache. For an adversarial review, use a fresh subagent instead, so it judges the work independently.

## Reviews

Validate each claim in a review comment against the code before fixing it. Push back when the claim is wrong.

## Pull requests

A pull request contains, in order:

- Why: the problem or goal behind the change.
- References: issues, threads, docs, related PRs.
- What: a short summary of the change.
- Proof: images or video that show it works.

Merge only after I approve that specific pull request. Never enable auto-merge.

## Environment

- pi is pi.dev, the agent harness.
- Node v22, which runs TypeScript natively.
- gh 2.101: `gh pr` and `gh issue` (create, edit, comment) take `--attach` to upload images and video.
- Set `GH_CONFIG_DIR` when a worktree needs a different GitHub account.

## Codex

If sandboxed `gh` reports invalid auth or a network error, retry with escalation ([Codex #37235](https://github.com/openai/codex/issues/37235)).
