---
name: visual-pr
description: Use only when explicitly invoked as $visual-pr to draft, create, or update a pull request with a concise visual description.
disable-model-invocation: true
---

# Visual PR

Read the repository's `AGENTS.md` and pull request template. Check for an existing pull request with `gh pr view`. Read the full diff against its base, relevant code, linked work, and verification. If there is no pull request, inspect the branch, working tree, and commits.

Write a description that shows why the change exists, what changed, and where a reviewer should look. Replace this example with facts from the branch, add any repository-required sections, and remove the comments before publishing:

````md
<!-- Use only verified facts. Leave out unrelated working-tree changes. -->
<!-- Omit when there are no relevant links. -->
[Issue #42](https://github.com/example/repo/issues/42)

## Why the change

<!-- One sentence. -->
The editor accepts another save while a request is pending, so this change prevents duplicate submissions.

## Special things to note

<!-- One to three bullets. Use "- None." when there is nothing to note. -->
- None.

<!-- Describe observable changes to workflows, commands, jobs, or other use cases. Omit when there are none. -->
## Use-case changes

- Saving a draft now prevents another submission until the current request finishes.

<!-- For each new or changed endpoint, show a compact diff of its public contract: method/path, parameters, request/response fields, status, or errors as applicable. Show only what changed, not implementation code. Omit this section when no endpoints changed. -->
## API endpoint interfaces

```diff
POST /drafts
-Request: { content: string }
+Request: { content: string, idempotencyKey: string }
```

<!-- Omit for non-UI changes. Explain when useful screenshots cannot be produced. -->
## UI evidence

Before: ![Save button while a request is pending](screenshots/save-before.png)
After: ![Disabled Save button while a request is pending](screenshots/save-after.png)

## Module changes

<!-- Repeat for every changed module or file. Keep each description to one sentence of at most 25 words. -->
[`src/Editor.tsx`](src/Editor.tsx)

Disables Save while the request is pending.

[`src/api/saveDraft.ts`](src/api/saveDraft.ts)

Updates the module's exported draft-saving function to require an idempotency key.

<!-- Directly below each relevant module, show exact base-to-head declaration diffs for its exported module interface, including exports used only by other files in the app. In TypeScript, use exported declarations; in Elm, use names in the module's exposing list. Show parameters, return types, and exposed record fields that changed. Omit unexported helpers and private member signatures. Endpoint contracts belong in the API endpoint interfaces section. Do not show call stacks, component trees, or implementation pseudocode. Modules without an exported interface change need only the description. -->
Exported module interface:

```diff
-export function saveDraft(content: string): Promise<Draft>;
+export function saveDraft(content: string, idempotencyKey: string): Promise<Draft>;
```

## Verification

<!-- List checks that actually ran. Use "Not run" with a reason when needed. -->
- `npm test` passed.
````
