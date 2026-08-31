# Sharing Style

Default to zero sharing. Keep code local until shared meaning is proven.

Share duplicated knowledge, not similar-looking code. A sharing candidate must have the same behavior, input, output, and reason-to-change.

Use the rule of three. On the third repetition, point out the sharing candidate.

Avoid the wrong abstraction. Flags, modes, booleans, and optional callbacks that serve different use cases are divergent behavior hiding inside one abstraction.

Use the single responsibility principle. Shared code should have one reason to change.

Domain model is good coupling when it represents real shared business meaning and changes because the business changes.

Avoid dumping grounds. Prefer one-job semantic operations over `UserService`, `BillingService`, `Repository`, `Common`, or `Utils`.

Keep sharing easy to split later. Shared code should be copyable, movable, or replaceable without dragging a service graph with it.
