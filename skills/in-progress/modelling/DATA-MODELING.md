# Data Modeling

Preserve information.

Data outlives software. Requirements change. Questions change. Preserve facts so tomorrow's questions can still be answered.

## Don't complect

Separate identity, state and time.

Model each independently instead of combining unrelated concerns into one representation.

Separate facts that change independently.

## Decompose facts

Model independent facts independently.

Avoid values that combine multiple dimensions into one representation. When parts can change independently, they probably represent different facts.

Prefer the smallest meaningful facts. Derive larger concepts from smaller ones whenever practical.

## Facts over interpretations

Store observations before conclusions.

Prefer deriving knowledge over storing duplicated interpretations.

Preserve history when it matters.

## Values

Prefer immutable values.

Model uncertainty explicitly instead of hiding it behind defaults.

Represent absence as a first-class concept instead of inventing sentinel values.

## Evolution

Prefer additive evolution.

Avoid destructive changes that lose information.

Derive whenever practical. Duplicate only with a clear owner responsible for consistency.

## Smells

- Information loss.
- Hidden time.
- Mutable shared state.
- Overloaded fields.
- Composite values hiding multiple facts.
- Duplication instead of derivation.
- Encoding meaning into strings.

Facts age well. Interpretations don't.
