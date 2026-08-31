# Coupling Style

Default to zero file/module coupling between use cases. Keep code local until shared meaning is proven.

Share duplicated knowledge, not similar-looking code. A coupling candidate must have the same behavior, input, output, and single responsibility: one reason to change.

Use the rule of three. On the third repetition, point out the coupling candidate.

Avoid the wrong abstraction. Flags, modes, booleans, and optional callbacks that serve different use cases are divergent behavior hiding inside one module.

Domain model is good coupling when it represents real shared business meaning and changes because the business changes.

Avoid dumping grounds. Prefer one-job semantic operations over `UserService`, `BillingService`, `Repository`, `Common`, or `Utils`.

Avoid deep coupling. Shared code should be copyable, movable, or replaceable without dragging a service graph, hidden dependencies, or unrelated reasons to change.
