---
name: matching-visuals
description: Visual matching playbook. Use when UI must match a reference exactly, such as a design, a screenshot, or another implementation, or when changing UI that must look the same afterwards.
disable-model-invocation: true
---

# Matching visuals

Before changing anything, screenshot the reference in every state that matters.

Compare with an image diff, not by eye. Any difference is a failure. Find its cause and fix it until the diff is zero.

Never change the reference, the diff tool, or its threshold to make a diff pass. If the reference looks wrong, ask.
