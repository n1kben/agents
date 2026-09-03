# Designing Interfaces

## Simple And Advanced Interfaces

**Make the common path obvious and difficult to misuse.**

Design a simple interface for the overwhelming majority of callers. Require few decisions, choose strong defaults, and make invalid combinations difficult or impossible to express.

Provide a separate advanced interface for callers that genuinely need more control.

Implement the simple interface in terms of the advanced one so both paths share the same semantics:

```ts
function sendEmail(message: Message): Promise<void> {
  return sendEmailAdvanced({
    message,
    retryPolicy: defaultRetryPolicy,
    deliveryMode: "immediate",
  });
}

function sendEmailAdvanced(options: SendEmailOptions): Promise<void> {
  // Complete implementation.
}
```

Do not make every caller confront the advanced interface through a large options object. Optional parameters are not a simple interface when callers must understand them to feel confident using it.

Keep the distinction visible in naming and documentation. Optimize the simple interface for clarity and safety. Optimize the advanced interface for capability and precision.

The advanced interface is an escape hatch, not the default teaching surface.

This is one concept with one implementation, not an abstraction over merely similar behaviors. If the simple and advanced paths need different semantics or may evolve independently, keep them separate instead of forcing them behind one interface.

**Do not make everyone pay the complexity cost required by the most demanding callers.**
