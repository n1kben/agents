# Implementation Design

Prepare the code before changing it.

Every difficult change begins with an easier one.

## Preparatory refactoring

Separate behavior-preserving refactoring from behavior changes.

Introduce seams before replacing implementations.

Make the change easy, then make the easy change.

## Locality

Prefer local changes over shared changes.

Reduce the radius of change.

Favor WET over premature abstraction.

Follow AHA: Avoid Hasty Abstractions.

## Transformations

Prefer many small transformations over one large rewrite.

Each step should be easy to review, test and revert.

## Smells

- Shotgun surgery.
- Tight coupling.
- Premature abstraction.
- Mixed refactoring and behavior changes.
- Large irreversible changes.

Leave the code easier to change than you found it.
