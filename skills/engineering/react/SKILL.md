---
name: react
description: React-specific patterns for derived rendering, event handling, effects, and inspectable UI states. Use when writing, changing, reviewing, or discussing React components and hooks.
disable-model-invocation: true
---

In React, derive the rendered result from props and state. Do not mirror derived values into state.

```tsx
// Don't: duplicates state and needs another render to become correct.
const [fullName, setFullName] = useState("");

useEffect(() => {
  setFullName(`${firstName} ${lastName}`);
}, [firstName, lastName]);

// Do: the value cannot become stale.
const fullName = `${firstName} ${lastName}`;
```

Use `useMemo` and `useCallback` only for measured performance needs, not as sources of truth or repairs for incorrect data flow.

## Events

Keep behavior caused by a user action in that action's event handler. Do not introduce state merely to trigger an Effect.

```tsx
// Don't: turns an interaction into state observed elsewhere.
useEffect(() => {
  if (submittedOrder) submitOrder(submittedOrder);
}, [submittedOrder]);

// Do: cause and effect stay together.
function handleSubmit(order: Order): void {
  submitOrder(order);
}
```

## Effects

Use `useEffect` only to synchronize with a system outside React, such as a browser API, timer, network connection, external subscription, or non-React widget.

```tsx
useEffect(() => {
  const connection = createConnection(roomId);
  connection.connect();

  return () => connection.disconnect();
}, [roomId]);
```

Keep every Effect small and protocol-shaped. Its dependencies must describe every reactive value it reads, its cleanup must undo its setup, and it must remain correct when React runs setup and cleanup more than once. Do not suppress the hooks linter or use a ref flag to force an Effect to run once.

Prefer the repository's framework loader, server component, or established query layer over fetching in an Effect. When direct Effect-based fetching is necessary, handle cancellation and stale responses explicitly.

## Inspectable UI

Render the production component with explicit props and deterministic fixtures. Add stories, a component sandbox, or the project's equivalent for meaningful states.

```tsx
type Story = StoryObj<typeof AccountPanel>;

export const Loading = {
  args: { state: { kind: "loading" } },
} satisfies Story;

export const Failed = {
  args: { state: { kind: "failed", message: "Account unavailable" } },
} satisfies Story;
```
