---
name: primitives
description: Use only when "primitives" is specifically mentioned.
disable-model-invocation: true
---

Propose the primitives the app should be built on: the few things every feature is built from, so a new feature is a new combination, not a new concept. Write the features on three genuinely different sets as stubs and pseudocode, and use the questions below to find where each breaks. Ask me when the answer is mine to give.

- List the features: what exists? what's next? what if it stops halfway, fails, or runs twice?
- Find the purpose: what is each primitive for, in one sentence?
- Find sameness: which features do the same thing in different ways? could they be one thing?
- Find owners: who owns it? what happens to what it started when its owner stops?
- Find failures: what if it fails, runs twice, or two run at once?
- Find the truth: where does each fact live? can what has to change together change in one write?
- Find friction: where does a feature need a special case, a workaround, or another primitive's internals?
- Test it: what breaks if we delete a primitive? what would a user hit that needs a special case?

Show the sets side by side: a name for each, the idea that sets it apart, when it's the right choice, and what it costs. If two sets differ only in naming, they're one set; replace one. Then recommend one and say why. For it, show each primitive with its purpose and a one-line scenario, plus the features that still need a special case.
