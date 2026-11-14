# Refactor

## Pin the behavior

Before changing code, make sure checks cover what the refactor touches. Add tests or capture the real output where they don't. Run them green.

## Change

Change structure only. Fix bugs you find in a separate change.

Look for deletions first. Move in small steps and keep the checks green after each one.

## Handback

Hand back in chat and in the PR description with this template. Drop a section only when it would be empty.

```markdown
## Why <!-- PR only -->

{What the old structure made hard.} {Links.}

## What

{What moved, in a few lines.}

Leaves out: {what it doesn't touch, and why}.

## Same behavior

{The checks green before and after.} Not covered: {what they miss}.

## Simpler

{Lines, files or concepts removed, in numbers.}

## Blast radius

{Callers touched, and anything outside the checks.}

## Merge risk

{From the merge-risk skill.}
```

Mention any check, test or lint rule the change disables under What.
