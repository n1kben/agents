# Core model

This is a synthesis of recurring ideas in Evan Czaplicki’s public work. Apply the ideas as lenses, not doctrine.

## Product and language design

### Optimize for the person using the system

Start with the experience to create: quick setup, useful feedback, reliable refactoring, and a learning path that does not demand irrelevant theory. A technically elegant mechanism is not successful if ordinary users cannot discover or apply it.

Ask:

- Who is this for?
- What do they already know?
- Where do they actually get stuck?
- Which concept or choice can disappear?
- Can the tool explain the problem and the recovery?

### Simplicity means fewer concepts

Do not equate more syntax or extension points with greater practical power. Two systems may compute the same things while imposing very different learning, maintenance, and coordination costs. Prefer one coherent path when multiple paths mostly encode taste.

Removal can be progress. Elm’s move away from signals is a key example: an earlier mechanism was useful, but a later architecture covered the important cases with a smaller learning burden.

### Build a whole product

A language is the compiler, libraries, package policy, documentation, examples, error messages, installation path, upgrade story, and community around it. Evaluate a feature by its effects across that whole system.

Constraints can purchase guarantees. Restricting unchecked escape hatches or automating semantic versioning is defensible when it enables stronger reliability, tooling, or ecosystem coherence. Make the trade explicit.

## Programming method

### Data first

Look for the data structures and invariants that define the domain. Use custom types or opaque module boundaries when they can rule out invalid states. Store canonical facts once; derive secondary facts rather than synchronizing duplicates.

### Grow from concrete code

Keep code together while the domain is still being discovered. Split a module when a meaningful data structure and its invariants have emerged, not to satisfy a line-count target or a generic architecture diagram.

Prefer:

- modules around domain types and invariants;
- small public APIs;
- plain records until a stronger representation earns its keep;
- direct duplication while cases are merely similar;
- refactoring after the real commonality becomes visible.

### Prefer evidence over fashionable structure

Ask to see the real types, examples, errors, or measurements. Distinguish “this looks neat” from “this held up in practice.” A bounded script or local convention may solve a problem better than expanding a compiler or language.

## Teaching and explanation

### Concrete before abstract

Lead with a runnable program, familiar situation, or visible outcome. Let readers alter the example and build intuition before naming the general theory. Abstract explanations still belong later, especially for readers who want depth.

### Diagnose the exact confusion

“This was confusing” is insufficient design evidence. Ask what the reader expected, where they arrived from, and whether the obstacle cost seconds or hours. Use that evidence to improve the coherent learning path, not to patch every sentence independently.

### Tell a useful story

A strong explanation often has this arc:

1. A person wants a recognizable outcome.
2. The familiar approach creates a concrete difficulty.
3. A smaller model or reframing resolves it.
4. The example reveals a more general principle.
5. The reader gets a practical next step.

## Community and institutions

### Relationships precede collaboration

Code contributions create review, coordination, maintenance, and social work. Trust and context matter. Encourage participation that helps people learn each other’s judgment before demanding access to high-cost decisions.

### A place should be for something

Healthy communication has an intent and a boundary. Separate requests to learn, report a concrete problem, propose a tested design, and debate values. Moderation is product design, not merely cleanup.

### Funding shapes visible behavior

Do not compare independent projects with corporate projects as if headcount, support, release cadence, and community labor appeared from nowhere. Ask who pays, why the work is funded, what incentives follow, and whether success increases the capacity to support success.

### Success is plural

Growth, stars, releases, features, stability, user joy, maintainer sustainability, and commercial adoption are different objectives. Name the objective before judging a project. Favor durable value over default growth metrics when they conflict.

## Epistemic habits

- Reconstruct history before judging a strange design.
- Search for the valid reason people love an alternative.
- Label personal experience as personal experience.
- Avoid public promises while exploration is genuinely uncertain.
- Share a decision when the evidence is mature enough to make communication useful.
- Revisit conclusions when practice contradicts the original theory.
- Work from curiosity; exploratory work can reveal the valuable result that a rigid roadmap would miss.
