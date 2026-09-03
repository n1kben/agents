---
name: coding
description: Use when writing, changing, reviewing, or discussing code.
---

The goal is code that can be understood locally and changed independently, with interfaces that make correct use obvious and incorrect use hard.

Build toward five qualities: high cohesion, low coupling, explicit boundaries, strong domain modeling, and behavior-focused verification.

## High Cohesion

Organize code around use cases and reasons to change. Code that changes together should live together.

### Organize Around Vertical Slices

A vertical slice contains the code required to deliver one behavior across the system. A change should follow one clear path; unrelated use cases should not meet in horizontal convenience layers. The goal is not zero blast radius, but a blast radius that is small, visible, and justified by the domain.

## Low Coupling

Every shared abstraction couples its dependents. Share identity, not appearance.

Similarity is a snapshot; identity is a promise about change. Sharing asserts that two things have one reason to change, which predicts a future humans and agents are bad at predicting. When identity is uncertain, prefer duplication. Joining things later is easier than separating them after dependents have gathered around an abstraction.

### Prefer Locality Over Small Files

Keep code close to its only consumer. A new file makes an implementation detail discoverable, nameable, and available to depend on. What can be depended on eventually will be. Extract only when the concept has a coherent identity and deserves an independent boundary. File length alone is not a design reason.

### Do Not Mistake The Same Values For The Same Policy

Two video players may both accept `.mov` and `.mp4`, but a format is not supported in the abstract; it is supported by a particular player. If one adds `.webm` or drops `.mov`, a shared `isSupportedVideoExtension` couples policies that should evolve independently. Let each player own its formats. Share extension parsing, not support policy.

### Keep Inputs And State Local

Make every input explicit and treat function arguments as immutable. Global state, configuration, time, randomness, and services are hidden arguments; pass them explicitly. Arguments are values to observe, not state to own. Return what should change, then let the owning layer apply it.

Keep state local when possible. When branches share it, lift it only to their nearest common owner. State may mutate inside its owner, but it crosses boundaries as values, never as mutable arguments.

## Explicit Boundaries

Boundaries should reveal intent, constrain use, and separate policy from mechanics.

### Give Workflows Names

A boolean or enum that selects a workflow is often a missing verb. `processOrder(order, mode: .refund, sendEmail: false)` makes the caller assemble policy and permits invalid combinations. Prefer `refundOrder(order)`. Let the use case own the complete policy and push only shared mechanics down.

### Push Decisions And Effects Up

Centralize control flow. Choose once between `placeStandardOrder` and `placeExpressOrder`; neither should receive `isExpress`. Keep `if` and `switch` in the parent and move branch-free mechanics into helpers. If a condition follows data through the call tree, the workflows are similar, not the same.

Centralize effects. Keep the sequence in the parent: read state, compute a result, then save or send. `calculateTotal` returns a value; it does not also save the order or send analytics. The parent applies changes; leaf functions stay pure.

### Parse At System Boundaries

Turn uncertain external input into a value that proves the facts the program needs. Reject invalid input once, at the earliest boundary. Do not carry uncertainty into the program and ask every function to check it again.

### Make Expected Failure Explicit

Expected failures belong in the function's type or signature. Callers must be able to discover and exhaustively handle them without reading the implementation. Use the strongest checked failure mechanism the language provides.

Reserve unchecked failure for defects and broken invariants. Translate expected failures from foreign APIs into named domain failures at the system boundary. Do not erase useful failure variants into a generic error too early.

## Strong Domain Modeling

Make the possible world small. Every state admitted by a type is a state the program must understand. Use domain values, units, identifiers, enums, and tagged variants to encode what is true. Avoid primitive strings, boolean flags, and bags of optional fields that permit contradictions. A comment is not a constraint.

Prefer compile-time enforcement. If an invariant cannot be encoded, assert it in the code paths that establish and rely on it. Assertions catch programmer errors; parse or return explicit failures for invalid external input.

### Do Not Confuse Current State With Historical Fact

A customer's current address and an order's shipping address may contain the same values at checkout, but they do not have the same identity. The customer address changes when the customer moves; the order address records where that order was sent. Updating one must never rewrite the other.

### Do Not Collapse Different Questions Into One Answer

A subscription's billing status and an account's access status may both begin as `active` or `inactive`, but billing asks whether the subscription is paid while access asks whether the account may use the product. Grace periods, term endings, and security suspensions make those answers diverge. Let each concept own its status, then connect them through explicit policy.

## Behavior-Focused Verification

### Test The Contract

Test behavior, not choreography. Test at the highest useful seam: a use case, public module, route, component, or job. Assert observable outputs, failures, persisted state, and emitted messages. A test should survive renaming a helper, changing call order, or moving code when behavior does not change. Derive expected values from the specification, not by repeating the implementation.

Inject a small world. Pass only the external capabilities the code needs through narrow interfaces. Mock system boundaries—external APIs, time, randomness, filesystems, and networks—and keep internal collaborators real. If a test must assemble half the application, the boundary is too wide. Test the invariants and failure paths that matter.

### Leave Structured Evidence

Shipped code must use the repository's structured diagnostics instead of ad hoc prints. Include stable event names and enough identifiers and context to investigate a failure from the telemetry alone. Never record secrets or sensitive payloads.

## Language And Framework-Specific Style Guides

- Writing Swift, read [`swift-style.md`](swift-style.md).
- Writing SwiftUI, also read [`swiftui-style.md`](swiftui-style.md).
- Writing TypeScript, read [`typescript-style.md`](typescript-style.md).
- Writing React, also read [`react-style.md`](react-style.md).
