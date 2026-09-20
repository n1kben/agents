---
name: coding-standards
description: Use only when `coding-standards` is specifically mentioned.
---

# Coding standards

Follow project conventions first. Use these standards when the project has no rule.

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

## Build one use case at a time

Start with a screen, route, endpoint, job, command, or another observable use case. Identify what
starts it, what it should produce, how it can fail, and what it changes.

Implement the use case end to end. Keep its code together until part of it has a separate
responsibility. Do not split it only because the file is long.

## Share code only when it must change together

Similar code can follow different rules:

```text
registerUser: validate email, reserve handle, send welcome message
updateProfile: validate email, save profile, notify security log
```

Share email validation. Keep the workflows separate.

Do not add extension points for hypothetical uses. Build the second use first, then extract what
actually varies.

## Make abstractions earn their place

Start with code that is hard to get right or where bugs recur. The abstraction should make all
decisions needed to keep that code correct. If callers still make those decisions, the abstraction
is incomplete. Reuse is not required.

Use the smallest construct that solves the problem. Do not add state or coordination unless the
problem requires it.

Delete wrappers that only rename another call. Keep a wrapper only if it changes or guarantees
behavior.

## Keep interfaces small

Keep interfaces small and each operation specific.

```text
saveDraft(document)
publish(document)
// Not save(document, mode = "publish")
```

## Preserve contracts across versions

Design a contract around whether its producers and consumers can be updated together. When code
ships together, a breaking change can update every caller at once, so its types only need to
represent current valid states. Contracts used across releases, and data that outlives a release,
must remain compatible with older versions.

Prefer additive change:

- Add optional information without changing the meaning of existing information.
- Let readers ignore fields they do not use.
- Preserve previously valid inputs.
- Keep defaults stable and explicit.
- Keep old and new representations readable during a staged rollout.

Treat these as breaking changes unless the whole dependency graph changes together:

- making an optional value required;
- removing or renaming a field;
- changing null from "absent" to "unknown";
- reusing a value with a new meaning;
- adding a case to a closed enum or union that callers handle exhaustively;
- changing ordering, atomicity, or failure guarantees.

Serialized shape is only part of compatibility. A response with the same fields can still break a
caller if a field changes units, interpretation, timing, or source of truth.

## Use types to exclude invalid values

Decode external data into the program's types before using it. Required fields should not be
nullable. Represent optional fields explicitly. Use parsed types where a value has additional
rules.

```text
type Signup =
    { email : EmailAddress
    , profile : Profile
    , preferences : Preferences
    }

type Profile =
    { displayName : String
    , avatarUrl : Maybe Url
    }

type Preferences =
    { locale : Locale
    , marketingEmails : Bool
    }

type Locale
    = En
    | Sv

signup = Signup.parse(request)
createAccount(signup)
```

Use distinct types for values that cannot be exchanged safely. An `AccountId` is not a `PaymentId`;
milliseconds are not seconds.

Check rules the type system cannot enforce immediately before code that depends on them.

## Make expected failures explicit

Name each expected failure in the function's type instead of replacing them with a general error.

```text
placeOrder(order) -> Result<Order, OutOfStock | PaymentDeclined>
// Not Result<Order, OperationFailed>
```

Do not return dependency-specific errors from an operation. Translate them first:

```text
database unique_violation -> HandleAlreadyTaken
payment gateway timeout   -> PaymentTemporarilyUnavailable
```

Expected failures can happen during correct operation. A violated internal invariant is a bug, not
an expected failure. Fail immediately.

## Do not share mutable state

Whoever creates mutable state owns it and its lifetime. Only the owner changes that state. Other
code may request changes through returned values or callbacks, but the mutable value never crosses
the boundary.

## Functional core, imperative shell

Prefer a functional core and move effects to the edges.

## Bound work

Set limits on queues, batches, concurrency, retries, polling, and work driven by external input.
Define what happens when a limit is reached.

## Define failure recovery

Define how an operation handles partial failure. State whether changes are transactional, rolled
back or compensated, and whether retries are idempotent.

## Test behavior

- Test behavior whose failure matters. Coverage is not a goal by itself.
- Test through the production interface when it stays fast and deterministic. Use lower-level tests
  only when that interface makes the test slow or hard to diagnose.
- Assert visible results and effects, not implementation details. Derive expected results
  independently from production code.
- Test failure cases, limits, concurrency, and recovery in proportion to risk. Fake only systems the
  test cannot control.

## Write for the reader

Start each file with its public API and the data models needed to understand it. Put private helpers
below the code that uses them.

Use names that say what the code does.

```text
calculateRenewalDate
// Not processDate
```

If a precise name is hard to find, the code may have more than one job. Avoid broad names such as
`Manager`, `Processor`, `Service`, or `Helper`.

Use comments to explain why code exists when the code cannot make the reason clear. Do not restate
the code in words.

Delete obsolete code, stale comments, and unused options.
