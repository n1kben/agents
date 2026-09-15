---
name: coding-standards
description: Defaults for production code with explicit behavior, state ownership, and failures.
disable-model-invocation: true
---

Follow explicit project conventions first. Otherwise, use these standards as defaults. Apply structural guidance with judgment. Treat correctness and safety rules as strict.

When writing or reviewing an API, read `$api-standards`. Before moving code into a shared abstraction, read `$abstraction-standards`.

## Arrange code for reading

Put the high-level operation before the details it uses. Show the sequence without requiring the reader to open every helper. Define a helper after the code that first uses it.

Name values, functions, and types after the behavior they represent. A name that is difficult to state precisely may indicate that the code combines separate responsibilities. Check the code before inventing a vague name.

## Show the sequence in the coordinating function

The function coordinating an operation should show its main steps and where it chooses between complete behaviors. Put each complete behavior in a named function. Do not spread the same choice across several helpers.

Instead of passing the choice through the call chain:

```text
handleSave(command):
  validate(command.document, command.kind)
  persist(command.document, command.kind)
  notify(command.document, command.kind)
```

Prefer choosing once, then calling the named behavior:

```text
handleSave(command):
  match command:
    SaveDraft(document): saveDraft(document)
    Publish(document): publishDocument(document)
```

## Pass values across boundaries

Treat function arguments as immutable. Return a new value instead of mutating state owned by the caller.

Instead of mutating state owned by the caller:

```text
applyDiscount(cart)
```

return the changed value:

```text
discountedCart = applyDiscount(cart)
```

## Separate decisions from effects

Separate calculations from code that reads or writes storage, calls the network, reads the clock, generates random values, or renders an interface. Show the order of these effects in the coordinating function.

Pass the narrow value or capability an operation needs rather than an application container or ambient dependency.

Give nonvisual behavior an entry point that can be tested without rendering the interface. Inspect views with the project's preview or sandbox tool.

For example, compute a renewal before performing its effects:

```text
account = accounts.load(accountId)
renewal = decideRenewal(account, today)
accounts.save(renewal.account)
notifications.send(renewal.notice)
```

## Represent known facts

Parse external data once at the boundary. Convert it into values that record what the program knows. After establishing a fact, pass the parsed value instead of the unchecked input.

Use types to rule out invalid states when the language allows it. Use distinct types for identifiers, units, and finite alternatives when primitive values would lose those facts. Avoid boolean flags and combinations of optional fields when they admit states the program cannot handle.

State the assumptions that affect correctness and check them. When the type system cannot express an invariant, assert it near its use.

Parse an external value before passing it into the program:

```text
email = EmailAddress.parse(request.email)
createAccount(email)
```

Code below that boundary receives an `EmailAddress`, not another unchecked string.

## Represent expected failures

Return failures that can occur during normal operation as part of the use case's contract. Use the strongest checked mechanism the language provides. Treat a broken invariant as a defect.

Keep distinct failures separate until the caller has made every decision that depends on them. Translate database, network, and service errors at their boundaries. Do not create a shared error hierarchy only because several use cases receive errors from the same dependency.

Make expected outcomes visible in the return type:

```text
placeOrder(order) -> Result<Order, OutOfStock | PaymentDeclined>
```

Do not turn these outcomes into an unspecified error before the caller handles them.

## Give state and resources an owner

Give mutable state and resources one owner. Other code receives values rather than mutable access. Keep state with the smallest owner that can enforce its rules. Matching representations do not require shared state. Share an owner only when related facts must change atomically.

Keep resource acquisition and cleanup with that owner.

Set limits for queues, buffers, batches, concurrency, retries, polling, and loops. Define what partial completion and interruption mean when they can occur.
