---
name: shaping-an-api
description: Design or change a contract between code and its callers. Use once the boundary has a reason to exist. Covers coordinated changes and compatibility when callers update separately.
disable-model-invocation: true
---

# Shaping an API

Start with the callers. Write the normal call first.

This skill begins once the boundary has a reason to exist. If the question is whether several callers should share code, use `shaping-an-abstraction` first.

## Set the change constraints

List the callers and determine how each one receives changes.

If the provider and every caller can change together, choose the clearest API. Update all callers and remove the old API in the same change.

If callers update independently, preserve the existing contract during rollout. Account for external consumers, separate deployments, stored messages, cached responses, and generated clients. Prefer additive changes. For a breaking change, define the migration and removal conditions before choosing the new API.

## Define the contract

Choose the simplest API that does the job. Give operations names that say what callers mean. Make inputs, outputs, and failures clear.

Keep the API small, but expose what callers need. Hide details that every caller would otherwise need to handle. If those details return through getters, setters, or escape hatches, reconsider the boundary.

If real callers need advanced controls, keep the normal call simple and separate the advanced operations. Do not add options for callers that do not exist.

## Sketch the API

When names, types, or message shapes need testing, create a disposable file in the operating system's temporary directory. Use the project's language or protocol. Write the proposed API with unimplemented bodies or example messages, then write representative callers against it.

Use the sketch to test names, inputs, outputs, failures, and reading order. Typecheck it or validate its schema when that is useful. Do not add the file to the repository or begin the implementation before the user agrees.

## Make misuse difficult

Represent valid states directly when the language allows it. Parse raw input into program data at the boundary instead of checking it throughout the code.

Make expected failures part of the API. A broken invariant is a defect, not another expected result.

Keep storage, framework, and service choices behind the API unless callers need to control them. Ask for the narrow dependency an operation needs rather than an entire environment.

## Check compatibility

Judge compatibility against existing consumers, not only the API schema.

Adding a field works when consumers ignore unknown fields. It breaks consumers that reject them. Adding an enum case can break exhaustive matches. Changing a collection from an array to an object breaks consumers that expect an array.

Inspect or test how consumers read the API before classifying a change.

## Check the result

Ask:

- Is the normal call easy to read?
- Does each operation have one meaning?
- Can callers avoid knowing how the work is done?
- Are invalid states and expected failures clear?
- Can the implementation change without forcing unrelated caller changes?
- Does the API fit the way its callers receive changes?
- Can the important behavior be tested through the API?

## Verify the change

For a coordinated change, update and check every caller before removing the old API.

For an independently deployed API, test each producer and consumer version that can run together during the rollout. Include stored requests, events, or responses when newer code may read older data.

## Present the API

Present the caller's goal, proposed API, inputs, outputs, failures, invariants, dependencies, compatibility constraints, and focused tests. State any assumptions and the strongest reason the API may be wrong.

Do not edit code while the API is still being discussed. Once the user agrees, implement only the agreed API and verify its callers.
