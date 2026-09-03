# SwiftUI

Make every view's requirements explicit in its type and every meaningful UI state directly inspectable in Xcode previews.

## Rules

| Rule | Guidance |
| --- | --- |
| No hidden environment dependencies | Do not use `@Environment` or `@EnvironmentObject` for application state, services, configuration, or capabilities. Pass requirements explicitly. |
| Previews | Give every changed view or screen a `#Preview` covering its meaningful states with deterministic inputs. |

## No hidden environment dependencies

Do not use `@Environment` or `@EnvironmentObject` to supply application state, services, configuration, or capabilities. They are hidden inputs: the view's type and initializer do not reveal what it requires, and a missing or incorrect value is discovered only after composition.

Pass requirements explicitly as values and closures:

```swift
struct ProfileView: View {
    let state: ProfileState
    let retry: () -> Void

    var body: some View {
        // Render only from explicit inputs.
    }
}
```

Read shared state and perform effects in the owning container, then pass the smallest value or capability the child needs. This keeps construction, previews, and tests complete in the type system.

When a framework-owned environment value is unavoidable, isolate the `@Environment` read in a thin adapter at the composition boundary and pass an ordinary typed value or closure into feature views. Do not let environment access spread through the view tree.

## Previews

Every SwiftUI view added or changed must have a `#Preview`, or the repository's equivalent preview mechanism. Add previews for each meaningful state instead of requiring a precise sequence of navigation or persisted data to reach it.

```swift
#Preview("Loaded") {
    ProfileView(state: .loaded(.fixture), retry: {})
}

#Preview("Error") {
    ProfileView(state: .error(.offline), retry: {})
}
```

Preview the production view with small deterministic fixtures. Pass state and actions explicitly; keep network access, persistence, clocks, and other ambient dependencies outside the view. Include loading, empty, populated, error, disabled, accessibility, long-content, and constrained-layout variants when relevant.

Previews supplement tests and verification in the running application; they do not replace them.
