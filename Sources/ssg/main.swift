import Foundation
import ArgumentParser

@available(OSX 10.15, *)
struct SSGCommand: ParsableCommand {

    @Option(name: .shortAndLong, help: "Path to alternative keys file (defaults to .env).")
    var environmentPath: String = ".env"

    @Option(name: .shortAndLong, help: "Path to variable checksum file.")
    var checksumPath: String?

    @Option(name: .shortAndLong, help: "Path to custom output template.")
    var templatePath: String?

    @Flag(name: .shortAndLong, help: "Enable verbose reporting.")
    var verbose = false
    
    @Flag(name: .shortAndLong, help: "Prefer using alternative keys to keys found in runtime environment.")
    var prioritizeAlternativeKeys: Bool = false

    @Argument(help: "Path to generated file.")
    var outputPath: String

    mutating func run() throws {
        let pathConfig = PathConfig(
            environmentPath: environmentPath,
            checksumPath: checksumPath,
            outputPath: outputPath,
            templatePath: templatePath
        )
        let app = SwiftStringGarbler(
            pathConfig: pathConfig,
            userFlags: UserFlags(
                isVerbose: verbose,
                prioritizeAlternativeKeys: prioritizeAlternativeKeys
            )
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
