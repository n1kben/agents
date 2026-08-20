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

Handle every signaled failure. Propagate, translate, retry, or deliberately resolve it rather than silently discarding it.

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

## 2. Narrow the world early

Reduce the number of possibilities the remaining code has to consider as soon as enough information is available.

Parse uncertain inputs at boundaries:

```ts
const event = Event.parse(input);
```

rather than assuming:

```ts
const event = input as Event;
```

Resolve optional values early:

```ts
const user = await users.find(id);

if (!user) {
  return Err(new UserNotFound());
}

// From here, `user` is a User.
const email = user.email;
```

Handle sentinel values and exceptional cases once rather than carrying them through the rest of the computation:

```ts
const index = items.findIndex(matches);

if (index === -1) {
  return Err(new ItemNotFound());
}

// From here, `index` is a valid item index.
```

Once a possibility has been eliminated, the code below should not continue accounting for it.

## 3. Make invalid states unrepresentable

Choose representations that express the states the program actually has rather than combinations of flags and optional fields that can contradict each other.

Prefer:

```ts
type RequestState =
  | { type: "loading" }
  | { type: "failed"; error: Error }
  | { type: "loaded"; data: Data };
```

over:

```ts
type RequestState = {
  isLoading: boolean;
  error?: Error;
  data?: Data;
};
```

Prefer enums or unions when booleans erase meaning:

```ts
type Delivery = "silent" | "notify";
```

rather than:

```ts
sendNotification(notification, true);
```

Preserve semantic distinctions even when values share the same primitive representation. Keep `UserId` distinct from an arbitrary `string`, money distinct from arbitrary numbers, timestamps distinct from durations, and counts distinct from indexes.

Make units, conversions, and rounding intentional:

```ts
const timeoutMs = 30_000;
const pageCount = Math.ceil(itemCount / pageSize);
```

Assert invariants that cannot practically be represented in the type system:

```ts
assert(index < items.length);
```

Avoid weakening established guarantees with `any`, unchecked casts, `as Foo`, `!`, ignored errors, or equivalent compiler escape hatches. When an unsafe escape is necessary, keep it local and make the invariant that permits it explicit.

## 4. Separate effects from computation

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

Where independent effects can safely be performed together, batch them rather than repeatedly crossing an expensive boundary:

```ts
await orders.insertMany(ordersToCreate);
```

rather than:

```ts
for (const order of ordersToCreate) {
  await orders.insert(order);
}
```

Keep transactional scopes short. Do not hold a database transaction open across network calls, user interaction, or other long-running work.

## 5. Make effects safe under retry and interruption

Assume an effect can fail partway through, time out after succeeding, or be attempted more than once.

Make mutations idempotent where necessary. Use operation or idempotency IDs when duplicate execution matters. Handle partial success explicitly, keep retries bounded, and give asynchronous work a defined completion and failure path.

A timeout means the outcome may be unknown, not that the effect did not happen.

```ts
const result = await payments.charge({
  operationId,
  amount,
});
```

Retrying the same logical operation should not accidentally perform it twice.

## 6. Keep values stable and local

Prefer immutable bindings and values by default.

Introduce a value when it becomes known and as close as practical to where it is used. Keep its scope no larger than necessary.

Give each variable one meaning for its lifetime:

```ts
const area = width * height;
const perimeter = 2 * (width + height);
```

rather than reusing a variable for unrelated meanings:

```ts
let value = width * height;

// ...

value = 2 * (width + height);
```

Establish or check a fact close to where it is relied upon:

```ts
assert(index < items.length);
const item = items[index];
```

Avoid establishing a guarantee and then carrying it through unrelated work before use.

Local mutation is fine when it makes an algorithm simpler and the variable retains the same meaning:

```ts
const result = [];

for (const item of items) {
  if (include(item)) {
    result.push(transform(item));
  }
}

return result;
```

Prefer constructing complete values over creating partially valid values and filling them in later.

## 7. Bound work and resource usage

Anything that can grow or consume resources should have an explicit bound.

Pay particular attention to queues, buffers, batches, payloads, concurrency, accumulated results, retries, and operations that may continue indefinitely.

Define what happens when the bound is reached: reject, backpressure, paginate, split, shed work, or return an error.

Queues must have a defined maximum rather than becoming accidental unbounded buffers.

## 8. Keep state and resources owned

Every mutable piece of state should have one obvious owner responsible for changing it and maintaining its invariants.

Keep mutation where ownership is visible. Avoid passing mutable state through unrelated code that can change it implicitly.

Keep one canonical mutable representation of a fact. Avoid mutable aliases or duplicate state that must remain synchronized.

Derive secondary values instead of storing them separately:

```ts
const isFinished = job.status === "completed" || job.status === "failed";
```

Match finite states exhaustively.

Resources also need clear ownership. Acquire and release them in the same obvious scope, with cleanup guaranteed:

```ts
const file = await open(path);

try {
  await write(file, data);
} finally {
  await file.close();
}
```

Apply the same principle to transactions, connections, timers, locks, queues, and asynchronous tasks.

## 9. Make control flow and behavior explicit

Write control flow so the reader can see what happens next without mentally decoding it.

Prefer guard clauses over nesting:

```ts
if (!user) return Err("not_found");
if (!user.active) return Err("inactive");

return send(user);
```

Use direct control-flow constructs rather than simulating them with mutable flags.

Prefer simple, positive conditions when they make the valid case easier to see. Break apart compound boolean expressions when they obscure which cases are being handled.

Prefer ordinary sequencing when expressions or callbacks hide execution order:

```ts
for (const item of items) {
  await send(item);
}
```

If one operation must happen before another, keep that dependency structurally obvious and keep the dependent code close together.

Make behaviorally significant library options explicit rather than relying on implicit defaults:

```ts
await fetch(url, {
  redirect: "error",
  cache: "no-store",
});
```

Use exhaustive switches for finite cases.

## 10. Reuse and preserve existing concepts

Reuse existing domain concepts, canonical terminology, types, and shared code when they already mean the thing you need.

If the codebase uses `Order`, `OrderId`, and `parseOrderId`, preserve those concepts rather than introducing synonyms, reducing them to primitives, or creating local variations.

Reuse should follow shared meaning, not merely similar-looking implementation.

If two pieces of code look alike but mean different things, keep them separate.

When nothing existing fits, keep the implementation concrete and local rather than immediately creating something shared.

## 11. Write for reading

Organize code in top-down reading order: high-level or root logic first, details afterwards.

Keep each computation contiguous. Avoid interleaving independent pieces of work.

Make equivalent operations look equivalent so meaningful differences stand out.

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

Make significant literals reveal their meaning or unit:

```ts
const maxAttempts = 3;
const timeoutMs = 30_000;
```

Add comments only when they communicate information the code cannot express clearly itself: why something is done, an external constraint, or a non-obvious invariant.

Implement only behavior required by the current change. Avoid speculative branches, parameters, hooks, and code paths for hypothetical future needs.
