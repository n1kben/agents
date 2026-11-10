import SwiftSyntax

func noUntypedThrows(_ tree: SourceFileSyntax) -> [Finding] {
    let visitor = ThrowsVisitor(viewMode: .sourceAccurate)
    visitor.walk(tree)
    return visitor.findings
}

private final class ThrowsVisitor: SyntaxVisitor {
    var findings: [Finding] = []

    override func visit(_ node: ThrowsClauseSyntax) -> SyntaxVisitorContinueKind {
        if node.throwsSpecifier.tokenKind == .keyword(.throws), node.type == nil {
            findings.append(Finding(
                position: node.positionAfterSkippingLeadingTrivia,
                rule: "no-untyped-throws",
                message: "Declare a concrete error type with throws(ErrorType)."
            ))
        }
        return .visitChildren
    }
}
