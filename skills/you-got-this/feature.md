# Feature

## Build

Know what the user does and sees before and after. Settle unknowns before building.

Build the smallest version that works end to end, then grow it in slices. Commit each slice once its checks pass.

## Verify and demo

Run the verify skill, then the demo skill.

## Handback

Hand back in chat and in the PR description with this template. Drop a section only when it would be empty.

```markdown
## Why <!-- PR only -->

{The problem or request, in one or two sentences.} {Links to the issue, thread or docs.}

## What

{What changed, in a few lines.}

Leaves out: {what it doesn't do, and why}.

## Demo

{Captioned clips or screenshots, before and after.}

## Tested

- {Case}: {what you saw}
- Not tried: {what you didn't test}

## Judgment calls

- {Choice you made the reader can overrule, and why}
- {Rough edge}

## Merge risk

{From the merge-risk skill.}

## Try it

{Steps to try it yourself.}
```

Mention any check, test or lint rule the change disables under What.
