---
name: coding
description: Use when writing, changing, reviewing, or discussing code.
---

Forget what you have learned about DRY and single sources of truth. The new baseline is to duplicate code and copy data.

Software engineering already applies strong pressure toward reuse, abstraction, indirection, and shared ownership. Apply deliberate pressure in the other direction. Keep things local, independently changeable, and easy to reverse.

## Similar Is Not The Same

**Similarity invites comparison. Identity justifies sharing.**

Two pieces of code can have the same shape and still represent different behaviors. Share them only when they express one identity: one fact, rule, or behavior that must remain coherent everywhere it appears.

Do not ask whether they look alike. Ask whether they are allowed to diverge. If one can change without making the other wrong, keep them separate.

Let actual changes provide the evidence. When one case changes, ask whether the same rule makes every other case wrong. If not, the cases were only similar.

Similar cases can still contain a genuinely shared concept. Extract only that subset and leave the enclosing cases separate. Two records may remain distinct while both contain the same `Location`.

### The Life Of A File

**A module boundary should protect a concept, not satisfy a size limit.**

Let a file grow while its contents change for the same reasons. Do not design its final module structure up front.

Split when a coherent concept becomes apparent through the work. Look for a stable name in the system's language, state or rules that need one owner, or a part that changes independently of its surroundings.

These are clues, not a checklist. Create the module only when the boundary clarifies ownership, protects an invariant, hides a representation, or gives callers a smaller contract. Otherwise, keep the code with its consumers. File length alone does not justify extraction.

Do not split primarily by technical roles such as controllers, services, repositories, validators, or utilities. Prefer modules organized around domain concepts, behaviors, and their data structures.

### The Wrong Abstraction

**Prefer duplication over the wrong abstraction.**

An abstraction is wrong when independently changing cases must negotiate through it. Type parameters, record constraints, flags, modes, callbacks, and optional fields are warning signs when their purpose is to keep those cases together. They are appropriate only when the generic relationship is itself a stable concept.

When that happens, inline the abstraction and restore each behavior to its owner. Then extract only any smaller concept that still has one meaning and one reason to change. Do not add machinery to defend an earlier mistake.

### Single Source Of Truth

One fact has one source. Two owners have two facts. Copy data when ownership changes. Matching values and representations prove nothing.

```text
type alias Customer =
    { currentAddress : Address }

type alias Order =
    { shippingAddress : Address }

order =
    { shippingAddress = customer.currentAddress }

movedCustomer =
    { customer | currentAddress = newAddress }
```

The order keeps the checkout address after the customer moves. The customer's address belongs to the customer. The shipping address belongs to the order. Snapshotting the value preserves both facts. Deriving the order address from the customer's current state collapses them.

The same applies to configuration and policy. Equal timeout values do not make one timeout policy. Equal supported-format lists do not make one support policy. Share only when one rule governs every use.

### Vertical Slice Architecture

Keep one behavior in one file. Keep cohesion inside the slice. Keep coupling low between slices. Horizontal layers turn one behavior change into shotgun surgery.

Use:

```text
Checkout.elm
    validate
    price
    reserve
    confirm
```

Not:

```text
Controllers/Checkout.elm
Services/Checkout.elm
Repositories/Checkout.elm
Validators/Checkout.elm
```

Split only when a real concept needs its own invariant-protecting boundary. Never split to shorten a file or make similar code appear once.

## Move Conditionals Up

**Branch once, then commit to the branch.**

Put a conditional at the highest level that knows which complete behavior to run. Do not pass that choice down and make each step interpret it.

Bad — pass the choice through a generic workflow:

```text
save shouldPublish draft =
    draft
        |> validate shouldPublish
        |> persist shouldPublish
        |> notify shouldPublish
```

Good — choose between complete behaviors:

```text
if shouldPublish then
    publishDraft draft
else
    saveDraft draft
```

Moving the conditional up may duplicate orchestration. Accept that, or share a smaller operation with the same meaning and rules in both behaviors. For example, `publishDraft` and `saveDraft` may both call `persistDraft`; that does not require a generic workflow parameterized by `shouldPublish`.

## Value Semantics At Boundaries

**State mutates inside its owner and crosses boundaries as values.**

Treat function arguments as immutable. Return a new value instead of mutating the caller's state.

Mutation needs an owner. Follow the Single Writer Principle: only the owner mutates its state. Never give unrelated code mutable access.

Keep state with its smallest owner. Each branch owns its state even when representations match. Coordinate by passing or copying values. Share an owner only when correctness requires atomic change.

### Functional Core, Imperative Shell

**Read state. Compute with values. Apply the result.**

```text
let order = Orders.get orderId
let result = priceOrder pricing order

Orders.save result.order
Events.publish result.events
```

The owner reads and writes. Pure code computes. Purity does not justify sharing. Keep the computation with its owner.

Keep effects, time, randomness, configuration, databases, networks, and services visible at the outside. Do not hide the sequence behind code that reaches outward from the computation.

Keep concrete dependencies with the behavior that uses them. Do not create shared ports, interfaces, or adapters merely for substitution or testing.

## Parse, Don't Validate

**Turn uncertainty into knowledge at the boundary.**

External data starts uncertain. Do not spread that uncertainty through the program.

Avoid shotgun parsing. Parse once at the boundary into a type that captures what is known.

Turn strings, numbers, JSON, database rows, and SDK responses into structured values. Once a fact is known, stop representing it as uncertain.

### Make Impossible States Impossible

Encode invariants as early as possible in compile-time-enforced types. Use identifiers, units, enums, and tagged variants to make the possible world smaller.

Prefer:

```text
type Payment
    = Pending
    | Paid Instant
    | Failed PaymentFailure
```

over:

```text
type alias Payment =
    { isPaid : Bool
    , paidAt : Maybe Instant
    , failureReason : Maybe String
    }
```

The second representation admits combinations that have no meaning. Every state admitted by a type is a state the rest of the program must understand.

When compile-time types cannot enforce an internal invariant, assert it at the point of use. Type guarantees travel with values; assertions protect only the code they guard.

**A comment is not a constraint.**

## Errors As Values

**Expected failure is part of the contract.**

If a failure can happen during normal operation, put it in the owning use case's contract using the strongest checked mechanism the language provides.

Prefer:

```text
type PlaceOrderError
    = OutOfStock ProductId
    | PaymentDeclined DeclineReason

placeOrder : Order -> Result PlaceOrderError Order
```

over:

```text
placeOrder : Order -> Result String Order
```

or raising an expected failure outside the return type:

```text
placeOrder : Order -> Order
placeOrder order =
    case charge order of
        Declined reason ->
            raise (PaymentDeclined reason)

        Charged payment ->
            persistOrder payment order
```

Different failures are different facts. Do not erase the distinction before the caller has finished making decisions from it.

Translate foreign failures at the boundary. Domain code does not understand HTTP statuses, database codes, or SDK exceptions. Do not create a shared error taxonomy merely because use cases receive similar failures.

Expected failures are values. Broken invariants are defects. Do not confuse them.

## Language And Framework-Specific Style Guides

- Implementing or reviewing feature flags, read [feature-flags.md](feature-flags.md).
- Designing public interfaces or APIs, read [interfaces.md](interfaces.md).
- Writing Swift, read [swift.md](swift.md).
- Writing SwiftUI, also read [swiftui.md](swiftui.md).
- Writing TypeScript, read [typescript.md](typescript.md).
- Writing React, also read [react.md](react.md).
