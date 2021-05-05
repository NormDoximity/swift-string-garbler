import Foundation
import ArgumentParser

@available(OSX 10.15, *)
struct SSGCommand: ParsableCommand {

    @Option(name: .shortAndLong, help: "Path to alternative keys file (defaults to .env)")
    var environmentPath: String?

    @Option(name: .shortAndLong, help: "Path to variable checksum file")
    var checksumPath: String?

    @Option(name: .shortAndLong, help: "Path to custom output template")
    var templatePath: String?

    @Flag(name: .shortAndLong, help: "Verbose reporting")
    var verbose: Bool = false

    @Argument(help: "path to generated file")
    var outputPath: String

    mutating func run() throws {
        let pathConfig = PathConfig(
            environmentPath: environmentPath ?? ".env",
            checksumPath: checksumPath,
            outputPath: outputPath,
            templatePath: templatePath
        )
        let app = SwiftStringGarbler(
            pathConfig: pathConfig,
            userFlags: UserFlags(isVerbose: verbose)
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
