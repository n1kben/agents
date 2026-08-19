# Test Design

Design for confidence.

Tests are part of the design, not an afterthought. Good test design provides fast, trustworthy feedback while enabling change. Optimize for confidence per unit of maintenance, not coverage or test count.

## Behavior over implementation

Test externally observable behavior instead of implementation details.

Prefer black-box tests whenever practical. Refactoring should rarely require changing tests.

## Test at the highest seam

Test at the highest level that provides fast, deterministic feedback.

Favor meaningful integration and end-to-end tests over large numbers of implementation-coupled unit tests.

Move lower only when higher-level tests become slow, brittle or ambiguous.

## Design for testability

Good design is naturally testable.

Prefer explicit dependencies, seams, deterministic behavior and pure functions. Introduce seams before introducing mocks.

## Characterize before changing

When modifying unfamiliar code, capture its current behavior first.

Characterization tests reduce risk and enable safe refactoring.

## Fast feedback

Prefer deterministic, isolated and reliable tests.

Aggressively eliminate flakiness. A slow or unreliable test suite eventually stops being trusted.

## Smells

- Testing implementation instead of behavior.
- Excessive mocking.
- Flaky tests.
- Slow feedback loops.
- Brittle tests coupled to internal structure.
- High coverage with low confidence.
- Tests that rarely fail when behavior is broken.

A test is valuable only if it increases confidence.
