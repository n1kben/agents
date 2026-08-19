---
name: implementation-style
description: Implementation style. Use when writing or checking implementation code.
---

# Implementation Style

Write the simplest concrete implementation that follows these rules. Reuse existing concepts when they fit; otherwise keep code local until a shared concept is clear.

## 1. Make known failures explicit

Expected failures belong in the function signature, not hidden control flow.

Use `Result<Value, Error>` in TypeScript and Rust, `(Value, error)` in Go, typed `throws` in Swift, or the language's equivalent.

Use throw, panic, or assert for programmer errors and violated invariants, not expected outcomes.

Translate exceptions, promise rejections, and provider-specific errors into known failures where they enter your code.

```ts
let charge;

try {
  charge = await stripe.charges.create(input);
} catch (error) {
  if (error instanceof Stripe.errors.StripeCardError) {
    return Err({ type: "payment_declined" });
  }

  return Err({ type: "payment_failed" });
}
```

---

## 2. Establish invariants early and preserve them

Convert uncertain inputs into well-defined domain values at the boundary.

Prefer parsing:

```ts
const event = Event.parse(input);
```

over assuming:

```ts
const event = input as Event;
```

Resolve optionality as soon as the code requires a value.

```ts
const user = await users.find(id);

if (!user) {
  return Err(new UserNotFound());
}

// `user` is known from here onward.
const email = user.email;
const name = user.name;
```

Assert invariants the type system cannot express close to where they are established or relied upon:

```ts
assert(index < items.length);
```

Avoid weakening established guarantees with `any`, unchecked casts, `as Foo`, `!`, ignored errors, disabled warnings, or equivalent compiler escape hatches.

---

## 3. Separate effects from computation

Avoid interleaving external effects with local computation.

Prefer the shape **read → compute → write**:

```ts
const order = await orders.get(id);
const now = clock.now();

let total = 0;

for (const item of order.items) {
  total += item.price * item.quantity;
}

const completed = {
  ...order,
  total,
  completedAt: now,
};

await orders.save(completed);
```

Pull external inputs and nondeterminism such as time and randomness up. Keep computation together. Push writes and other observable effects down.

Once external inputs are gathered, local computation should be deterministic where practical.

Keep transactional scopes short. Do not hold a database transaction open across network calls, user interaction, or other long-running work.

---

## 4. Make effects safe under retry and interruption

Assume an effect can fail partway through, time out after succeeding, or be attempted more than once.

Make mutations idempotent where necessary. Use operation or idempotency IDs when duplicate execution matters. Handle partial success explicitly, keep retries bounded, and give asynchronous work a defined completion and failure path.

A timeout means the outcome may be unknown, not that the effect did not happen. The caller should always have a safe next action.

```ts
const result = await payments.charge({
  operationId,
  amount,
});
```

Retrying the same logical operation should not accidentally perform it twice.

---

## 5. Favor immutability; keep mutation local

Treat values as immutable by default.

Local mutation is fine when it makes the implementation simpler:

```ts
const result = [];

for (const item of items) {
  if (include(item)) {
    result.push(transform(item));
  }
}

return result;
```

Keep mutation within a small, obvious owner. Avoid mutable state that escapes its scope or can be changed from unrelated places.

---

## 6. Bound work and resource usage

Anything that can grow or consume resources should have an explicit bound.

Pay particular attention to queues, buffers, batches, payloads, concurrency, accumulated results, and operations that may continue indefinitely.

Define what happens when the bound is reached: reject, backpressure, paginate, split, shed work, or return an error.

Queues must have a defined maximum rather than becoming accidental unbounded buffers.

---

## 7. Keep state and resources owned

Every mutable piece of state should have an obvious owner responsible for changing it and maintaining its invariants.

Keep state manipulation centralized. Prefer helpers that compute what should happen while the owner applies the change:

```ts
const next = selectNextJob(queue);

if (next) {
  queue.remove(next);
}
```

Prefer one canonical representation of each fact. Derive secondary values instead of synchronizing duplicated state:

```ts
const isFinished = job.status === "completed" || job.status === "failed";
```

Match finite states exhaustively, for example with an exhaustive `never` check in TypeScript.

Resources also need a clear owner. Prefer acquiring and releasing a resource in the same obvious scope, with cleanup guaranteed on both success and failure:

```ts
const file = await open(path);

try {
  await write(file, data);
} finally {
  await file.close();
}
```

The same principle applies to transactions, connections, timers, locks, and asynchronous tasks: the code that starts or acquires them should make their completion, cleanup, or cancellation evident.

---

## 8. Prefer explicit, boring control flow

Write control flow so the reader can see what happens next without mentally decoding the syntax.

Prefer guard clauses over nesting:

```ts
// Harder to scan
if (user) {
  if (user.active) {
    return send(user);
  } else {
    return Err("inactive");
  }
} else {
  return Err("not_found");
}
```

```ts
// Easier to scan
if (!user) return Err("not_found");
if (!user.active) return Err("inactive");

return send(user);
```

Prefer ordinary control-flow constructs when callbacks or expressions obscure sequencing:

```ts
// Sequencing is hidden inside reduce
await items.reduce(async (previous, item) => {
  await previous;
  await send(item);
}, Promise.resolve());
```

```ts
// Sequencing is explicit
for (const item of items) {
  await send(item);
}
```

Prefer exhaustive `switch` statements over nested ternaries when representing finite cases.

Boring does not mean verbose. It means the path through the code is visible.

---

## 9. Reuse existing concepts and shared code

Reuse existing domain concepts, canonical terminology, and shared code when they already mean the thing you need.

If the codebase uses `Order`, `OrderId`, and `parseOrderId`, use those rather than introducing a synonymous concept, another representation of the ID, or a local version of the same parser.

Reuse should follow shared meaning, not merely similar-looking implementation.

If two pieces of code look alike but mean different things, keep them separate. When nothing existing fits, keep the implementation concrete and local rather than immediately creating something shared.

---

## 10. Write for reading

Organize code in top-down reading order: high-level or root logic first, details afterwards.

Keep statements that participate in the same idea together. Make equivalent operations look equivalent so meaningful differences stand out.

Use names that describe what something means, not merely how it was produced:

```ts
const activeSubscription = ...
```

rather than:

```ts
const filteredItem = ...
```

If a value, function, or state is difficult to name clearly and honestly, treat that as a signal that the implementation itself may not yet be clear.

Introduce intermediate variables and constants when their names expose an important concept:

```ts
const isHappeningNow = event.start <= now && now < event.end;
```

Add comments only when they communicate information the code cannot express clearly itself: why something is done, an external constraint, or a non-obvious invariant.

Implement only behavior required by the current change. Avoid speculative branches, parameters, hooks, and code paths for hypothetical future needs.
