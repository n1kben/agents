# Sharing Style

Default to zero sharing between use cases. Keep code local until shared meaning is proven.

Share duplicated knowledge, not similar-looking code. Share only when behavior, input, output, and reason-to-change are genuinely the same.

Use the rule of three. On the third repetition, point out the possible abstraction; do not write it unless the user asks for abstraction work.

Avoid the wrong abstraction. Do not pass booleans, modes, flags, or optional callbacks to make shared code serve different use cases; that is divergent behavior hiding inside one abstraction.

Share domain concepts deliberately. A domain model is good coupling when it represents real shared business meaning and changes because the business changes.

Avoid dumping grounds. Do not create broad `UserService`, `BillingService`, `Repository`, `Common`, or `Utils` homes; prefer focused handlers, functions, requests, or domain objects.
