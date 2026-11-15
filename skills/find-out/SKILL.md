---
name: find-out
description: Settle an unknown instead of guessing. Use before acting on an assumption, before copying a pattern, or before asking the user something you could find out.
---

Find out instead of guessing. Don't ask the user what you can look up yourself. If the question is ambiguous, state your reading and go.

## How it works

Explain it so a senior engineer new to the area could start working in it. Follow it from where it's triggered to the code that does the work, citing file:line. Where you're unsure, add a log and run it.

## What uses it

Find every use, including dynamic and generated ones. Follow the newest way, not the legacy one.

## Why it is this way

Answer from the record, not the code: the commits, PRs and issues that introduced it and each later change. Quote the authors, check that the reason still holds, and say what the record doesn't answer.

## Whether it's true

Test against a baseline with real data. A test you never saw fail proves nothing.

## Which to pick

Build three versions you'd each ship, each a different direction. Make each fully work, try each yourself, then show them in context with instant switching, each with its strength and cost.

## Who solved it

Read the docs for the version in use, then the library's tests, source and issues. Not blog posts or forum answers.

## Respond

```markdown
**{Answer}**
{Evidence: file:line, commit, quote or output}
Guesses: {what you inferred}
Open: {what you couldn't settle}
```
