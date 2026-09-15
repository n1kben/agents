---
name: abstraction-standards
description: Decide when code should become an abstraction, when it should be shared, and what should remain local. Use only when `abstraction-standards` is specifically mentioned.
---

When an abstraction exposes or changes an API, read `$api-standards` before proposing its contract.

## Why create an abstraction

Create an abstraction when a concern needs one authoritative definition or a deliberate interface. Common reasons include:

- keeping behavior or presentation consistent, such as a UI component;
- enforcing an invariant, such as a domain value;
- translating between external and internal models, such as an anti-corruption layer;
- isolating an external dependency, such as a payment provider facade;
- defining failure or effect policy, such as retries, idempotency, or transactions;
- managing state or resource lifecycles;
- containing an implementation that is hard or error-prone.

These are examples, not an exhaustive list.

An abstraction can serve one caller. Sharing it is a separate decision.

## When code should be shared

Similar code can remain duplicated. Share an abstraction when multiple callers need the same definition or interface. Otherwise, keep it local.

## Make the boundary effective

Callers should use the abstraction instead of reimplementing or bypassing its definition or interface. Its benefit should justify the new name, interface, and indirection.

For example, callers should not calculate retry windows themselves after a `RateLimiter` defines that policy:

```text
decision = rateLimiter.check(userId)
if decision is Allowed:
  continueRequest()
```

## Share the smallest common part

If two use cases share one step, extract that step rather than the sequences around it. Keep the order, choices, and outcomes in each use case's top-level function.

Shared code should not need to know which use case invoked it. If it does, extract a smaller part.

For example, share the validation step but not the sequences around it:

```text
registerCustomer(customer):
  address = validateAddress(customer.address)
  saveCustomer(customer, address)
  sendWelcomeEmail(customer)

updateAddress(customer, input):
  address = validateAddress(input)
  saveAddress(customer.id, address)
  recordAddressChange(customer.id)
```

## Start with a function

Use a function when the result depends only on its inputs:

```text
total = calculateTotal(items)
```

Use a type when a fact must remain true as the value moves through the program:

```text
email = EmailAddress.parse(input)
```

Use an object or module when mutable state must persist between calls or a resource needs acquisition and cleanup:

```text
connection = connectionPool.acquire()
connectionPool.release(connection)
```

Do not add state or a lifecycle to an abstraction that only performs a calculation.

## Keep callers independent

Each caller should be able to use and test the abstraction without reading the other callers. A change to the shared rule should apply to every caller. If the implementation depends on the details of every caller, it still contains caller-specific behavior.
