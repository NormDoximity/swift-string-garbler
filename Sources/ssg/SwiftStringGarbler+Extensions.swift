//
//  SwiftStringGarbler+Extensions.swift
//  ssg
//
//  Created by Norman Barnard on 5/5/21.
//

import Foundation
import TSCBasic
import CryptoKit

extension AbsolutePath {
    public func existsAsFile(in fileSystem: FileSystem = localFileSystem) -> Bool {
        return fileSystem.isFile(self)
    }
}

extension String {
    @available(OSX 10.15, *)
    public func sha256Checksum() -> String {
        guard let d = data(using: .utf8) else { fatalError("Can't get data representation of string \(self)") }
        let digest = SHA256.hash(data: d)
        return digest.compactMap { String(format: "%02x", $0) }.joined()
    }

    public func absolutePath(relatetiveTo path: AbsolutePath) -> AbsolutePath {
        hasPrefix("/") ? AbsolutePath(self) : AbsolutePath(self, relativeTo: path)
    }

    public var asData: Data? { data(using: .utf8) }
}

extension Data {
    public var asUTF8String: String? {
        String(data: self, encoding: .utf8)
    }
}
