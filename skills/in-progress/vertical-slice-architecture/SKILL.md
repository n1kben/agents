---
name: vertical-slice-architecture
description: Organize code by use case instead of technical layer. Use when adding feature code, deciding where code belongs, feeling pressure to abstract or share code, splitting services, or reducing coupling.
---

# Vertical Slice Architecture

Design for requirements change. Requirements change every week; databases, frameworks, and libraries change far less often.

When writing feature code, default to a vertical slice. Put the code in the use case first; extract only when shared meaning is proven.

Organize by use case, not technical responsibility. A feature should hold the code that delivers it: UI, request, handler, validation, data access, messages, tests, and preview where needed.

Prefer low coupling and high cohesion. Things that change together should live together; unrelated features should not know about each other.

Do not start by sharing code. Copy first, keep code local, and let shared meaning prove itself over time.

Similar code is not shared code. Code is shareable only when it has the same behavior, same inputs, same outputs, and one reason to change.

Avoid service dumping grounds. Do not create `UserService`, `BillingService`, or `RepairService` as broad homes for related methods; create focused handlers, requests, functions, or domain objects.

Build each slice in the shape it needs. A simple CRUD slice can be simple; a complex workflow can have richer modeling; do not force every feature through the same layers.

Contain hacks and customer-specific behavior. If commercial pressure creates ugly code, keep it inside one slice instead of leaking it through shared services.

Version by adding a slice beside the old one. Build V2 next to V1, route between them, then delete the old folder when it is dead.

Use CQRS/request-handler style when it helps. Commands, queries, requests, and handlers fit slices well, but they are tools, not the architecture.

Share domain model deliberately. Business rules and domain concepts are good coupling when they represent real shared business meaning.

Prefer deletion over surgery. A good slice can be removed by deleting its folder, not by untangling calls across the whole system.
