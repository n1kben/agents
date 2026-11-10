---
name: encode-lessons
description: Turn a mistake into a check that fails, and install the bundled lint rules. Use when the user corrects you, a review comment lands, a check fails, you repeat a mistake, when handing off, or when a project lacks the bundled rules.
---

When you hand off, list the mistakes that could happen again and the check that would catch each. Build one once the user approves.

Use the strongest fix that works: make the mistake impossible to write, then a lint or CI check whose error names the fix, then a test. Write it down only when it needs judgment.

Prove the check fails on the real mistake and passes on the fix. If existing code already breaks it, fail only on new violations.

Delete any written rule the check replaces. If the lesson applies beyond this project, propose adding it to the bundled rules.

## Bundled rules

`assets/` holds lint rules. Copy the ones the project needs into `tools/`, wire them into its linter and CI, and run them. Once copied, they belong to the project.
