---
name: encoding-lessons
description: Turn a mistake into a check that fails, and install the bundled lint rules into a project. Use when the user corrects you, states a rule with "always" or "never", a review comment lands, a check fails, you repeat a mistake, or a project lacks the bundled rules.
---

# Encoding lessons

Agents copy the code around them and miss written rules. Encode a lesson in the strongest mechanism that works, so the next agent can't repeat the mistake:

1. A type or API that can't represent the mistake.
2. A lint rule or check that fails CI.
3. A shared helper that makes the right way the easy way.
4. A runtime check where data enters the system.
5. Only when it needs judgment: a written rule with an example of the failure.

## Propose

When the user corrects you, a review comment lands, a check fails, or you repeat a mistake, say so right away, for example: "This is the second time X broke; a lint rule would catch it." Propose a check only when the mistake is likely to recur, and build it once the user approves.

## Build

Write one invalid example and its valid counterpart. Prove the invalid one fails the check and the valid one passes. Use the project's existing tools and keep its configuration. If existing code breaks the check, report it; don't weaken the check.

Delete any written rule the check replaces. If the lesson applies beyond this project, add it to the bundled rules too.

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
