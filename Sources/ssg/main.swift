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

    @Option(name: .long, help: "Runtime environment identifying environment variable.")
    var environmentId: String?

    @Option(
        name: .customShort(Character("r")),
            parsing: .upToNextOption,
        help: ArgumentHelp(
            "",
            discussion: "Space separated list of variable names which must be found in the build environment\nNote: requires --environment-id",
            valueName: "key1 key2 key3",
            shouldDisplay: true)
    )
    var envRequired: [String] = []

    @Flag(name: .long, help: "Require all values be defined in the runtime environment when running in the build environment.")
    var envAllRequired = false

    @Flag(name: .shortAndLong, help: "Verbose reporting")
    var verbose = false

    @Argument(help: "path to generated file")
    var outputPath: String

    mutating func run() throws {
        let pathConfig = PathConfig(
            environmentPath: environmentPath ?? ".env",
            checksumPath: checksumPath,
            outputPath: outputPath,
            templatePath: templatePath
        )

        let ciConfig: CIRequirements?
        if let ciEnvVar = environmentId {
            if envRequired.count == 0 && !envAllRequired && verbose {
                print("You specified a build environment identifier but no required variables. Was this intended?")
            }
            ciConfig = CIRequirements(identifier: ciEnvVar, runtimeRequired: envRequired, requireAll: envAllRequired)
        } else if envRequired.count > 0 || envAllRequired {
            throw AppError.badArguments("You specified required build environment variables but no way to identify if we're running in a specific build environment. Supply a value for --environment-id")
        } else {
            ciConfig = nil
        }

        let app = SwiftStringGarbler(
            pathConfig: pathConfig,
            userFlags: UserFlags(isVerbose: verbose),
            ciConfig: ciConfig
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
