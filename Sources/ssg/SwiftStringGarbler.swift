//
//  app.swift
//  ssg
//
//  Created by Norman Barnard on 8/5/20.
//

import Foundation
import TSCBasic
import CryptoKit
import Mustache

private enum ValueLocation {
    case file, env
}
private typealias EnvAwareKeys = (key: String, value: String, location: ValueLocation)
private typealias ValueTuple = (value: String, location: ValueLocation)

@available(OSX 10.15, *)
final class SwiftStringGarbler {

    private let pathConfig: PathConfig
    private let userFlags: UserFlags

    init(pathConfig: PathConfig, userFlags: UserFlags) {
        self.pathConfig = pathConfig
        self.userFlags = userFlags
    }

    func run() throws {
        guard let cwd = localFileSystem.currentWorkingDirectory else {
            throw AppError.fileSystem("No current working directory!")
        }

        if case .invalid(let message) = pathConfig.isValid(cwd: cwd) {
            throw AppError.fileSystem(message)
        }

        let inputFile = pathConfig.environmentPath.absolutePath(relatetiveTo: cwd)

        guard let inputJson = try localFileSystem.readFileContents(inputFile)
            .withData({
                return try JSONSerialization.jsonObject(with: $0, options: .allowFragments) as? [String: String]
            })
        else {
            throw AppError.badInputJson
        }

        // look into the process environment for variables that have the same name as our api.
        let extracted = inputJson
            .filter { key, _ -> Bool in
                !key.hasPrefix("__COMMENT__") // Omit comments
            }
            .map { key, value -> EnvAwareKeys in
                let localValue = value
                let runtimeValue = ProcessEnv.vars[key]
                let valueToReturn = userFlags.prioritizeAlternativeKeys ? localValue : (runtimeValue ?? localValue)
                let location: ValueLocation
                if !userFlags.prioritizeAlternativeKeys {
                    location = runtimeValue != nil ? .env : .file
                } else {
                    location = .file
                }
                return (key, valueToReturn, location)
        }

        let apiKeys = Dictionary(uniqueKeysWithValues: extracted.map { ($0.0, $0.1) })
        if userFlags.isVerbose {
            print("\(variablesExtractedFromWhereReport(variables: extracted.map { ValueTuple($0.0, $0.2) }))")
        }

        if let checksumPath = pathConfig.checksumPath?.absolutePath(relatetiveTo: cwd) {
            let checksum = computeChecksum(for: apiKeys)
            let existingSum = existingChecksum(at: checksumPath)
            if let existing = existingSum, existing == checksum {
                print("Checksums match. Skipping project keys file creation.")
                return
            }
            do {
                try localFileSystem.writeFileContents(checksumPath, bytes: ByteString(encodingAsUTF8: checksum))
            } catch let e {
                throw AppError.fileSystem(e.localizedDescription)
            }
        }

        let encryptionKey = SymmetricKey(size: .bits256)

        // encrypt each api key and turn it into an array of bytes
        let encrypted = Dictionary(uniqueKeysWithValues:
            try apiKeys.map { key, value throws -> (String, [UInt8]) in
                guard let valueData = value.data(using: .utf8) else {
                    throw AppError.dataError("Unable to encode \(key)'s value as data")
                }
                guard let encrypted = try? ChaChaPoly.seal(valueData, using: encryptionKey).combined else {
                    throw AppError.dataError("Unable to encrypt \(key)'s value")
                }
                let bytes = Array(encrypted.base64EncodedString().utf8)
                return (key, bytes)
            }
        )

        let encodedKey = encryptionKey.withUnsafeBytes { Data($0) }.base64EncodedString()
        let marshaledKey: [UInt8] = Array(encodedKey.utf8)

        // marshal data for Mustache
        var templateDict = [String: Any]()
        templateDict["encryptionKey"] = "\(marshaledKey)"
        var templateKeys = [[String: String]]()
        encrypted.forEach { (key: String, value: [UInt8]) in
            templateKeys.append([
                "keyName": key,
                "keyValue": "\(value)"
            ])
        }
        templateDict["apiKeys"] = templateKeys

        /// render the swift source file for our api keys
        let template: Mustache.Template
        if let templatePath = pathConfig.templatePath?.absolutePath(relatetiveTo: cwd) {
            template = try Mustache.Template(path: templatePath.pathString)
        } else {
            template = try Mustache.Template(string: Template.keyFile)
        }
        let rendering = try template.render(templateDict)

        // write it out..
        let path = pathConfig.outputPath.absolutePath(relatetiveTo: cwd)
        try localFileSystem.writeFileContents(path, bytes: ByteString(encodingAsUTF8: rendering))
    }

    private func absPath(for pathString: String, relatativeTo path: AbsolutePath) -> AbsolutePath {
        return pathString.hasPrefix("/") ? AbsolutePath(pathString) : AbsolutePath(pathString, relativeTo: path)
    }

    private func computeChecksum(for environmentVariables: [String: String]) -> String {
        let sortedKeys = environmentVariables.keys.sorted()
        let corpus = sortedKeys.reduce("") { (aggregate, key) -> String in
            guard let value = environmentVariables[key] else { fatalError("Missing value for \(key)")}
            return "\(aggregate)\(key)\(value)"
        }
        return corpus.sha256Checksum()
    }

    private func existingChecksum(at path: AbsolutePath) -> String? {
        if path.existsAsFile() {
            if let checksum = try? localFileSystem.readFileContents(path) {
                return String(checksum.cString)
            }
        }
        return nil
    }

    private func variablesExtractedFromWhereReport(variables: [ValueTuple]) -> String {
        let fromEnvironment = variables.filter { $1 == .env }.map(\.value)
        let fromFile = variables.filter { $1 == .file }.map(\.value)
        let envReport = "Read from Environment:\n\t\(fromEnvironment.joined(separator: "\n\t"))"
        let fileReport = "Read from File:\n\t\(fromFile.joined(separator: "\n\t"))"
        switch (fromEnvironment.count, fromFile.count) {
            case (0, 0):
                return "Didn't read any variables from either file or environment."
            case (0, _):
                return "Read \(fromFile.count) values from the input file.\n\(fileReport)"
            case (_, 0):
                return "Read \(fromEnvironment.count) values from the runtime environment.\n\(envReport)"
            default:
                return "Read \(fromEnvironment.count) values from the runtime environment and \(fromFile.count) from the input file.\n\(fileReport)\n\(envReport)"
        }
    }
}
