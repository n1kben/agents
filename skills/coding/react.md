# React

Treat `useEffect` as harmful by default. An Effect is an escape hatch for synchronizing with a system outside React, not a general-purpose tool for coordinating application data flow.

## Rules

| Rule | Guidance |
| --- | --- |
| Effects are escape hatches | Use an Effect only to synchronize with an external system that React does not control. |
| Derive during render | Compute values from props and state during render. Do not mirror derived values into state with an Effect. |
| Events stay in handlers | Logic caused by a user action belongs in that action's event handler, not in an Effect watching for state changes. |
| Use the data layer | Prefer the framework's loader, server-component, or established query/cache abstraction over fetching in an Effect. |
| Dependencies tell the truth | Include every reactive dependency. Never suppress the hooks linter to force a dependency list. |
| Setup mirrors cleanup | Every external subscription or resource acquired by an Effect must be completely released by its cleanup. |
| Repeated execution is safe | Effects must remain correct across setup, cleanup, and setup again. Do not depend on running exactly once. |
| Memoization is not semantics | Use `useMemo` and `useCallback` for measured performance needs, not to repair incorrect data flow or silence Effect dependencies. |
| Isolated UI states | Add or update a Storybook story, component sandbox, or equivalent harness for every component or screen changed. |

## `useEffect` is considered harmful

Before writing an Effect, name the external system it synchronizes with. Valid examples include a browser API, timer, network connection, non-React widget, or external subscription. If there is no external system, do not use an Effect.

### Derive values during render

```tsx
// Don't: duplicates state and requires an extra render.
const [fullName, setFullName] = useState("");

useEffect(() => {
  setFullName(`${firstName} ${lastName}`);
}, [firstName, lastName]);

// Do: the value cannot become stale.
const fullName = `${firstName} ${lastName}`;
```

Use `useMemo` only when the derivation is measurably expensive. It is a performance optimization, not a source of truth.

### Keep interaction logic in event handlers

```tsx
// Don't: turns an interaction into state observed by an Effect.
useEffect(() => {
  if (submittedOrder !== null) {
    submitOrder(submittedOrder);
  }
}, [submittedOrder]);

// Do: the cause and effect stay together.
function handleSubmit(order: Order): void {
  submitOrder(order);
}
```

Do not introduce state merely to trigger an Effect. Put shared interaction logic in a function called by the relevant handlers.

### Synchronize with external systems

```tsx
useEffect(() => {
  const connection = createConnection(roomId);
  connection.connect();

  return () => connection.disconnect();
}, [roomId]);
```

Keep the Effect small and protocol-shaped: acquire or synchronize, then undo that work in cleanup. Extract a custom Hook when it gives the external protocol one cohesive owner, not merely to hide a complicated Effect.

## Do not lie about dependencies

The dependency list describes the reactive values the Effect reads; it is not a scheduling preference. Include them all and keep the hooks linter enabled.

When a dependency causes unwanted reruns, change the surrounding design instead of omitting it. Move constants outside the component, derive values during render, put interaction logic in handlers, or narrow the Effect to the actual external synchronization.

Never use a ref flag to make an Effect “run once.” Development setup-cleanup-setup cycles expose missing cleanup and unsafe assumptions.

## Avoid Effect-based data fetching

Use the repository's established data-loading boundary: framework loaders, server components, route data, or a query/cache library. These mechanisms can own caching, deduplication, cancellation, race handling, and server rendering coherently.

When direct Effect-based fetching is genuinely required, handle cancellation and stale responses explicitly and keep the transport concern behind a focused Hook or boundary.

## Stories and sandboxes

Every component or screen added or changed must be directly renderable in Storybook, the repository's component sandbox, or an equivalent isolated harness. Cover the meaningful loading, empty, populated, error, disabled, long-content, and constrained-layout states.

Render the production component with explicit props and deterministic fixtures. Do not reproduce its appearance in a story-only component. Keep network access, routing, clocks, and persistent storage outside the presentational boundary so the harness can construct every state without coordinating Effects.
