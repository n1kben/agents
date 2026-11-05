# TypeScript rules

Apply to `.ts`, `.tsx`, `.mts`, and `.cts` source.

- No type assertions: `value as Type`, `value as const`, or `<Type>value`.
- No chained assertions, including `value as unknown as Type`.
- No explicit `any`.
- No non-null assertions (`value!`).
- No type aliases that only rename `unknown`.
- No broad `object` parameter types.
- No dictionary value types based on `any`, `unknown`, `object`, or `{}`.
- No widening a known value to `unknown` or `object` and asserting it back later.

The last four patterns are inspired by [dmmulroy/anti-slop](https://github.com/dmmulroy/anti-slop). Recreate only the rules needed in the target repository; do not copy its requirement for safety comments, which conflicts with the no-comments rule.
