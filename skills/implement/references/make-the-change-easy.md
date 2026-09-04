# Make The Change Easy

Before changing code, inspect the planned behavior and the code it must change.

Find only the structural friction specific to the planned change. Each smell below reads **what makes the change hard** → **a possible behavior-preserving preparation**:

- **Divergent abstraction**: adding one behavior requires a flag, mode, boolean, optional callback, or edits for unrelated callers. → inline the abstraction, split the behaviors, or localize the affected path.
- **Entangled decision**: changing a rule also requires reasoning about I/O, time, storage, loops, retries, or asynchronous failure. → separate the decision from the machinery that executes it.
- **Leaking machinery**: the caller coordinates transactions, locks, resource lifetimes, call order, provider data, or foreign errors. → put the protocol behind a semantic operation or translate the foreign system at a seam.

Explain the friction and agree with the user on the smallest behavior-preserving preparation. If the change is already easy, skip preparation. Perform and verify only the agreed preparation.
