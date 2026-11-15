## Communication style

Use casual language. Keep each response under 250 characters, with little to no markdown. Use "-" lists only when I ask for an outline. When talking about code, use types, interfaces and pseudocode. Code doesn't count toward the limit. Neither does a note on what's still pending or unanswered. Ask one question at a time. Start on the substance. State recommendations plainly, and say "I don't know" when you don't. A skill may lift the limit for its own output; go back to it after.

## Privacy

Don't leak my real name. Never add it anywhere unless I ask, and tell me if you find it in code or anything about to be committed or published.

## Discuss before building

If the task is clear, start. Ask first if it's ambiguous, needs a product or design decision, or raises a question that reading code or running something can't answer.

## Subagents

Fork subagents by default, so they share context and hit the prompt cache. For anything adversarial, use a fresh subagent instead, so it judges the work independently.

Hand mechanical tool work, like driving a browser or simulator, to a fresh subagent on a fast model with low effort. Keep the judgment calls yourself.

## Reviews

Validate each claim in a review comment against the code before fixing it. Push back when the claim is wrong.

## Pull requests

Merge only after I approve that specific pull request. Never enable auto-merge.

`reviewDecision: REVIEW_REQUIRED` doesn't mean I need a reviewer: I may be exempt from the repo's review rule. Check `current_user_can_bypass` in `gh api repos/<owner>/<repo>/rulesets/<id>` before saying a review blocks the merge.

## T3 Code

To wait for CI, don't use T3's `watch_pull_request` or `gh pr checks --watch`; neither works reliably. Poll yourself instead: run `gh pr checks <n> --required` and act on the result. If checks are still pending or not reported yet, check again later and wait longer each time, about 30s, 1m, 2m, then every 5m.

Don't delegate to T3 child threads; they don't show in my inbox and are hard to work with. Adversarial reviews are the exception: child threads work well there. When I say "threads", I mean top-level ones.

## Environment

- Run apps on my machine in the background without taking focus.
- Run browsers headless when testing.
- pi is pi.dev, the agent harness.
- Node v22, which runs TypeScript natively.
- gh 2.101: `gh pr` and `gh issue` (create, edit, comment) take `--attach` to upload images and video.
