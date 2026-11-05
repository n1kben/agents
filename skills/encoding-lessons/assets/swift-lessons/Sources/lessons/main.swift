import Foundation
import SwiftParser
import SwiftSyntax

struct Finding {
    let position: AbsolutePosition
    let rule: String
    let message: String
}

let rules: [(SourceFileSyntax) -> [Finding]] = [
    noComments,
    noEnvironment,
    noUntypedThrows,
]

func swiftFiles(under path: String) -> [String] {
    var isDirectory: ObjCBool = false
    guard FileManager.default.fileExists(atPath: path, isDirectory: &isDirectory) else { return [] }
    guard isDirectory.boolValue else { return path.hasSuffix(".swift") ? [path] : [] }
    let url = URL(fileURLWithPath: path)
    let enumerator = FileManager.default.enumerator(
        at: url,
        includingPropertiesForKeys: nil,
        options: [.skipsHiddenFiles, .skipsPackageDescendants]
    )
    var files: [String] = []
    while let file = enumerator?.nextObject() as? URL {
        if file.pathExtension == "swift" { files.append(file.path) }
    }
    return files.sorted()
}

let arguments = Array(CommandLine.arguments.dropFirst())
let files = (arguments.isEmpty ? ["."] : arguments).flatMap(swiftFiles(under:))
var count = 0

for file in files {
    guard let source = try? String(contentsOfFile: file, encoding: .utf8) else {
        print("\(file): error: can't read file [lessons]")
        count += 1
        continue
    }
    let tree = Parser.parse(source: source)
    let converter = SourceLocationConverter(fileName: file, tree: tree)
    for finding in rules.flatMap({ $0(tree) }) {
        let location = converter.location(for: finding.position)
        print("\(file):\(location.line):\(location.column): error: \(finding.message) [\(finding.rule)]")
        count += 1
    }
}

exit(count == 0 ? 0 : 1)
