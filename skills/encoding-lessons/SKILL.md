---
name: encoding-lessons
description: Turn a mistake into a check that fails, and install the bundled lint rules. Use when the user corrects you, a review comment lands, a check fails, you repeat a mistake, or a project lacks the bundled rules.
---

When you hand off, list the mistakes that could happen again and the check that would catch each. Build one once the user approves.

Use the strongest fix that works: make the mistake impossible to write, then a lint or CI check whose error names the fix, then a test. Write it down only when it needs judgment.

Prove the check fails on the real mistake and passes on the fix. If existing code already breaks it, fail only on new violations.

Delete any written rule the check replaces.

## Bundled rules

Copy the rules for the project's languages, wire them into its linter, and run them. Once copied, they belong to the project.

- **TypeScript:** copy `assets/oxlint/ts` to `tools/oxlint/ts`, and merge `assets/oxlint.config.ts` into the project's config. Install `oxlint` and `@oxlint/plugins` at the same exact version; if `oxlint` is already installed, match its version. If the project isn't `"type": "module"`, name the config `oxlint.config.mts`.
- **React:** also copy `assets/oxlint/react` to `tools/oxlint/react`.
- **Effect:** also copy `assets/oxlint/effect` to `tools/oxlint/effect`.
- Drop the `lessons-react` or `lessons-effect` plugin and rules from the config when the project doesn't use React or Effect. Copy `assets/oxlint/LICENSE-anti-slop` alongside.
- **Swift:** copy `assets/swift-lessons` to `tools/swift-lessons`, and run `swift run --package-path tools/swift-lessons lessons <source dirs>` in CI. Set its `swift-syntax` version to match the project's Swift version. Add rules as files in `Sources/lessons/Rules` and list them in `main.swift`.
- **Other languages:** no comments of any kind, including documentation comments. Use a syntax-aware check, so comment-like text in strings stays valid.

In TypeScript, a disable comment switches lint rules off, and oxlint can't refuse one. Add this CI step so any disable comment fails the build:

```sh
! git grep -nE '(eslint|oxlint)-disable' -- '*.ts' '*.tsx' '*.mts' '*.cts' '*.js' '*.jsx' ':!tools/oxlint'
```
