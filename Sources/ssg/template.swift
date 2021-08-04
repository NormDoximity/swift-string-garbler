//
//  template.swift
//  ssg
//
//  Created by Norman Barnard on 8/5/20.
//

import Foundation

enum Template {

static let keyFile: String =
"""
// ****
// This file was automatically generated; do not edit.
//

import Foundation
import CryptoKit

public enum ProjectKeys: CaseIterable {
    {{#apiKeys}}
    case {{keyName}}
    {{/apiKeys}}

    public var value: String { reconstitute }
}

private extension ProjectKeys {
    var bytes: [UInt8] {
        switch self {
        {{#apiKeys}}
        case .{{keyName}}: return Self.{{keyName}}ScrambledValue
        {{/apiKeys}}
        }
    }

    var reconstitute: String {
        guard let decryptKey = Self.decryptKey else { fatalError("No Decryption Key") }
        guard
            let reconstitutedText = Self.dataFromBase64Encoded(bytes)
                .flatMap({ try? ChaChaPoly.SealedBox(combined: $0) })
                .flatMap({ try? ChaChaPoly.open($0, using: decryptKey) })
                .flatMap({ String(data: $0, encoding: .utf8) })
        else { fatalError() }

        return reconstitutedText
    }
}

private extension ProjectKeys {
    {{#apiKeys}}
    static var {{keyName}}ScrambledValue: [UInt8] { {{keyValue}} }
    {{/apiKeys}}
}

private extension ProjectKeys {
    static var keyData: [UInt8] { {{encryptionKey}} }

    static var decryptKey: SymmetricKey? {
        dataFromBase64Encoded(keyData).flatMap { SymmetricKey(data: $0) }
    }

    static func dataFromBase64Encoded(_ bytes: [UInt8]) -> Data? {
        String(bytes: bytes, encoding: .utf8).flatMap { Data(base64Encoded: $0) }
    }
}
"""
}
