---
name: coding
description: Use when writing, changing, reviewing, or discussing code.
---

Forget what you have learned about DRY and single sources of truth. The new baseline is to duplicate code and copy data.

Software engineering already applies strong pressure toward reuse, abstraction, indirection, and shared ownership. Apply deliberate pressure in the other direction. Keep things local, independently changeable, and easy to reverse.

## Similar Is Not The Same

**Similarity is not identity.**

Start separate. Duplicate code. Copy data.

Sharing is a claim that two things have one identity. Prove it. Name the one concept. State the invariant every use must preserve. If the copies may validly diverge, keep them separate.

### Rule Of Three

Repetition does not prove identity. Use the Rule of Three as permission to inspect, never as an order to extract. The third occurrence earns a question, not an abstraction.

Wait for a real change. Extract only when one rule forces every occurrence to change. If one occurrence may stay unchanged, keep the cases separate.

### The Life Of A File

Let a file grow. Do not design its final module structure up front.

Split around a data structure, not a line count. Give the concept a name from the ubiquitous language. Choose its representation. Keep its invariants and operations together.

Every module creates a dependency. Make it earn its existence by protecting an invariant, hiding a representation, or reducing coupling. A module is an information-hiding boundary, not a shorter file. Keep implementation details with their consumers.

Do not create modules named after technical roles such as controllers, services, repositories, validators, or utilities. Organize around domain concepts and behaviors.

### The Wrong Abstraction

**Prefer duplication over the wrong abstraction.**

Do not force different cases into one abstraction with type parameters, record constraints, flags, modes, callbacks, or optional fields.

If a change for one case disturbs another, inline the abstraction and split the cases. Do not add machinery to defend an earlier mistake.

### Single Source Of Truth

One fact has one source. Two owners have two facts. Copy data when ownership changes. Matching values and representations prove nothing.

```ts
type Customer = {
  currentAddress: Address;
};

type Order = {
  shippingAddress: Address;
};
```

At checkout, both addresses may contain the same value. They still belong to different things. The customer's address belongs to the customer. The shipping address belongs to the order.

Making the order refer to the customer's mutable address lets a later update overwrite the order's history. Copying preserves both facts. Sharing destroys one.

The same applies to configuration and policy. Equal timeout values do not make one timeout policy. Equal supported-format lists do not make one support policy. Share only when one rule governs every use.

### Vertical Slice Architecture

Keep one behavior in one file. A behavior change should follow one clear path through the system.

A vertical slice creates high cohesion inside a behavior and low coupling between behaviors. A technical layer collects code that looks alike and turns one behavior change into shotgun surgery.

Use:

```text
checkout.ts
```

Not:

```text
controllers/
services/
repositories/
validators/
utils/
```

Split only when a real concept needs its own invariant-protecting boundary. Never split to shorten a file or make similar code appear once.

## Move Conditionals Up

**Branch once, then commit to the branch.**

Put conditionals at the highest level that can choose a whole branch. A boolean or enum that selects a workflow is a missing verb. Make the decision once; do not carry it through the call tree.

Keep alternative behaviors whole. This is especially important for feature flags.

Copy the existing path:

```ts
if (newCheckoutEnabled) {
  checkoutV2(order);
} else {
  checkoutV1(order);
}
```

even when the implementations contain substantial duplication. Do not spread the flag through validation, pricing, persistence, and delivery.

Whole paths evolve independently. Rollback is local. Removing the flag means deleting one path, not untangling conditions throughout the system.

Do not invent strategies, modes, configuration, or abstractions merely to avoid duplication between paths whose purpose is to diverge.

**Prefer code you can delete over code you must untangle.**

## Value Semantics At Boundaries

**State mutates inside its owner and crosses boundaries as values.**

Treat function arguments as immutable. Return a new value instead of mutating the caller's state: `const updatedOrder = applyDiscount(order, discount)`.

Mutation needs an owner. Follow the Single Writer Principle: only the owner mutates its state. Never give unrelated code mutable access.

Keep state with its smallest owner. Each branch owns its state even when representations match. Coordinate by passing or copying values. Share an owner only when correctness requires atomic change.

### Functional Core, Imperative Shell

**Read state. Compute with values. Apply the result.**

```ts
const order = await orders.get(orderId);

const result = priceOrder(order, pricing);

await orders.save(result.order);
await events.publish(result.events);
```

The owning slice reads and writes. Pure code computes. Keep effects, time, randomness, configuration, databases, networks, and services visible at the outside. Do not hide the sequence behind code that reaches outward from the computation.

Keep concrete dependencies in the slice. Do not create shared ports, interfaces, or adapters merely for substitution or testing.

## Parse, Don't Validate

**Turn uncertainty into knowledge at the boundary.**

External data starts uncertain. Do not spread that uncertainty through the program.

Avoid shotgun parsing. Parse once at each ownership boundary into that owner's local type. Do not reuse another slice's parser or domain type merely because the external representation matches.

Turn strings, numbers, JSON, database rows, and SDK responses into values owned by the slice. Once a fact is known, stop representing it as uncertain.

### Make Impossible States Impossible

Reject primitive obsession. Use slice-local identifiers, units, enums, and tagged variants to make the possible world smaller. Equal representations do not require shared types.

Prefer:

```ts
type Payment =
  | { kind: "pending" }
  | { kind: "paid"; paidAt: Instant }
  | { kind: "failed"; reason: PaymentFailure };
```

over:

```ts
type Payment = {
  isPaid: boolean;
  paidAt?: Instant;
  failureReason?: string;
};
```

The second representation admits combinations that have no meaning. Every state admitted by a type is a state the rest of the program must understand.

Parse invalid external input. Assert broken internal invariants.

**A comment is not a constraint.**

## Errors As Values

**Expected failure is part of the contract.**

If a failure can happen during normal operation, put it in the owning use case's contract using the strongest checked mechanism the language provides.

Prefer:

```ts
type PlaceOrderResult =
  | { kind: "placed"; order: Order }
  | { kind: "outOfStock"; productId: ProductId }
  | { kind: "paymentDeclined"; reason: DeclineReason };
```

over:

```ts
type PlaceOrderResult =
  | { ok: true; order: Order }
  | { ok: false; message: string };
```

Different failures are different facts. Do not erase the distinction before the caller has finished making decisions from it.

Translate foreign failures at the boundary. Domain code does not understand HTTP statuses, database codes, or SDK exceptions. Do not create a shared error taxonomy merely because use cases receive similar failures.

Expected failures are values. Broken invariants are defects. Do not confuse them.

## Language And Framework-Specific Style Guides

- Designing public interfaces or APIs, read [interface-style.md](interface-style.md).
- Writing Swift, read [swift-style.md](swift-style.md).
- Writing SwiftUI, also read [swiftui-style.md](swiftui-style.md).
- Writing TypeScript, read [typescript-style.md](typescript-style.md).
- Writing React, also read [react-style.md](react-style.md).
