//
//  TemplateEdit.swift
//  
//
//  Created by Norman Barnard on 2/20/21.
//

import CryptoKit
import Foundation

// Use this file for editing the template.

public enum ProjectKeys: CaseIterable {
    case keyName

    public var value: String { reconstitute }
}

private extension ProjectKeys {
    var bytes: [UInt8] {
        switch self {
        case .keyName: return Self.keyNameScrambledValue
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
    static var keyNameScrambledValue: [UInt8] { [] }
}

private extension ProjectKeys {
    static var keyData: [UInt8] { [] }

    static var decryptKey: SymmetricKey? {
        dataFromBase64Encoded(keyData).flatMap { SymmetricKey(data: $0) }
    }

    static func dataFromBase64Encoded(_ bytes: [UInt8]) -> Data? {
        String(bytes: bytes, encoding: .utf8).flatMap { Data(base64Encoded: $0) }
    }
}
