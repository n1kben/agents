---
name: coding-standards
description: Use only when `coding-standards` is specifically mentioned.
---

# Coding standards

Follow project conventions first. Use these standards when the project has no rule. Apply clear,
local improvements without asking. If a finding would change ownership, dependencies, a public
contract, or an abstraction boundary, report it instead of folding it into cleanup.

Source notes: [pstack.md](pstack.md).

Read only the references relevant to the task:

- For feature flags, experiment gates, kill switches, staged rollouts, or flag retirement, read
  [feature-flags.md](references/feature-flags.md).
- For localization, translations, message keys, plurals, accessibility copy, or localized UI text,
  read [localization.md](references/localization.md).
- For React components, hooks, Effects, state, or UI previews, read
  [react.md](references/react.md).
- For Swift, SwiftUI, typed throws, or Xcode previews, read [swift.md](references/swift.md).
- For TypeScript or TSX, schema inference, discriminated unions, or type narrowing, read
  [typescript.md](references/typescript.md).

## Own scheduling and bound work

Do not perform substantial work directly in reaction to external events. Accept the work into an
owned, bounded queue and process it at the program's pace.

Set explicit limits on queues, batches, concurrency, retries, and polling. Define what happens when
work arrives faster than it can be processed or a limit is reached.

## Define failure recovery

A state-changing operation must recover after a retry, restart, or partial failure. Check what
happens if it runs twice or stops after each write.

Use a transaction, roll back completed work, compensate for it, or resume from recorded progress.
Correctness must not depend on cleanup from an earlier run.

## Test behavior

- Test behavior whose failure matters. Coverage is not a goal by itself.
- Test through the public interface when the test stays fast and deterministic.
- Assert visible results and effects, not implementation details.
- Derive expected results independently from production code.
- Test failure cases, limits, concurrency, and recovery in proportion to risk.
- Fake only systems the test cannot control.

## Write for the reader

Start each file with its public API and the data models needed to understand it. Put private helpers
below the code that uses them.

Use precise names. Avoid broad names such as `Manager`, `Processor`, `Service`, or `Helper`. If a
precise name is hard to find, the code may have more than one job.

Use comments to explain why code exists when the code cannot make the reason clear. Do not restate
the code in words.

Delete obsolete code, stale comments, and unused options.
