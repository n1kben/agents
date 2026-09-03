---
name: coding
description: Use when writing, changing, reviewing, or discussing code.
---

DRY and single source of truth have infected our whole industry. Reuse is treated as a virtue before we know whether two things truly belong together. But every shared abstraction is coupling, and deep coupling compounds.

The goal is code that is locally understandable, independently changeable, and difficult to misuse: high cohesion, low coupling. Share identity, not appearance.

## Similar Versus Same

Similarity is a snapshot. Identity is a promise about change. The distinction holds everywhere, from everyday life to database schemas and code: what looks alike today may need to evolve independently tomorrow.

DRY and single source of truth are especially prone to misuse at this boundary. Sharing asserts one identity and one reason to change. This predicts the future, and humans and agents are notoriously bad at it. When identity is uncertain, prefer duplication. Joining two things later is easier than separating them after dependents have gathered around the abstraction.

### Examples Of Confusing Similar With Same

#### Single Source Of Truth

**Do not confuse current state with historical fact.** A customer's current address and an order's shipping address may contain the same values at checkout, but they do not have the same identity. The customer address changes when the customer moves. The order address records where that order was sent. Updating one must never rewrite the other.

**Do not collapse different questions into one answer.** A subscription's billing status and an account's access status may both begin as `active` or `inactive`, but billing asks whether the subscription is paid while access asks whether the account may use the product. A past-due subscription may retain access during a grace period. A cancelled subscription may remain usable until the end of its term. A security suspension may revoke access while billing remains active. Let each concept own its status, then connect them through explicit policy.

#### DRY

**Do not turn use cases into options.** `changeSubscription(subscription, action: .cancel, prorate: false, notifyCustomer: true)` exists because upgrading, downgrading, pausing, and cancelling share a few implementation steps. Yet these are different workflows with different rules. The generic function makes every caller assemble the workflow from flags and makes invalid combinations representable. Prefer `cancelSubscription(subscription)`. Share only the lower-level mechanisms that truly change together.

**Do not mistake the same list for the same policy.** Two video players accept `.mov` and `.mp4`, so both depend on `isSupportedVideoExtension`. But a format is not supported in the abstract. It is supported by a particular player. If one player adds `.webm`, the shared list may make the other accept a file it cannot play. If one drops `.mov`, the other may reject a file it can still play. Let each player own its formats. Share extension parsing, not support policy.

## Vertical Slice Architecture

Organize code around use cases. A vertical slice contains the code required to deliver one behavior across the system. Code that changes together lives together. Unrelated use cases do not meet in horizontal convenience layers.

A change should follow one clear path. The goal is not zero blast radius, but a blast radius that is small, visible, and justified by the domain.

## Prefer Locality Over Small Files

Keep code close to its only consumer. A new file makes an implementation detail discoverable, nameable, and available to depend on. What can be depended on eventually will be. Extract only when the concept has a coherent identity and deserves an independent boundary. File length alone is not a design reason.

## Interfaces

Prefer deep modules: a narrow, stable interface over a substantial, cohesive capability. A good interface expresses intent and hides mechanism. Give the caller few decisions and make the module do meaningful work.

### Smells

- **Boolean or enum arguments that select policy or workflow.** A mode flag is often a missing verb. Move the choice up to the layer that knows the use-case intent. Push shared mechanics down beneath separate, intention-revealing operations.
- **A large interface over a small implementation.** This is a shallow module. It adds surface area without hiding meaningful complexity.

For example, `processOrder(order, mode: .refund, sendEmail: false)` makes the caller act as a workflow engine. A refund is an intent, not a mode. Sending the email is a consequence of policy, not a switch for every caller to choose. The flags admit nonsense, such as completing a refund without a required notification, and the implementation grows into a conditional tree.

Prefer `refundOrder(order)`. Let the use case own the complete refund policy. Push policy choices up and shared mechanics down.

## Make Illegal States Unrepresentable

**Make the possible world small.** Every state admitted by a type is a state the program must understand. Use domain values, units, identifiers, enums, and tagged variants to encode what is true. Avoid primitive strings, boolean flags, and bags of optional fields that permit contradictions. A comment is not a constraint.

**Parse, don't validate.** At a system boundary, turn uncertain input into a value that proves the facts the program needs. Reject invalid input once, at the earliest boundary. Do not carry uncertainty into the program and ask every function to check it again.

## Make Expected Failure Explicit

Expected failures belong in the function's type or signature. Callers must be able to discover and exhaustively handle them without reading the implementation. Use the strongest checked failure mechanism the language provides.

Reserve unchecked failure for defects and broken invariants. Translate expected failures from foreign APIs into named domain failures at the system boundary. Do not erase useful failure variants into a generic error too early.

## Immutable Boundaries

Make every input explicit and treat function arguments as immutable. Global state, configuration, time, randomness, and services are hidden arguments; pass them explicitly. Arguments are values to observe, not state to own. Return what should change, then let the owning layer apply it.

**Push effects and conditionals up. Put state behind immutable boundaries.** Read, compute, write. The top of the call tree owns policy, orchestration, and effects. The leaves compute from explicit inputs. Keep state local when possible; when branches share it, lift it only to their nearest common owner. State may mutate inside its owner, but it crosses boundaries as values, never as mutable arguments.

## Test The Contract

**Test behavior, not choreography.** Test at the highest useful seam: a use case, public module, route, component, or job. Assert observable outputs, failures, persisted state, emitted messages, and UI behavior. A test should survive renaming a helper, changing call order, or moving code when behavior does not change. Derive expected values from the specification, not by repeating the implementation.

**Inject a small world.** Pass only the external capabilities the code needs, through narrow interfaces. Mock those system boundaries—external APIs, time, randomness, filesystems, and networks—and keep internal collaborators real. If a test must assemble half the application, the boundary is too wide. Test the invariants and failure paths that matter.

**Inspect real UI in isolation.** Give every UI component or screen added or changed a repository-native harness that renders the production component without navigating through the application. Expose relevant states directly, including loading, empty, populated, error, disabled, and constrained content or layout. Keep I/O and ambient dependencies outside the UI boundary so the harness can supply a small, deterministic world.

## Leave Structured Evidence

Shipped code must use the repository's structured diagnostics instead of ad hoc prints. Include stable event names and enough identifiers and context to investigate a failure from the telemetry alone. Never record secrets or sensitive payloads.

## Language-Specific Style Guides

- Writing Swift, read [`swift-style.md`](swift-style.md).
- Writing TypeScript, read [`typescript-style.md`](typescript-style.md).
