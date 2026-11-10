import SwiftSyntax

func noEnvironment(_ tree: SourceFileSyntax) -> [Finding] {
    let visitor = EnvironmentVisitor(viewMode: .sourceAccurate)
    visitor.walk(tree)
    return visitor.findings
}

private final class EnvironmentVisitor: SyntaxVisitor {
    var findings: [Finding] = []

    override func visit(_ node: AttributeSyntax) -> SyntaxVisitorContinueKind {
        if attributeName(node.attributeName).hasPrefix("Environment") {
            findings.append(Finding(
                position: node.positionAfterSkippingLeadingTrivia,
                rule: "no-environment",
                message: "Don't use @Environment. Pass the dependency in explicitly."
            ))
        }
        return .visitChildren
    }
}

private func attributeName(_ type: TypeSyntax) -> String {
    if let member = type.as(MemberTypeSyntax.self) { return member.name.text }
    if let identifier = type.as(IdentifierTypeSyntax.self) { return identifier.name.text }
    return type.trimmedDescription
}
