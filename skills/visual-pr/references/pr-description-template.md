[{RELEVANT LINK}]({RELEVANT LINK}) | [{RELEVANT LINK 2}]({RELEVANT LINK 2})

## Why the change

{Exactly one sentence explaining the problem and what becomes possible after this ships.}

## Special things to note

- {List one to three reviewer warnings, migrations, compatibility constraints, deliberate omissions, or surprising decisions. Use "None." when there are none.}

## Change outline

{Use the smallest set of visual-outline views that explains the implementation. Name and order them based on the change. Do not include unused categories.}

{Short explanation.}

```diff
{A contract, type, component tree, file tree, call tree, control flow, or data flow. Use the language that best fits the content.}
```

## UI evidence

{For a user-interface change, include labeled before-and-after screenshots. Omit this section for non-UI changes. If screenshots would help but cannot be produced, explain why.}

## Files changed

[`path/to/file.ts`](path/to/file.ts) ({old count} → {new count} importers)

{Describe the change in one sentence of no more than 25 words. Omit importer counts when they are not relevant or cannot be verified.}

```diff
- previous public interface
+ new public interface
```

{Repeat for every changed file. Omit the interface block when no public interface changed.}

## Verification

- {List checks that actually ran and their results. Use "Not run" with a reason when applicable.}

{Omit the relevant-links line and UI evidence when they do not apply. Keep the other sections.}
