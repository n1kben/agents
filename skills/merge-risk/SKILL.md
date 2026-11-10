---
name: merge-risk
description: Assess how risky it is to merge a pull request. Use when asked about a PR's merge risk, and after opening or updating one.
---

Answer: how risky is it to merge this PR?

If merging doesn't make the code live, separate the risk now from the risk once it's live.

Weigh how well it's verified, how hard it is to undo, and whether anyone would notice if it broke in production. Mention one only where it raises the risk.

If it's a one-way door, propose splitting it: a reversible PR with everything else, behind a flag if needed, and a stacked PR that goes through the door.

List deliberate choices the user hasn't already made, as questions they can overrule.

Asking about risk is not approval to merge.
