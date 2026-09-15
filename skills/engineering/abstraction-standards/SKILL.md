---
name: abstraction-standards
description: Standards for deciding what code belongs in a shared abstraction and what should stay with each caller.
disable-model-invocation: true
---

When an abstraction exposes or changes an API, read `$api-standards` before proposing its contract.

## When code should be shared

Similar code can remain duplicated. Share code when callers must follow one rule that needs to stay consistent. Otherwise, keep the code local.

## What the boundary should remove

An abstraction should own a rule or operation that callers would otherwise implement themselves. The work it removes should justify the new name, interface, and indirection. If neither the abstraction nor its callers becomes simpler, the boundary does not help.

For example, callers should not calculate retry windows themselves after a `RateLimiter` owns that rule:

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
