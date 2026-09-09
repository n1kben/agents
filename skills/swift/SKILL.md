---
name: swift
description: Use when writing, changing, reviewing, or discussing Swift or SwiftUI code.
---

In Swift, make expected failures and required inputs part of the type signature.

If a function can fail in a way the caller is expected to handle, put that failure in the signature with typed throws. Prefer a small domain error enum over `any Error`, strings, or status codes. Translate framework, network, database, and SDK errors at the boundary before they reach the rest of the feature.

Use result type when failure needs to be stored, passed around, or composed as a value.

## SwiftUI

Pass app-defined view requirements explicitly. Never put app state, services, configuration, or capabilities in `@Environment` or `@EnvironmentObject`; pass them as initializer values, bindings, or closures. Use `@Environment` only for values and capabilities defined and supplied by SwiftUI or another Apple framework as part of its public API.

When you add or modify a view, include previews for the states that matter: loading, empty, loaded, error, disabled, long content, accessibility sizes, or constrained layouts when relevant. Keep previews deterministic. No network, persistence, clocks, or hidden setup.
