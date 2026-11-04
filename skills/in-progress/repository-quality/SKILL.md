---
name: repository-quality
description: Inspect a repository's quality infrastructure and suggest improvements.
disable-model-invocation: true
---

# Repository Quality

Inspect the repository's existing quality infrastructure and look for opportunities to improve it.

1. Inspect linting, formatting, type checking, tests, verification, formal verification and CI.
2. Check whether existing tools are configured correctly, working and actually used.
3. Identify meaningful gaps and opportunities to improve existing infrastructure.
4. Prefer simple, automated checks that catch real problems.
5. Reuse shared configurations and conventions where available.
6. Add project-specific verification capabilities where useful, so agents can launch, drive and inspect the application independently.
7. Consider formal verification for complex state machines, concurrency, retries and critical invariants.
8. Ensure checks have simple, documented commands and run automatically in CI where appropriate.

Do not introduce tooling just to satisfy a checklist. Prioritize improvements according to their actual value.
