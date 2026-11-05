# Swift rules

Apply to `.swift` source.

- No `@env` or `@Environment` property wrapper.
- No untyped `throws`; declare a concrete error type with `throws(ErrorType)`, including for `async throws` functions.
