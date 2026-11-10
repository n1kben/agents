import SwiftSyntax

func noComments(_ tree: SourceFileSyntax) -> [Finding] {
    tree.tokens(viewMode: .sourceAccurate).flatMap { token in
        commentPositions(token.leadingTrivia, from: token.position)
            + commentPositions(token.trailingTrivia, from: token.endPositionBeforeTrailingTrivia)
    }.map {
        Finding(
            position: $0,
            rule: "no-comments",
            message: "Remove this comment. Make the code say it through names and types, or encode the rule in a check."
        )
    }
}

private func commentPositions(_ trivia: Trivia, from start: AbsolutePosition) -> [AbsolutePosition] {
    var position = start
    var found: [AbsolutePosition] = []
    for piece in trivia {
        switch piece {
        case .lineComment(let text) where text.hasPrefix("// swift-tools-version:"):
            break
        case .lineComment, .blockComment, .docLineComment, .docBlockComment:
            found.append(position)
        default:
            break
        }
        position += piece.sourceLength
    }
    return found
}
