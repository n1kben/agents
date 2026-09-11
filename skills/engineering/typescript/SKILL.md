---
name: typescript
description: TypeScript-specific patterns for typed failures, parsed boundaries, valid state models, and safe narrowing. Use when writing, changing, reviewing, or discussing TypeScript code.
---

TypeScript does not record thrown exceptions or promise rejection types. Use the repository's existing `Result<T, E>` convention to put recoverable failures in the signature.

```ts
type Result<T, E> =
  | { kind: "ok"; value: T }
  | { kind: "error"; error: E };

type LoadUserError =
  | { kind: "not-found"; userId: UserId }
  | { kind: "unavailable" };

declare function loadUser(
  userId: UserId,
): Promise<Result<User, LoadUserError>>;
```

Do not add a Result dependency when a small local union is enough.

## Parse Boundaries

Use `unknown` for external data. When the repository has a schema system, infer the TypeScript type from the schema.

```ts
const UserSchema = z.object({
  id: z.string().uuid(),
  role: z.enum(["admin", "member"]),
});

type User = z.infer<typeof UserSchema>;

function parseUser(input: unknown): Result<User, ParseUserError> {
  const parsed = UserSchema.safeParse(input);
  return parsed.success
    ? { kind: "ok", value: parsed.data }
    : { kind: "error", error: { kind: "invalid-user" } };
}
```

Derive from generated schemas and existing values with `typeof`, `Pick`, `Omit`, `Parameters`, `ReturnType`, and `Awaited` before declaring another representation of the same data.

## Model Valid States

Use discriminated unions when variants carry different facts. Avoid boolean flags and optional fields that admit contradictory combinations.

```ts
// Don't: loading, data, and error can contradict each other.
type UserState = {
  loading: boolean;
  user?: User;
  error?: string;
};

// Do: every representable state has one meaning.
type UserState =
  | { kind: "loading" }
  | { kind: "loaded"; user: User }
  | { kind: "failed"; message: string };
```

Handle variants exhaustively:

```ts
function title(state: UserState): string {
  switch (state.kind) {
    case "loading":
      return "Loading…";
    case "loaded":
      return state.user.name;
    case "failed":
      return state.message;
    default: {
      const exhaustive: never = state;
      return exhaustive;
    }
  }
}
```

## Narrow Before Casting

Prefer discriminants, `in`, `typeof`, `instanceof`, and verified type guards over `as`. A type guard must check the complete claim it makes. Use `satisfies` when a value should be checked without widening its literal types.

Keep `any` and unchecked casts confined to unavoidable interoperability boundaries.
