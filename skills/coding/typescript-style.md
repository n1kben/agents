# TypeScript

Use TypeScript's type system to make illegal states difficult or impossible to construct. Validate untrusted values at boundaries, then keep the program interior strongly typed.

## Rules

| Rule | Guidance |
| --- | --- |
| Discriminated unions | Model variants with a `kind` literal discriminant so impossible states cannot be represented. Avoid optional-field bags. |
| Branded types | Brand primitives with `& { readonly __brand: "X" }` when confusing values would be dangerous. Validate once at the boundary. |
| Constructive modeling | Build shapes from legal parts: `[T, ...T[]]` for non-empty collections, `[T, T][]` for pairs, or `start` plus a validated duration for a range. |
| Simplest total type | Keep `T[]` while every operation is total. Strengthen to `NonEmpty<T>` when the loose type forces `!`, a cast, or a “should never happen” throw. |
| Explicit errors | Return expected failures as `Result<T, E>`. For asynchronous work, use `Promise<Result<T, E>>`, `ResultAsync<T, E>`, or an effect with a typed error channel instead of rejecting a promise. |
| `unknown` over `any` | External data is `unknown`. `any` disables type checking everywhere it flows. |
| Schemas before guards | Before hand-writing a property-by-property guard, use the repository's runtime schema library and infer the type from the schema. |
| No unearned `as` casts | Prefer inference and narrowing. Cast only at a boundary after runtime validation establishes the claim. |
| Narrowing hierarchy | Prefer a discriminant switch, then `in`, `typeof`/`instanceof`, a verified type guard, and only then a boundary cast. |
| Type guards | Verify the complete claim and name guards `isX` or `hasX`. |
| Exhaustiveness | Assign the remaining value to `never` in default arms so a new variant produces a compiler error. |
| `satisfies` over `as` | Validate a value without widening its literal types. |
| Boundary validation | Parse data where it enters into a named domain type. Keep `Record<string, unknown>` inside boundary adapters. |
| Schema-derived types | Reach for generated types, `Pick`, `Omit`, `Parameters`, `ReturnType`, `Awaited`, and `typeof` before declaring a duplicate interface. |
| Object arguments | Prefer object arguments when positional parameters can be confused. Skip the allocation on measured hot paths. |
| Real tests | Do not mock what can run locally. Prefer real framework primitives, leak and disposable checks, and verification in a running system. |
| Structured telemetry | Emit structured diagnostics with enough context to investigate from an identifier. Do not ship `console.log`. |

## Explicit errors

Expected failures are values, not invisible control flow. TypeScript does not record thrown exceptions or promise rejection types in a function signature, so callers cannot discover or exhaustively handle them from the type alone.

Model recoverable failures as a discriminated `Result`:

```ts
type Result<T, E> =
  | { kind: "ok"; value: T }
  | { kind: "error"; error: E };

type RenameProjectError =
  | { kind: "invalid-name"; name: string }
  | { kind: "already-exists"; name: string };

declare function renameProject(
  name: string,
): Result<Project, RenameProjectError>;
```

The same rule applies to asynchronous work. `Promise<User>` describes only fulfillment; it does not reveal what rejection can contain. Prefer a promise that fulfills with a result, or the repository's typed async/effect abstraction:

```ts
declare function loadUser(
  id: UserId,
): Promise<Result<User, LoadUserError>>;
```

Use the repository's existing error abstraction. If it has none and explicit-error composition is substantial, consider:

- [`better-result`](https://github.com/dmmulroy/better-result) for `Result`, tagged errors, and synchronous or asynchronous composition.
- [`neverthrow`](https://github.com/supermacro/neverthrow) for `Result` and `ResultAsync`.
- [`Effect`](https://github.com/Effect-TS/effect) when the application already benefits from typed errors together with effects, dependencies, concurrency, or resource management.

Do not add a library when a small local union is enough. Do not mix several Result conventions in one codebase.

Reserve `throw` and rejected promises for defects and truly unrecoverable invariant violations. Catch throwable third-party APIs at the boundary and translate expected failures into named domain-error variants. Do not immediately unwrap a `Result` by throwing; handle or propagate its error branch explicitly.

## Branded types

Brand primitives so they can't be mixed up. Validate once at the boundary; downstream code trusts the type.

```ts
type AgentId = string & { readonly __brand: "AgentId" };

function parseAgentId(
  input: string,
): Result<AgentId, { kind: "invalid-agent-id" }> {
  if (!isUUID(input)) {
    return { kind: "error", error: { kind: "invalid-agent-id" } };
  }
  return { kind: "ok", value: input as AgentId };
}

function focusAgent(id: AgentId): void {
  /* input is trusted */
}
```

Match the `readonly __brand: 'X'` shape; don't invent a new convention.

## Discriminated unions

If a bug forces the question "wait, can this combination actually happen?", the type is too loose. Model variants with a literal discriminant: every variant shares the field name and each variant's value is unique, so impossible combos can't be represented.

```ts
// Don't. Boolean + optionals lets contradictory states exist.
type DiffState = { loading: boolean; diff?: GitDiff; error?: string };

// Do. Only valid states exist.
type DiffState =
  | { kind: "loading" }
  | { kind: "ready"; diff: GitDiff }
  | { kind: "error"; error: string };
```

Use one discriminant name (`kind`, `type`, or `tag`) within a union and follow the codebase convention for new unions.

## Constructive modeling

Build the type from parts that are all legal instead of restricting a loose type with runtime checks. Adding is easier than subtracting.

Non-empty, via a variadic tuple:

```ts
type NonEmpty<T> = [T, ...T[]];

// Don't: T[] plus a length check every caller must repeat
function pickWinner(entries: string[]): string {
  if (entries.length === 0) throw new Error("no entries");
  return entries[Math.floor(Math.random() * entries.length)];
}

// Do: an empty value of the type can't exist
function pickWinner(entries: NonEmpty<string>): string {
  return entries[Math.floor(Math.random() * entries.length)];
}
```

Where a plain `T[]` arrives, narrow once with a guard. The fact then travels in the type:

```ts
const isNonEmpty = <T>(arr: T[]): arr is NonEmpty<T> => arr.length > 0;
```

Even length, as pairs. TypeScript has no refinement types (no `arr.length % 2 === 0` at the type level); you don't need one:

```ts
type Pairs<T> = [T, T][];
```

A time range, as start plus duration:

```ts
// Don't: a comment holds the invariant
type TimeRange = { start: Date; end: Date }; // start <= end

// Do: endpoints cannot contradict each other; derive end when needed
type TimeRange = { start: Date; durationMs: number };
```

Validate that `durationMs` is finite and non-negative at the boundary. Brand it (per Branded types) only when that fact or its unit must travel in the type, not by reflex. A `Pairs<T>` is an even-length list under the interpretation you give it, the same way `{ start, durationMs }` is a range. Pick the representation that makes the bad state unconstructable, then expose the reading you need on top (`pairs.flat()`, a `rangeEnd()` helper).

## Simplest total type

Don't strengthen everything. Keep `T[]` when every operation on it is total:

```ts
const sum = (xs: number[]) => xs.reduce((a, b) => a + b, 0); // [] is 0, fine
```

Strengthen when the loose type forces a lie at a use site. The tells are `!`, `arr[0] as T`, and a "should never happen" throw:

```ts
// Don't: partiality smuggled past the compiler
function newestSession(sessions: Session[]): Session {
  return sessions.at(0)!;
}

// Do: strengthen the input; the assertion disappears
function newestSession(sessions: NonEmpty<Session>): Session {
  return sessions[0];
}
```

Weakening the result to `Session | undefined` is the other total signature. Either way the empty case lands at the call site, the one place that knows what empty means.

## `unknown` over `any`

`any` disables type checking for everything it touches. External data is always `unknown`. Narrow before use.

```ts
// Don't
function handle(input: any) {
  return input.foo.bar;
}

// Do
function handle(input: unknown) {
  if (typeof input === "object" && input !== null && "foo" in input) {
    // narrowed; compiler verifies access
  }
}
```

External sources include RPC payloads, `JSON.parse`, `postMessage`, IPC, file contents, environment variables, database results.

## Schemas before hand-rolled guards

Before writing a property-by-property type guard for external data, look for the repository's runtime schema library and existing schemas. Let one schema own validation and derive the TypeScript type from it. Do not maintain a schema, a duplicate interface, and a guard that can drift apart.

```ts
import { z } from "zod";

const UserSchema = z.object({
  id: z.string().uuid(),
  role: z.enum(["admin", "member"]),
});

type User = z.infer<typeof UserSchema>;

type ParseUserError = { kind: "invalid-user"; issues: string[] };

function parseUser(input: unknown): Result<User, ParseUserError> {
  const parsed = UserSchema.safeParse(input);
  return parsed.success
    ? { kind: "ok", value: parsed.data }
    : {
        kind: "error",
        error: {
          kind: "invalid-user",
          issues: parsed.error.issues.map((issue) => issue.message),
        },
      };
}
```

Use the equivalent inference and non-throwing parse helpers when the repository uses another schema library. Do not add a new schema dependency for one guard; this rule prefers the schema system the codebase already trusts.

## No unearned `as` casts

Every `as` is a potential runtime crash. Cast only after the type system has verified the claim.

```ts
// Don't
const user = data as User;

// Do. The schema owns validation and the Result exposes failure.
const parsedUser = parseUser(data);
if (parsedUser.kind === "ok") {
  renderUser(parsedUser.value);
}
```

When refactoring an `as` out of existing code, identify why TypeScript can't infer:

- Missing discriminant: add one, switch to a discriminated union.
- Overly wide source type (e.g. `Record<string, unknown>`): narrow it.
- Untyped boundary: add a parse function or schema.
- Genuinely inexpressible: use a branded type or `satisfies`.

## Narrowing hierarchy

From best to last-resort:

1. **Discriminated union switch / if.** Compiler narrows automatically.
2. **`in` operator.** `"key" in obj` narrows to variants containing that key.
3. **`typeof` / `instanceof`.** For primitives and class instances.
4. **User-defined type guard.** When the above aren't enough.
5. **`as` cast.** Only after validation.

```ts
function area(s: Shape): number {
  if ("radius" in s) return Math.PI * s.radius ** 2; // narrowed to circle
  return s.width * s.height; // narrowed to rect
}
```

## Type guards

A guard must actually verify the claim. A lying guard is worse than `as` because the bug hides behind a name that says it's safe.

```ts
function isCircle(s: Shape): s is Shape & { kind: "circle" } {
  return s.kind === "circle";
}
```

Prefer discriminant narrowing when possible. The guard adds a layer the reader has to follow.

## Exhaustiveness

In default arms, assign the discriminant to a `never`-typed local. The compiler errors if a new variant is added without handling.

```ts
// Value-returning switch
function area(s: Shape): number {
  switch (s.kind) {
    case "circle":
      return Math.PI * s.radius ** 2;
    case "rect":
      return s.width * s.height;
    default: {
      const _exhaustive: never = s;
      return _exhaustive;
    }
  }
}

// Void switch
function handle(s: Shape): void {
  switch (s.kind) {
    case "circle":
      drawCircle(s);
      break;
    case "rect":
      drawRect(s);
      break;
    default: {
      const _exhaustive: never = s;
      void _exhaustive;
    }
  }
}
```

Return-style in value-returning switches; void-style in statement switches.

## `satisfies` over `as`

`satisfies` validates without widening literal types.

```ts
// Don't. Widens, loses literal types.
const config = { theme: "dark", cols: 3 } as Config;

// Do. Validates AND preserves literal types.
const config = { theme: "dark", cols: 3 } satisfies Config;
// config.theme is "dark" (literal), not string
```

## Boundary validation

Validate once where data crosses in; trust types inside.

- **Wire formats** (proto, JSON-RPC): parse with `ignoreUnknownFields` so forward-compatible changes don't break old clients.
- **Persisted JSON:** versioned blob with a try/catch around the parse.
- **Don't re-validate** deep in call chains.

## Schema-derived types

When a `.proto`, OpenAPI spec, GraphQL schema, or database migration already defines a shape, derive from the generated types instead of duplicating them.

```ts
// Don't. Duplicate shape, drifts when the schema changes.
type CheckSummary = {
  totalCount: number;
  checks: { name: string; status: string }[];
};
function renderChecks(s: CheckSummary) {
  /* ... */
}

// Do. Derive from the generated schema type.
import type { ChecksMessage } from "<generated module>";
function renderChecks(s: Pick<ChecksMessage, "totalCount" | "checks">) {
  /* ... */
}
```

Reach for `Pick`, `Omit`, `Parameters`, `ReturnType`, `Awaited`, `typeof` before writing a new interface.

## Object args

```ts
// Don't. Swap adjacent numbers and it still compiles.
openFile(uri, 10, 1, 10, 1);

// Do. Order-independent, self-documenting.
openFile({
  uri,
  selection: {
    startLineNumber: 10,
    startColumn: 1,
    endLineNumber: 10,
    endColumn: 1,
  },
});
```

Skip on hot paths: per-frame render, tokenizers, parsers, anything in a tight loop where the allocation cost matters.

## Real tests

Don't mock what can run locally. Prefer the framework's real test primitives, including leak and disposable checks, and verify integrated behavior in a running system. Mock only unavailable or impractical dependencies.

Assert observable behavior rather than implementation details.

## Structured telemetry

Use the repository's structured logger in shipped code. Include a stable event name and enough identifiers and context to investigate the failure.

```ts
logger.error("sync_failed", {
  accountId,
  operationId,
  retryCount,
  error,
});
```

Do not ship `console.log`. Never include secrets or sensitive payloads in telemetry.
