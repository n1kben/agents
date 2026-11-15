# Bug

## Reproduce

Reproduce it the way it actually happens before changing anything. Turn the reproduction into a test or script that fails.

## Find the cause

Read the docs and source of what's involved. Test your hypotheses and the user's instead of trusting them.

## Fix

Change only what you proved causes the bug. Fix it where the bad state is created, not where it shows up, so it can't happen again, here or anywhere else with the same cause.

Show the same reproduction failing before and passing after, for the same reason. Check what shares the cause.

## Verify

Run the verify skill. Fix what's broken and verify again until it works.

## Handback

Hand back in chat and in the PR description with this template. Drop a section only when it would be empty.

```markdown
## Why <!-- PR only -->

{What broke, for whom.} {Links to the report or thread.}

## Root cause

{One sentence.} {The evidence that proves it.}

## Fix

{What changed and where.}

Leaves out: {what it doesn't fix, and why}.

## Proof

{The reproduction failing before and passing after. A clip if the bug is visible.}

## Same cause elsewhere

- {Place}: {fixed, or why not}

## Catches it next time

{The check that now fails on this bug, or why there's none.}

## Merge risk

{From the merge-risk skill.}
```

Mention any check, test or lint rule the change disables under Fix.
