# Testing

Start with the behavior or risk that needs evidence. A test should increase confidence in something consequential. Exercising a function or raising a coverage number is not enough.

## Choose the seam

Test at the highest seam that remains fast, deterministic, and clear when it fails. Prefer a use case boundary such as a route, handler, command, screen, component, job, or public module interface.

Move lower when the higher seam makes an important case impractical or leaves failures too ambiguous. Do not add a lower-level test merely because an internal function exists.

Tests should survive behavior-preserving restructuring. A test may be coupled to implementation if renaming a helper, changing call order, or moving code breaks it.

## Build the evidence

Assert observable outcomes: returned values, expected failures, persisted state, emitted messages, rendered UI, or other effects visible through the chosen seam.

Take expected values from the specification, a worked example, or a literal fixture. Do not reproduce the production algorithm inside the test.

Use fakes for boundaries the test cannot reasonably control, such as external services, time, randomness, filesystems, or slow infrastructure. Keep internal collaborators real where practical. A fake should simplify the environment without reimplementing the behavior under test.

Cover invariants, bounds, retries, idempotency, races, partial failure, and impossible states in proportion to their risk. For visual behavior, make meaningful states directly inspectable with previews, stories, sandboxes, or deterministic fixtures.

## Check the result

Ask:

- Would this test fail for a meaningful defect?
- Does it assert behavior rather than internal choreography?
- Is the expected result independent of the production calculation?
- Are fakes confined to genuine system boundaries?
- Will the test remain useful after an internal refactor?
- Does the covered risk justify the test's maintenance cost?

When reviewing tests, report missing behavioral evidence and brittle coupling. Do not demand a testing style, layer, or count without connecting it to a concrete risk.
