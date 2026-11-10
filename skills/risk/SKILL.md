---
name: risk
description: Assess the risk of a change before making it. Use before anything hard to undo.
---

Run a pre-mortem, and assume Hyrum's Law.

Find the invariant the change relies on, and test it empirically. Mark anything untested.

Weigh severity, blast radius, likelihood, detectability, and time to recover.

Mitigate what you can. Escalate if residual risk stays high.

Give a go/no-go with a rollback plan.
