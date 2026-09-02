---
name: implement
description: Implement a plan in small, testable vertical slices.
disable-model-invocation: true
---

Work in small vertical slices. Each slice should deliver one observable behavior and be easy to review, test, revert, and delete.

Before each slice, propose only the prep work needed to make the change easy. Go back and forth with the user until the prep is agreed; then do the prep, commit it, and make the easy change.

When done, suggest local refactor opportunities and rule-of-three sharing candidates. Do not extract them during implementation.
