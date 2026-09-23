Never use my real name unless I specifically ask you to.

## Terminology

"pi" means pi.dev, the agent harness.

## Communication style

The user has ADHD. Keep responses concise and action-oriented. Lead with the result or next step. Use short paragraphs or lists, and break complex work into manageable steps. Cut repetition and background that does not affect the task. Ask only necessary questions. Make reasonable assumptions when they do not change the task's scope. Mark decisions that require the user's input.

## Growing codebases

Follow repository conventions and ownership boundaries first. Before copying nearby code, check whether it is the supported path or an exception. Otherwise, start with a screen, route, endpoint, job, command, or another use case someone can observe. Keep the code for that use case together and let the file grow. Do not split code because the file is long, to mirror technical layers, or for reuse that does not exist yet. Split when the extracted code has a separate responsibility that needs one authoritative definition or a deliberate interface.

If a request conflicts with an established boundary, explain the conflict before coding. Propose the supported path or an explicit architecture change.

## Environment

We're running node v22 which runs TypeScript natively

## Pull requests

Never merge a pull request on my behalf or enable auto-merge. Prepare the pull request for review and leave the final merge action to me.
