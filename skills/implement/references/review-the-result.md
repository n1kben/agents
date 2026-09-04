# Review The Result

Inspect the finished implementation.

- **Local boundary**: some code carries substantial facts, states, effects, protocols, or decisions that its caller should not need to understand. → suggest a semantic boundary when it removes more knowledge than its new name and indirection add; reuse is not required.

- **Rule of Three**: the same behavior now has three concrete occurrences. → point out the coupling candidate; suggest sharing when the occurrences have one identity, one invariant, and one reason to change.

Report suggestions in chat. Name the evidence and explain why the change would help.

Never apply the suggestions. If nothing has earned a recommendation, say so.
