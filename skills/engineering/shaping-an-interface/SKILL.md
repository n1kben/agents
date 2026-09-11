---
name: shaping-an-interface
description: A conversation-led workflow for designing a code boundary around its callers. Use when a function, type, module, component, service, or endpoint already needs an interface.
---

# Shaping An Interface

Start by asking what callers are trying to do. What is the normal case? Make that case clear and pleasant.

This skill begins once the boundary has a reason to exist. If the real question is whether multiple callers should share anything at all, settle that before designing the contract.

## Define the Contract

Choose the simplest interface that does the job. Give operations names that say what callers mean, and make inputs, outputs, and failures clear.

Keep the interface small, but expose what callers genuinely need. Hide details when doing so saves callers from understanding something difficult. If those details immediately return through getters, setters, or escape hatches, reconsider the boundary.

If real callers need advanced controls, keep the usual surface simple and separate the advanced surface. Do not add knobs for callers that do not exist.

## Sketch The Interface

When concrete syntax would expose problems, create a disposable file in the operating system's temporary directory using the project's language. Write the proposed interface with unimplemented bodies and write representative callers against it.

Use the sketch to test names, inputs, outputs, failures, and reading order. Typecheck it when that is cheap and useful. Do not add the scratch file to the repository or begin the real implementation before the user agrees.

## Make Misuse Difficult

Make impossible states impossible where practical. Parse, do not validate: turn raw input into program data at the boundary.

Make expected failures part of the contract. A broken invariant is a defect, not another expected result.

Keep incidental storage, framework, and service choices behind the interface. Ask for the narrow capability the operation needs rather than an entire environment.

## Check the Result

Ask:

- Is the normal call easy to read?
- Does each operation have one meaning?
- Can callers avoid knowing how the work is done?
- Are invalid states and expected failures clear?
- Can the implementation change without forcing unrelated caller changes?
- Can the important behavior be tested through the interface?

## Present the Interface

Present the caller's goal, proposed surface, inputs, outputs, failures, invariants, dependencies, and focused tests. State any assumptions and the strongest reason the interface may be wrong.

Do not edit code while the interface is still being discussed. Once the user agrees, implement only the agreed boundary and verify its callers.
