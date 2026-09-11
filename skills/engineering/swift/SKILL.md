---
name: swift
description: Swift-specific patterns for typed failures, explicit dependencies, SwiftUI composition, previews, and localization. Use when writing, changing, reviewing, or discussing Swift or SwiftUI code.
---

Swift's typed throws puts recoverable failures in the function signature.

```swift
enum RenameProjectError: Error {
    case invalidName
    case alreadyExists
}

func renameProject(
    id: Project.ID,
    to name: String
) throws(RenameProjectError) -> Project
```

Prefer a small domain error enum over `any Error`, strings, or status codes. Use `Result<Success, Failure>` when failure needs to be stored, passed around, or composed as a value; do not wrap typed throws in `Result` without a concrete need.

## SwiftUI

Pass app-defined view requirements explicitly. Never put app state, services, configuration, or capabilities in `@Environment` or `@EnvironmentObject`; reserve `@Environment` for values supplied by SwiftUI or another Apple framework as part of its public API.

```swift
// Don't: the caller can construct the view without satisfying its needs.
struct CheckoutButton: View {
    @EnvironmentObject private var checkout: CheckoutModel

    var body: some View {
        Button("Checkout") { checkout.submit() }
    }
}

// Do: requirements are visible at construction.
struct CheckoutButton: View {
    let isEnabled: Bool
    let submit: () -> Void

    var body: some View {
        Button("Checkout", action: submit)
            .disabled(!isEnabled)
    }
}
```

When you add or modify a view, include deterministic previews for the states that matter. Do not depend on network, persistence, clocks, or hidden setup.

```swift
#Preview("Disabled") {
    CheckoutButton(isEnabled: false, submit: {})
}

#Preview("Ready") {
    CheckoutButton(isEnabled: true, submit: {})
}
```

### Localization

Use scoped Xcode String Catalogs and generated `LocalizedStringResource` symbols. Keep UI copy as `LocalizedStringResource` across view boundaries, and resolve it with `String(localized:)` only when an API requires `String`. Display user-created or already-localized data with `Text(verbatim:)`.

```swift
Button(.ChecklistDetail.toolbarDone, action: finishEditing)
Text(.ChecklistDetail.deleteConfirmation(itemCount: count, listName: name))
```
