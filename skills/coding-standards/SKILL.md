---
name: coding-standards
description: Use only when `coding-standards` is specifically mentioned.
---

# Coding standards

## Why have standards

Code grows one use case at a time. Each change leaves behind names, boundaries, contracts, and
tests. Those decisions determine whether the next change has one obvious home or must be spread
across the codebase.

Use these priorities, in order:

1. Preserve correctness. Make valid behavior and expected failures explicit.
2. Keep knowledge local. Give each rule, resource, and external dependency one owner.
3. Make change direct. Organize code around behavior and the reasons it changes.
4. Make the result easy to read. The main path should be visible without searching unrelated code.

Do not trade an earlier priority for a later one. Less code is not simpler when it weakens a
contract. Removing duplication is not an improvement when it couples unrelated use cases.

Follow explicit project conventions first. Otherwise, use these standards as defaults. Apply
structural guidance with judgment. Treat correctness and safety rules as strict.

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

## Start with behavior

Start with a screen, route, endpoint, job, command, or another use case someone can observe. Name:

- what starts the operation;
- what successful outcome it produces;
- which failures are expected;
- which state or external systems it changes.

Then write the path from input to outcome. Do not begin with a directory structure or a set of
layers. Structure should follow the behavior the program must provide.

Keep the first implementation together. Let the file grow. A long file is visible complexity.
Splitting it without finding separate responsibilities converts that complexity into navigation,
indirection, and coordination.

Put the main path before its details:

```text
request -> validate -> decide -> persist -> respond
```

A reader should be able to find that path without knowing the implementation in advance. Extracted
code should make a responsibility clearer, not merely make the main file shorter.

## Keep changes local

Put new behavior near the code that uses it. Keep private code with its caller until another
responsibility becomes clear.

This applies to data, tests, types, and small helpers as well as functions. Distance has a cost.
Every shared location makes the reader ask who else depends on it and which changes remain safe.

Allow duplication while the requirements are still becoming clear. Similar text is not enough reason
to share code. Two operations can look alike and still have different policies:

```text
registerUser: validate email, reserve handle, send welcome message
updateProfile: validate email, save profile, notify security log
```

The email syntax rule may deserve one definition. The two workflows do not. Share the smallest
authoritative fact, not the accidental shape of both use cases.

Do not create a strategy, registry, plugin point, base class, or configuration option for a caller
that does not exist. A concrete second need supplies information that speculation cannot:

- what truly varies;
- what must remain the same;
- who owns the decision;
- whether the two uses should change together.

Local code is easy to move later. A premature shared contract is harder to undo because callers
begin depending on it.

## Make abstractions earn their place

Create an abstraction when a responsibility needs one owner. Create it only when it does at least
one of these jobs:

- enforces an invariant;
- gives a business rule one authoritative definition;
- hides difficult or error-prone mechanics;
- owns mutable state or a resource lifecycle;
- translates between external and internal representations;
- isolates a framework, protocol, service, or persistence system;
- defines a policy such as retries, idempotency, authorization, or transactions.

An abstraction may serve one caller. Reuse is not the test. The test is whether the boundary
concentrates knowledge that its caller would otherwise need.

Choose the smallest form that owns the responsibility:

- Use a function for a calculation.
- Use a type for a fact that must remain true.
- Use an object or module for state, policy, or a resource that persists across calls.
- Use a service boundary only when deployment, ownership, scaling, or failure isolation requires
  one.

Reject pass-through abstractions:

```text
UserService.getUser(id)
    -> UserRepository.getUser(id)
        -> Database.getUser(id)
```

If every layer repeats the same operation and callers still need to understand the database
behavior, the layers add names without removing knowledge. Either give a boundary a real policy or
remove it.

Test an abstraction by changing the implementation in your head. If changing storage, retry
policy, or representation still forces every caller to change, the boundary does not own enough.
If unrelated caller behavior must move into the abstraction, it owns too much.

## Design from the caller

An interface should state what the caller wants to accomplish. Its implementation should own how
that outcome is produced.

Give each operation one meaning. Prefer named operations when the caller knows the behavior it
wants:

```text
saveDraft(document)
publish(document)
```

Avoid making callers select hidden control flow:

```text
save(document, mode = "publish")
```

The named operations can validate different invariants, expose different failures, and evolve
independently. A mode flag combines those behaviors behind one contract.

Pass data that describes the request. Do not pass callbacks, flags, or configuration that makes
the caller assemble the implementation from the outside. A caller asking to send a message should
not also choose connection pooling, retry timing, serialization, and batching.

Keep the common path direct. Put lower-level controls needed by a few callers behind a separate,
explicit interface. Power is useful when it is available; it is costly when every caller must
understand it.

State the complete contract:

- accepted inputs and returned outputs;
- expected failures;
- invariants and preconditions;
- observable side effects;
- ordering, consistency, and performance guarantees that correctness depends on.

Keep callers independent. Shared code should not ask which route, screen, or job invoked it. If it
does, the shared code contains caller-specific policy.

## Design contracts for their lifetime

Match a contract to where it is used.

An internal contract can change with all its callers when they ship together. Prefer the most
precise representation. Make impossible states unrepresentable and require exhaustive handling
when every affected caller can change in the same commit.

A contract that crosses a release or storage boundary has a higher requirement. Old and new
versions may coexist. Stored data may outlive the code that wrote it. Preserve previous guarantees
while the contract evolves.

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

Do not weaken every contract in anticipation of distribution. Choose compatibility from the
release process and data lifetime, not from whether the contract happens to use HTTP, files,
messages, or function calls.

## Represent what the program knows

Parse external data once, where it enters the program. Convert it into values that record what has
been established:

```text
email = EmailAddress.parse(request.email)
createAccount(email)
```

Code below that boundary should receive an `EmailAddress`, not an unchecked string that every
function must validate again.

Use types to rule out invalid states when the language allows it:

```text
LoadState = Loading | Loaded(Data) | Failed(LoadError)
```

Avoid a bag of booleans and optional values that also permits "loading and failed" or "loaded
without data." If the program cannot handle a combination, its normal representation should not
create that combination.

Give identifiers, units, and finite alternatives distinct representations when primitives would
erase their meaning. An `AccountId` and a `PaymentId` may both be strings, but exchanging them is
still a defect. A timeout in milliseconds and an interval in seconds may both be integers, but
adding them is not meaningful.

State assumptions that affect correctness and check them. When the type system cannot express an
invariant, assert it at the boundary that establishes it and near critical code that depends on
it. Assertions document programmer obligations and turn silent corruption into an immediate
failure.

## Make expected failures explicit

Expected failures are part of the contract. Return them with the strongest checked mechanism the
language provides:

```text
placeOrder(order) -> Result<Order, OutOfStock | PaymentDeclined>
```

Keep failures distinct while callers make different decisions from them. The caller may invite a
retry after `PaymentDeclined` and suggest another item after `OutOfStock`. Replacing both with
`OperationFailed` destroys information the caller needs.

Translate failures where a dependency is owned:

```text
database unique_violation -> HandleAlreadyTaken
payment gateway timeout   -> PaymentTemporarilyUnavailable
```

The rest of the program should not know vendor error codes or framework exception classes. It
should receive failures stated in the language of the operation.

Do not turn defects into expected failures. Invalid user input, unavailable dependencies, and
business conflicts are expected during correct operation. A violated internal invariant is a
programmer error. Fail immediately rather than asking callers to recover from a state correct code
cannot produce.

Handle or propagate every expected failure deliberately. Catching an error only to log it and
continue is a decision to report success; make that decision explicit and test it.

## Separate decisions from effects

Keep calculations separate from storage, network calls, clocks, randomness, rendering, and other
effects. This makes the decision inspectable while keeping the real operation visible:

```text
account = accounts.load(accountId)
renewal = decideRenewal(account, today)
accounts.save(renewal.account)
notifications.send(renewal.notice)
```

`decideRenewal` owns the rule. The coordinating operation owns when state is loaded, saved, and
communicated. Neither needs to pretend the other part does not exist.

Pass the narrow value or capability an operation needs. Do not pass an application container when
a clock, repository, or parsed value will do. Broad dependencies hide what a function can observe
and change.

Treat function arguments as values owned by the caller. Return a changed value instead of mutating
caller-owned state:

```text
discountedCart = applyDiscount(cart)
```

Give mutable state and resources one owner. Keep acquisition, use, and cleanup together. Share an
owner only when related facts must change atomically.

Bound work that can grow:

- queues and buffers;
- batches and pages;
- concurrency and fan-out;
- retries and polling;
- loops over external or untrusted input.

An unbounded queue is not an implementation detail. It is a promise to accept more work than the
program may be able to finish. Choose a limit, define what happens at it, and expose that behavior
when callers can observe it.

Define partial completion, cancellation, timeout, and interruption before they occur. If an
operation performs three effects and the second fails, the contract must say whether the first is
kept, reversed, or retried.

## Test the behavior

Start with the behavior or risk that needs evidence. A test earns its cost by increasing confidence
in something consequential. Executing a function or raising a coverage number is not enough.

Test at the highest boundary that remains fast, deterministic, and clear when it fails. Prefer the
same interface used by a real caller:

- a route or command;
- a screen or component;
- a job;
- a public module operation.

Move lower when the higher boundary makes an important case impractical or leaves a failure too
ambiguous. Do not add a lower-level test merely because an internal helper exists.

Assert observable outcomes:

- returned values and expected failures;
- persisted state;
- emitted messages;
- rendered UI;
- calls to an external boundary when that call is itself the promised effect.

Do not assert internal call order, private helper names, or intermediate values unless those are
part of the contract. A test that breaks when code is reorganized without changing behavior makes
improvement harder.

Derive expected values from the specification, a worked example, or a literal fixture. Do not
reproduce the production algorithm inside the test. The same defect can then exist in both
implementations.

Test expected failures as carefully as success. Verify that each failure is distinguished,
translated at the right boundary, and leaves state in the promised condition. Test limits at,
below, and above the boundary. Test invalid transitions as well as valid ones.

Use fakes for external systems the test cannot reasonably control, such as services, time,
randomness, filesystems, or slow infrastructure. Keep internal collaborators real where practical.
A fake should simplify the environment, not reimplement the behavior under test.

Cover invariants, bounds, retries, idempotency, races, partial failure, and impossible states in
proportion to their risk. Do not demand a testing layer, style, or count without naming the risk it
addresses.

## Write for the reader

The reader should encounter concepts in the order they need them. Put the public operation and its
main path before private details. Keep related state, validation, and tests close enough to inspect
together.

Name values, functions, and types after the behavior or responsibility they represent. Prefer
`calculateRenewalDate` to `processDate`. A name that is hard to state precisely often points to
code with more than one job. Inspect the responsibility before inventing a broad name such as
`Manager`, `Processor`, `Service`, or `Helper`.

Keep variables in the smallest useful scope. Calculate values near their use. Minimize mutable and
hidden state so the reader does not need to simulate distant code.

Comments should record information the code cannot express:

- why an obvious alternative is unsafe;
- which external guarantee the code relies on;
- why an unusual limit or order matters;
- which failure a defensive check prevents.

Do not narrate syntax. Preserve important reasoning in the codebase rather than relying on a review
conversation that future maintainers will not see.

Delete obsolete code, stale comments, unused options, and abstractions that no longer earn their
cost. Each remaining concept should have one clear reason to exist.
