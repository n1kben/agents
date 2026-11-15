---
name: merge-risk
description: Assess how risky it is to merge a pull request. Use when asked about a PR's merge risk, and after opening or updating one.
---

Answer two things: the risk of merging now, and the risk once it's live. They differ when the code isn't live yet, like behind a flag or unused.

Weigh blast radius (how much breaks if it's wrong), coverage (how well it's verified), rollback (how hard it is to undo) and detection (whether anyone would notice it broke in production). Mention one only where it raises the risk.

If it's a one-way door, propose splitting it: a reversible PR with everything else, behind a flag if needed, and a stacked PR that goes through the door.

Respond with this template:

```markdown
**Merge now: {Low|Medium|High}**: {one-line reason}
**Once live: {Low|Medium|High}**: {one-line reason} <!-- or "same as merge" -->

- {Blast radius, coverage, rollback or detection}: {only what raises the risk}
- One-way door: {the split you propose}
```
