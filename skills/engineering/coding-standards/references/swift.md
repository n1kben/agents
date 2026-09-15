# Swift

Typed throws put recoverable failures in the function signature.

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

Prefer a small domain error enum over `any Error`, strings, or status codes. Use `Result<Success, Failure>` when code needs to store, pass, or compose a failure as a value. Do not wrap typed throws in `Result` without a concrete need.

## SwiftUI

Pass app-defined view requirements explicitly. Do not put app state, services, configuration, or capabilities in `@Environment` or `@EnvironmentObject`. Reserve `@Environment` for values that SwiftUI or another Apple framework supplies through its public API.

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

When you add or modify a view, include deterministic previews for its distinct states. Previews must not depend on the network, persistence, clocks, or setup outside the preview.

```swift
#Preview("Disabled") {
    CheckoutButton(isEnabled: false, submit: {})
}

#Preview("Ready") {
    CheckoutButton(isEnabled: true, submit: {})
}
```

### Localization

Use scoped Xcode String Catalogs and generated `LocalizedStringResource` symbols. Pass UI copy between views as `LocalizedStringResource`. Call `String(localized:)` only when an API requires `String`. Display user-created or already localized data with `Text(verbatim:)`.

```swift
Button(.ChecklistDetail.toolbarDone, action: finishEditing)
Text(.ChecklistDetail.deleteConfirmation(itemCount: count, listName: name))
```
