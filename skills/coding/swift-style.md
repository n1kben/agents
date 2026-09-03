# Swift

Use Swift's type system to expose the failures a caller is expected to handle.

## Rules

| Rule | Guidance |
| --- | --- |
| Typed throws | Put expected failures in the signature with `throws(ErrorType)`. Use domain error enums and translate untyped dependency failures at the boundary. |

## Typed throws

Use typed throws for expected failures. The concrete error type belongs in the function signature, so callers can discover and exhaustively handle every domain failure.

```swift
enum LoadUserError: Error {
    case notFound(UserID)
    case offline
    case invalidResponse
}

protocol UserLoading {
    func loadUser(id: UserID) async throws(LoadUserError) -> User
}
```

Prefer a domain error enum with associated values over strings or a generic `Error`. Catch APIs that throw `any Error` at the boundary and translate expected cases. Reserve traps and untyped failures for defects and genuinely unrecoverable invariants.

Use `Result<Success, Failure>` when failure must be stored, passed around as a value, or composed with APIs that operate on results. Do not wrap typed throws in `Result` without a concrete need.
