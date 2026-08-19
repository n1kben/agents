---
name: abstraction-style
description: Abstraction style. Use when extracting functions or judging whether a boundary earns its indirection.
---

# Abstraction Style

Use abstractions to divide a large reasoning **world** into smaller ones.

**Implementation style governs code within a boundary. Abstraction style decides where boundaries should exist and what those boundaries expose.**

A function's world is everything its implementation may need to consider: its facts and states, available capabilities, possible effects, failures, and control flow.

Inputs determine the world available inside a function. Outputs determine the world exposed to its callers. Narrow both sides of the boundary.

The primary gain from an abstraction is inward: the new function has a smaller world. The secondary gain is outward: surrounding code can ignore the knowledge hidden behind the boundary.

An abstraction does not need reuse. A function with one caller earns its existence when the reasoning it removes pays for its name, interface, and indirection.

## Compression test

Review concrete code against every opportunity in this document. Introduce a boundary only when you can complete at least one sentence with something substantial:

> Inside the boundary, the function no longer needs to consider **\_\_**.

> Outside the boundary, the surrounding code no longer needs to understand **\_\_**.

Then name the cost:

> What new concept or indirection must we now understand instead?

The strongest abstractions complete both removal sentences and have a smaller cost than the knowledge they remove. If neither removal sentence works, keep the code concrete. Moving code is not compression.

Each example moves from **Concrete** code, where the knowledge is inline, to **Abstracted** code, where a new boundary contains it. Concrete is the starting point, not a failure.

## 1. The input contains too many facts and states: narrow the model

Every fact and representable state in an input becomes part of a function's world. Large entities invite accidental dependencies; loose states force the function to defend itself against combinations it cannot use.

### Concrete

```ts
async function handleCancelReservation(
  command: CancelReservation,
): Promise<Result<Cancellation, CancellationError>> {
  const reservation = await reservations.get(command.reservationId);

  if (reservation.isErr()) {
    return reservation;
  }

  if (reservation.value.status !== "confirmed") {
    return Err(new ReservationCannotBeCancelled());
  }

  if (!reservation.value.startsAt) {
    return Err(new InvalidReservationState());
  }

  if (reservation.value.deliveredAt) {
    return Err(new VehicleAlreadyDelivered());
  }

  if (
    Boolean(reservation.value.freeCancellationUntil) !==
    Boolean(reservation.value.cancellationFee)
  ) {
    return Err(new InvalidCancellationPolicy());
  }

  const cancelledAt = clock.now();

  if (!reservation.value.startsAt.isAfter(cancelledAt)) {
    return Err(new ReservationCannotBeCancelled());
  }

  let fee = Money.zero("SEK");

  if (
    reservation.value.freeCancellationUntil &&
    cancelledAt.isAfter(reservation.value.freeCancellationUntil)
  ) {
    fee = reservation.value.cancellationFee ?? Money.zero("SEK");
  }

  return cancellations.save({
    reservationId: reservation.value.id,
    cancelledBy: command.userId,
    cancelledAt,
    fee,
  });
}
```

### Abstracted

```ts
type CancellationPolicy =
  | { type: "free" }
  | {
      type: "free_until";
      freeUntil: Instant;
      feeAfter: Money;
    };

type CancellationCandidate = {
  id: ReservationId;
  startsAt: Instant;
  policy: CancellationPolicy;
};

type CancellationCandidateError =
  | ReservationCannotBeCancelled
  | InvalidCancellationPolicy;

function toCancellationCandidate(
  reservation: Reservation,
): Result<CancellationCandidate, CancellationCandidateError> {
  if (
    reservation.status !== "confirmed" ||
    !reservation.startsAt ||
    reservation.deliveredAt
  ) {
    return Err(new ReservationCannotBeCancelled());
  }

  if (
    Boolean(reservation.freeCancellationUntil) !==
    Boolean(reservation.cancellationFee)
  ) {
    return Err(new InvalidCancellationPolicy());
  }

  const policy: CancellationPolicy =
    reservation.freeCancellationUntil && reservation.cancellationFee
      ? {
          type: "free_until",
          freeUntil: reservation.freeCancellationUntil,
          feeAfter: reservation.cancellationFee,
        }
      : { type: "free" };

  return Ok({
    id: reservation.id,
    startsAt: reservation.startsAt,
    policy,
  });
}

function decideCancellation(
  reservation: CancellationCandidate,
  cancelledBy: UserId,
  cancelledAt: Instant,
): Result<Cancellation, ReservationCannotBeCancelled> {
  if (!reservation.startsAt.isAfter(cancelledAt)) {
    return Err(new ReservationCannotBeCancelled());
  }

  const fee =
    reservation.policy.type === "free_until" &&
    cancelledAt.isAfter(reservation.policy.freeUntil)
      ? reservation.policy.feeAfter
      : Money.zero("SEK");

  return Ok({
    reservationId: reservation.id,
    cancelledBy,
    cancelledAt,
    fee,
  });
}
```

```ts
async function handleCancelReservation(
  command: CancelReservation,
): Promise<Result<Cancellation, CancellationError>> {
  const reservation = await reservations.get(command.reservationId);

  if (reservation.isErr()) {
    return reservation;
  }

  const candidate = toCancellationCandidate(reservation.value);

  if (candidate.isErr()) {
    return candidate;
  }

  const cancellation = decideCancellation(
    candidate.value,
    command.userId,
    clock.now(),
  );

  if (cancellation.isErr()) {
    return cancellation;
  }

  return cancellations.save(cancellation.value);
}
```

The abstraction demonstrated here is `Reservation` → `CancellationCandidate`; extracting the decision is a separate opportunity covered later.

Create a narrow model when an operation needs a stable subset of facts or a stronger subset of states. Pass the larger value when the operation genuinely reasons about the whole concept.

## 2. Effects grant too much authority: inject semantic capabilities

A function's world includes every effect reachable through its dependencies. Hidden imports and broad contexts also leave no seam where a test can substitute the environment.

### Concrete

```ts
async function sendValuationReminder(
  context: AppContext,
  valuationId: ValuationId,
): Promise<Result<void, ReminderError>> {
  const valuation = await context.database.valuations.find(valuationId);

  if (!valuation) {
    return Err(new ValuationNotFound());
  }

  const customer = await context.database.customers.find(valuation.customerId);

  if (!customer) {
    return Err(new CustomerNotFound());
  }

  if (!customer.email) {
    return Err(new CustomerCannotBeReminded());
  }

  const reminder = createReminder(valuation, customer.email);
  const delivered = await context.mailer.send(reminder);

  if (delivered.isErr()) {
    await context.logger.warn("reminder delivery failed", {
      valuationId,
      customerId: customer.id,
      error: delivered.error,
    });

    return delivered;
  }

  await context.database.reminders.insert({
    valuationId,
    customerId: customer.id,
    sentAt: context.clock.now(),
  });

  return Ok(undefined);
}
```

The operation can reach every table, every mailer method, logging, and time. A test must build or fake an application context even though the decision needs only a reminder target, delivery, and a sent-record write.

### Abstracted

```ts
type ReminderTarget = {
  valuation: Valuation;
  customerId: CustomerId;
  email: EmailAddress;
};

type LoadReminderTarget = (
  valuationId: ValuationId,
) => Promise<Result<ReminderTarget, ValuationNotFound | CustomerCannotBeReminded>>;

type DeliverReminder = (
  reminder: Reminder,
) => Promise<Result<void, DeliveryFailed>>;

type RecordReminderSent = (
  valuationId: ValuationId,
  customerId: CustomerId,
) => Promise<Result<void, ReminderWriteFailed>>;

async function sendValuationReminder(
  loadTarget: LoadReminderTarget,
  deliverReminder: DeliverReminder,
  recordSent: RecordReminderSent,
  valuationId: ValuationId,
): Promise<Result<void, ReminderError>> {
  const target = await loadTarget(valuationId);

  if (target.isErr()) {
    return target;
  }

  const delivered = await deliverReminder(
    createReminder(target.value.valuation, target.value.email),
  );

  if (delivered.isErr()) {
    return delivered;
  }

  return recordSent(valuationId, target.value.customerId);
}
```

The signature is a **seam** around semantic effects. The function can load a reminder target, deliver that reminder, and record success; it cannot query unrelated data, send arbitrary mail, log policy decisions, or choose a clock.

The seam can be supplied by a test without constructing the application:

```ts
const sent: Reminder[] = [];
const records: Array<[ValuationId, CustomerId]> = [];

const result = await sendValuationReminder(
  async () => Ok({ valuation, customerId, email }),
  async (reminder) => {
    sent.push(reminder);
    return Ok(undefined);
  },
  async (valuationId, customerId) => {
    records.push([valuationId, customerId]);
    return Ok(undefined);
  },
  valuation.id,
);
```

Dependency injection here means passing capabilities as values, not adding a container or class hierarchy. Inject `LoadReminderTarget`, not `AppContext`; the latter is replaceable but still grants a large world.

Extract pure decisions before mocking effects. Use lightweight fakes or stubs for the effects that remain, and test results and observable effects rather than internal call choreography.

## 3. A decision carries irrelevant machinery: give the decision its own boundary

When policy lives inside I/O, loops, or infrastructure, understanding it also requires considering storage, time, asynchronous failure, and execution mechanics.

### Concrete

```ts
async function handleCompleteValuation(
  valuationId: ValuationId,
  completedBy: UserId,
): Promise<Result<CompletedValuation, CompleteValuationError>> {
  const valuation = await valuations.get(valuationId);

  if (valuation.isErr()) {
    return valuation;
  }

  if (valuation.value.status !== "in_progress") {
    return Err(new ValuationCannotBeCompleted());
  }

  const completedAt = clock.now();
  const completed = {
    ...valuation.value,
    status: "completed" as const,
    completedBy,
    completedAt,
    expiresAt: completedAt.add(days(3)),
  };

  const saved = await valuations.save(completed);

  if (saved.isErr()) {
    return saved;
  }

  await valuationEvents.publish({
    type: "valuation_completed",
    valuationId: completed.id,
    completedBy,
    completedAt,
  });

  return saved;
}
```

### Abstracted

```ts
type ValuationCompletion = {
  valuation: CompletedValuation;
  event: ValuationCompleted;
};

function decideValuationCompletion(
  valuation: Valuation,
  completedBy: UserId,
  completedAt: Instant,
): Result<ValuationCompletion, ValuationCannotBeCompleted> {
  if (valuation.status !== "in_progress") {
    return Err(new ValuationCannotBeCompleted());
  }

  const completed: CompletedValuation = {
    ...valuation,
    status: "completed",
    completedBy,
    completedAt,
    expiresAt: completedAt.add(days(3)),
  };

  return Ok({
    valuation: completed,
    event: {
      type: "valuation_completed",
      valuationId: completed.id,
      completedBy,
      completedAt,
    },
  });
}
```

```ts
async function handleCompleteValuation(
  valuationId: ValuationId,
  completedBy: UserId,
): Promise<Result<CompletedValuation, CompleteValuationError>> {
  const valuation = await valuations.get(valuationId);

  if (valuation.isErr()) {
    return valuation;
  }

  const completion = decideValuationCompletion(
    valuation.value,
    completedBy,
    clock.now(),
  );

  if (completion.isErr()) {
    return completion;
  }

  const saved = await valuations.save(completion.value.valuation);

  if (saved.isErr()) {
    return saved;
  }

  await valuationEvents.publish(completion.value.event);
  return saved;
}
```

The decision has no storage, clock, network, or asynchronous failure. This is **functional core, imperative shell**: pure decisions own meaningful branches; mechanisms iterate or execute their results.

## 4. Algorithmic state leaks into the operation: hide it behind a value transformation

Algorithmic state adds identity, ordering, and intermediate state to a function's world. Keep it behind a boundary when it is a useful implementation of a meaningful value transformation.

### Concrete

```ts
async function publishDailyAvailability(
  vehicleId: VehicleId,
  day: LocalDate,
): Promise<Result<void, AvailabilityError>> {
  const calendar = await calendars.load(vehicleId, day);

  if (calendar.isErr()) {
    return calendar;
  }

  const reservations = await reservations.findForVehicle(vehicleId, day);

  if (reservations.isErr()) {
    return reservations;
  }

  const blocked = reservations.value
    .map((reservation) => ({
      startsAt: reservation.startsAt,
      endsAt: reservation.endsAt,
    }))
    .sort((a, b) => a.startsAt.compare(b.startsAt));

  const available: TimeRange[] = [];
  let cursor = calendar.value.opensAt;

  for (const range of blocked) {
    if (range.startsAt.isAfter(cursor)) {
      available.push({ startsAt: cursor, endsAt: range.startsAt });
    }

    if (range.endsAt.isAfter(cursor)) {
      cursor = range.endsAt;
    }
  }

  if (cursor.isBefore(calendar.value.closesAt)) {
    available.push({ startsAt: cursor, endsAt: calendar.value.closesAt });
  }

  await availabilityFeed.publish({ vehicleId, day, available });
  return Ok(undefined);
}
```

The publishing operation contains I/O, sorting, cursor movement, overlap handling, and gap construction. A change to interval math risks the effect shell.

### Abstracted

```ts
function availableRanges(
  opening: TimeRange,
  blocked: readonly TimeRange[],
): TimeRange[] {
  const sorted = [...blocked].sort((a, b) => a.startsAt.compare(b.startsAt));
  const available: TimeRange[] = [];
  let cursor = opening.startsAt;

  for (const range of sorted) {
    if (range.startsAt.isAfter(cursor)) {
      available.push({ startsAt: cursor, endsAt: range.startsAt });
    }

    if (range.endsAt.isAfter(cursor)) {
      cursor = range.endsAt;
    }
  }

  if (cursor.isBefore(opening.endsAt)) {
    available.push({ startsAt: cursor, endsAt: opening.endsAt });
  }

  return available;
}
```

```ts
async function publishDailyAvailability(
  vehicleId: VehicleId,
  day: LocalDate,
): Promise<Result<void, AvailabilityError>> {
  const calendar = await calendars.load(vehicleId, day);

  if (calendar.isErr()) {
    return calendar;
  }

  const reservations = await reservations.findForVehicle(vehicleId, day);

  if (reservations.isErr()) {
    return reservations;
  }

  const blocked = reservations.value.map((reservation) => ({
    startsAt: reservation.startsAt,
    endsAt: reservation.endsAt,
  }));

  await availabilityFeed.publish({
    vehicleId,
    day,
    available: availableRanges(
      {
        startsAt: calendar.value.opensAt,
        endsAt: calendar.value.closesAt,
      },
      blocked,
    ),
  });

  return Ok(undefined);
}
```

`availableRanges` owns the cursor algorithm and exposes a value transformation. The publishing shell no longer considers sorting, overlaps, or intermediate cursor state.

Wrapping an awkward language API without hiding meaningful knowledge adds little compression.

## 5. Callers coordinate machinery or protocols: introduce a semantic boundary

Infrastructure primitives and required call sequences force callers to reason about how an operation works rather than what it means. The boundary pays off when that protocol would otherwise spread.

### Concrete

```ts
async function handleReserveVehicle(
  command: ReserveVehicleCommand,
): Promise<Result<Reservation, ReservationError>> {
  return database.transaction(async (transaction) => {
    const vehicle = await vehicleRepository.findForUpdate(
      transaction,
      command.vehicleId,
    );

    if (!vehicle || vehicle.status !== "available") {
      return Err(new VehicleUnavailable());
    }

    await vehicleRepository.update(transaction, {
      ...vehicle,
      status: "reserved",
    });

    return reservationRepository.insert(transaction, {
      vehicleId: command.vehicleId,
      customerId: command.customerId,
      status: "pending",
      source: "customer",
    });
  });
}

async function holdVehicleForPartner(
  request: PartnerHoldRequest,
): Promise<Result<Reservation, ReservationError>> {
  return database.transaction(async (transaction) => {
    const vehicle = await vehicleRepository.findForUpdate(
      transaction,
      request.vehicleId,
    );

    if (!vehicle || vehicle.status !== "available") {
      return Err(new VehicleUnavailable());
    }

    await vehicleRepository.update(transaction, {
      ...vehicle,
      status: "reserved",
    });

    return reservationRepository.insert(transaction, {
      vehicleId: request.vehicleId,
      customerId: request.customerId,
      status: "pending",
      source: "partner",
    });
  });
}
```

Both callers must know the same protocol: start a transaction, lock the vehicle, validate availability, update vehicle state, insert the reservation, and keep the writes atomic. A change to the reservation guarantee has multiple callers to audit.

### Abstracted

```ts
type ReserveVehicle = (
  input: {
    vehicleId: VehicleId;
    customerId: CustomerId;
    source: ReservationSource;
  },
) => Promise<Result<Reservation, VehicleUnavailable>>;
```

```ts
async function handleReserveVehicle(
  reserveVehicle: ReserveVehicle,
  command: ReserveVehicleCommand,
): Promise<Result<Reservation, ReservationError>> {
  return reserveVehicle({
    vehicleId: command.vehicleId,
    customerId: command.customerId,
    source: "customer",
  });
}

async function holdVehicleForPartner(
  reserveVehicle: ReserveVehicle,
  request: PartnerHoldRequest,
): Promise<Result<Reservation, ReservationError>> {
  return reserveVehicle({
    vehicleId: request.vehicleId,
    customerId: request.customerId,
    source: "partner",
  });
}
```

The callers now depend on the semantic operation: reserve the vehicle or fail. The transaction, lock, state transition, insert order, and atomicity guarantee have one owner.

Return the smallest meaningful result. Storage rows, provider responses, intermediate values, and operational metadata stay behind the boundary unless the caller's responsibility genuinely requires them.

Resource lifetimes are protocols too. Clear ownership is an implementation concern. Introduce a scoped abstraction when callers would otherwise need to participate in the lifetime protocol.

### Concrete

```ts
const file = await open(path);

try {
  return await importEvents(file);
} finally {
  await file.close();
}
```

### Abstracted

```ts
return withFile(path, (file) => importEvents(file));
```

`withFile` removes acquisition and release from the caller.

Use a semantic operation when callers need a result rather than the machinery or sequence that produces it. Use a scoped callback when code must operate inside a lifetime without owning it.

## 6. A foreign system enters local reasoning: translate it at a seam

External systems bring foreign data, terminology, failures, exceptions, and operational rules into every function that uses them directly.

### Concrete

```ts
async function checkout(
  order: Order,
  attemptId: PaymentAttemptId,
): Promise<Result<Payment, CheckoutError>> {
  try {
    const intent = await stripe.paymentIntents.create(
      {
        amount: order.total.minorUnits,
        currency: order.total.currency,
      },
      {
        idempotencyKey: attemptId,
      },
    );

    return Ok({ id: PaymentId(intent.id) });
  } catch (error: unknown) {
    if (isStripeCardDeclined(error)) {
      return Err(new PaymentDeclined());
    }

    if (isStripeTemporaryFailure(error)) {
      return Err(new PaymentTemporarilyUnavailable());
    }

    return Err(new UnexpectedPaymentFailure(error));
  }
}
```

Checkout must understand Stripe's request, identifiers, idempotency, exceptions, and error taxonomy.

### Abstracted

```ts
type ChargeError =
  | { type: "payment_declined" }
  | { type: "temporarily_unavailable" }
  | { type: "unexpected"; cause: unknown };

type ChargePayment = (
  attemptId: PaymentAttemptId,
  amount: Money,
) => Promise<Result<Payment, ChargeError>>;

function createStripeChargePayment(stripe: Stripe): ChargePayment {
  return async (attemptId, amount) => {
    try {
      const intent = await stripe.paymentIntents.create(
        {
          amount: amount.minorUnits,
          currency: amount.currency,
        },
        {
          idempotencyKey: attemptId,
        },
      );

      return Ok({ id: PaymentId(intent.id) });
    } catch (error: unknown) {
      return Err(translateStripeChargeError(error));
    }
  };
}
```

```ts
async function checkout(
  chargePayment: ChargePayment,
  order: Order,
  attemptId: PaymentAttemptId,
): Promise<Result<Payment, CheckoutError>> {
  return chargePayment(attemptId, order.total);
}
```

Shape the contract by the domain rather than by a hypothetical set of payment providers:

```ts
const chargePayment: ChargePayment = createStripeChargePayment(stripe);
```

Translate foreign data and uncertainty into a local contract. The adapter owns provider request and response shapes, converts thrown failures into `Result`, and preserves unexpected failures as unexpected instead of disguising them as domain outcomes.

## Apply the style

Inspect concrete code for every opportunity:

1. Narrow excess facts and states.
2. Restrict effect authority and create seams.
3. Extract pure decisions from effects and mechanism.
4. Contain mutation and algorithmic state.
5. Replace machinery and protocols with semantic inputs and outputs.
6. Translate foreign systems at a seam.

For every abstraction introduced, name the reasoning removed on each side of its boundary. Keep the code concrete where the boundary removes nothing substantial.

The review is complete when every opportunity has been considered, each remaining function has the smallest world consistent with its responsibility, and every new boundary provides more compression than indirection.
