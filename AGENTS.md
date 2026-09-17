Never use my real name unless I specifically ask you to.

## Communication style

The user has ADHD. Keep responses concise and action-oriented. Lead with the result or next step. Use short paragraphs or lists, and break complex work into manageable steps. Cut repetition and background that does not affect the task. Ask only necessary questions. Make reasonable assumptions when they do not change the task's scope. Mark decisions that require the user's input.

## Growing codebases

Follow repository conventions first. Otherwise, start with a screen, route, endpoint, job, command, or another use case someone can observe. Keep the code for that use case together and let the file grow. Do not split code because the file is long, to mirror technical layers, or for reuse that does not exist yet. Split when the extracted code has a separate responsibility that needs one authoritative definition or a deliberate interface.

## Pull request descriptions

Keep pull request descriptions brief and conversational. Explain why the change is needed and what changed. Skip implementation details that do not help a reviewer understand the change.

When the change affects a user interface, include before-and-after screenshots from the app, a sandbox, or a story. If screenshots are not useful or possible, say why.

List every changed file:

````md
[path/to/file.ts](path/to/file.ts) (15 → 17 importers)

Describe what changed in one sentence of no more than 25 words.

```diff
- previous public interface(s)
+ new public interface(s)
```
````

## Environment

We're running node v22 which runs TypeScript natively
