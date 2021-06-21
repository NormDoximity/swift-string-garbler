import Foundation
import ArgumentParser

@available(OSX 10.15, *)
struct SSGCommand: ParsableCommand {

    @Option(name: .shortAndLong, help: "Path to alternative keys file (defaults to .env)")
    var environmentPath: String = ".env"

    @Option(name: .shortAndLong, help: "Path to variable checksum file")
    var checksumPath: String?

    @Flag(name: .shortAndLong, help: "Allows for prioritization of Alternative Keys before the Runtime Keys. When omitted, `false` is assumed.")
    var prioritizeAlternativeKeys: Bool = false

    @Argument(help: "path to generated file")
    var outputPath: String

    mutating func run() throws {
        let app = SwiftStringGarbler(
            environmentPath: environmentPath,
            checksumPath: checksumPath,
            outputPath: outputPath,
            prioritizeAlternativeKeys: prioritizeAlternativeKeys
        )

        try app.run()
    }
}

if #available(OSX 10.15, *) {
    SSGCommand.main()
} else {
    print("Update to a macos 10.15 or better")
    exit(1)
}
