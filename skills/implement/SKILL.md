---
name: implement
description: Implement a plan in small, testable vertical slices.
disable-model-invocation: true
---

Make the change easy, then make the easy change.

Work in small vertical slices. Each slice should deliver one observable behavior and be easy to review, test, revert, and delete.

Do one kind of work per step: prepare, implement, test, or commit.

Commit early and often.

At the end, mention only high-confidence candidates found during the work: **local boundaries** that shrink one use case's reasoning world, and **sharing candidates** that pass the rule of three.
