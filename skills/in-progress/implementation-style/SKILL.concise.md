---
name: implementation-style
description: Implementation style. Use when writing or checking implementation code.
disable-model-invocation: true
---

Avoid sharing code, prefer copying over sharing. Abstraction and sharing is a separate process. It is discovered, not guessed.

Data that is flowing through the system must be represented in the typesystem. Throws and context/env inj is not allowed unless the typesystem support it, eg Swift typed throws or unison algebraic effects. Use DI instead or returning result values.

Always create stories, sandboxes or previews for visual code.
