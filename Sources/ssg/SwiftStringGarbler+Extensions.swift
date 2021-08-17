//
//  SwiftStringGarbler+Extensions.swift
//  ssg
//
//  Created by Norman Barnard on 5/5/21.
//

import Foundation
import TSCBasic
import CryptoKit

public extension AbsolutePath {
    func existsAsFile(in fileSystem: FileSystem = localFileSystem) -> Bool {
        return fileSystem.isFile(self)
    }
}

public extension String {
    @available(OSX 10.15, *)
    func sha256Checksum() -> String {
        guard let d = data(using: .utf8) else { fatalError("Can't get data representation of string \(self)") }
        let digest = SHA256.hash(data: d)
        return digest.compactMap { String(format: "%02x", $0) }.joined()
    }

    func absolutePath(relatetiveTo path: AbsolutePath) -> AbsolutePath {
        hasPrefix("/") ? AbsolutePath(self) : AbsolutePath(self, relativeTo: path)
    }

}
