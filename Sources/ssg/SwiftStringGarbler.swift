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

@available(OSX 10.15, *)
final class SwiftStringGarbler {

    enum AppError: Error {
        case fileSystem(String)
        case badInputJson
        case dataError(String)
    }

    let environmentPath: String
    let outputPath: String
    let checksumPath: String?

    init(environmentPath: String, checksumPath: String?, outputPath: String) {
        self.environmentPath = environmentPath
        self.checksumPath = checksumPath
        self.outputPath = outputPath
    }

    func run() throws {
        guard let cwd = localFileSystem.currentWorkingDirectory else {
            throw AppError.fileSystem("No current working directory!")
        }

        let inputFile = absPath(for: environmentPath, relatativeTo: cwd)
        guard inputFile.existsAsFile() else {
            throw AppError.fileSystem("Couldn't find input environment at \(inputFile.pathString)")
        }

        guard let inputJson = try localFileSystem.readFileContents(inputFile)
            .withData({
                return try JSONSerialization.jsonObject(with: $0, options: .allowFragments) as? [String: String]
            })
        else {
            throw AppError.badInputJson
        }

        // look into the process environment for variables that have the same name as our api.
        let apiKeys = Dictionary(uniqueKeysWithValues:
            inputJson.map { key, value -> (String, String) in
                (key, ProcessEnv.vars[key] ?? value)            // prefer values from the runtime environment
            }
        )

        if let checksumPath = checksumPath {
            let checksum = computeChecksum(for: apiKeys)
            let existingSum = existingChecksum(at: checksumPath, relativeTo: cwd)
            if let existing = existingSum, existing == checksum {
                print("Checksums match. Skipping project keys file creation.")
                return
            }
            let outPath = absPath(for: checksumPath, relatativeTo: cwd)
            do {
                try localFileSystem.writeFileContents(outPath, bytes: ByteString(encodingAsUTF8: checksum))
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
        let template = try Mustache.Template(string: Template.keyFile)
        let rendering = try template.render(templateDict)

        // write it out..
        let path = absPath(for: outputPath, relatativeTo: cwd)
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

    private func existingChecksum(at path: String, relativeTo cwd: AbsolutePath) -> String? {
        let path = absPath(for: path, relatativeTo: cwd)
        if path.existsAsFile() {
            if let checksum = try? localFileSystem.readFileContents(path) {
                return String(checksum.cString)
            }
        }
        return nil
    }

}

extension AbsolutePath {
    func existsAsFile(in fileSystem: FileSystem = localFileSystem) -> Bool {
        return fileSystem.isFile(self)
    }
}

extension String {
    @available(OSX 10.15, *)
    func sha256Checksum() -> String {
        guard let d = data(using: .utf8) else { fatalError("Can't get data representation of string \(self)") }
        let digest = SHA256.hash(data: d)
        return digest.compactMap { String(format: "%02x", $0) }.joined()
    }
}
