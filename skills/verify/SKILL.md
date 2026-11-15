---
name: verify
description: Verify a change works the way it's actually used. Use before calling work done, or when asked to test or verify something.
---

Start with exploratory testing: use the real app like a user would, with realistic data, after your last change.

If something blocks you from running it in the real app, find out why and fix that. Ask the user if you need their help.

Use every testing technique that could find a bug: example-based testing for what was asked, edge cases and what mustn't break, fuzzing for malformed and random input, property-based testing for invariants, and model checking for concurrency like races and retries.

Automate when the input space is too big to cover by hand and a miss would be costly.

Unless it's trivial, have a fresh subagent do adversarial testing, knowing only what was asked.

Report what you saw, and don't fix what's broken. Respond with this template:

```markdown
**{Works|Broken|Partly}**: {one-line summary}

### {Technique} · {Manual|Automated}
Works:
- {Case}: {what you saw}
Broken:
- {Case}: {what happened, steps to reproduce}

### {Next technique} · {Manual|Automated}
…

Not tried: {techniques or cases you skipped, and why}
```
