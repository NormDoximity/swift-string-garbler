import Foundation
import ArgumentParser

struct SSGCommand: ParsableCommand {

    @Option(name: .shortAndLong, help: "Path to alternative keys file (defaults to .env)")
    var environmentPath: String?

    @Option(name: .shortAndLong, help: "Path to variable checksum file")
    var checksumPath: String?

    @Argument(help: "path to generated file")
    var outputPath: String

    mutating func run() throws {
        let app = SwiftStringGarbler(
            environmentPath: environmentPath ?? ".env",
            checksumPath: checksumPath,
            outputPath: outputPath
        )

        try app.run()
    }
}

SSGCommand.main()
