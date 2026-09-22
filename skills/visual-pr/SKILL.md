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
- Save remains disabled until the request finishes.

<!-- Omit for non-UI changes. Explain when useful screenshots cannot be produced. -->
## UI evidence

Before: ![Save button while a request is pending](screenshots/save-before.png)
After: ![Disabled Save button while a request is pending](screenshots/save-after.png)

## Files changed

<!-- Show the smallest useful file tree, call tree, component tree, or pseudocode here. Use a diff when before and after clarify the change. -->
Save flow:

```diff
 Editor.onSave
-  saveDraft()
+  setPending(true)
+  try
+    await saveDraft()
+  finally
+    setPending(false)
```

Component tree:

```diff
 <Editor>
-  <SaveButton />
+  <SaveButton disabled={pending} />
 </Editor>
```

<!-- Repeat for every changed file. Keep each description to one sentence of at most 25 words. Omit importer counts when they do not help. -->
[`src/Editor.tsx`](src/Editor.tsx) (2 → 3 importers)

Disables Save while the request is pending and updates the callback contract.

<!-- Show the exact declaration diff from the base and head when a change affects callers, even if the props type is not exported. Omit internal-only type changes. -->
```diff
 type EditorProps = {
-  onSave: () => void;
+  onSave: () => Promise<void>;
 };
```

## Verification

<!-- List checks that actually ran. Use "Not run" with a reason when needed. -->
- `npm test` passed.
````
