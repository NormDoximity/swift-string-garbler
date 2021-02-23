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
// this file was automatically generated. do not edit
//
// 
import Foundation
import CryptoKit

enum ProjectKeys {

    private static var keyData: [UInt8] { {{encryptionKey}} }

    private static var decryptKey: SymmetricKey? {
        guard let d = dataFromBase64Encoded(keyData) else { return nil }
        return SymmetricKey(data: d)
    }

    {{#apiKeys}}
    private static var {{keyName}}value: [UInt8] { {{keyValue}} }
    {{/apiKeys}}

    private enum Internal {
        {{#apiKeys}}
        case {{keyName}}
        {{/apiKeys}}
    }

    {{#apiKeys}}
    public static var {{keyName}}: String { reconstituteValue(key: Internal.{{keyName}}) }
    {{/apiKeys}}

    private static func reconstituteValue(key: Internal) -> String {

        guard let decryptKey = decryptKey else { fatalError("No Decryption Key") }

        let bytes: [UInt8] = {
            switch key {
                {{#apiKeys}}
                case .{{keyName}}:
                return {{keyName}}value
                {{/apiKeys}}
            }
        }()

        guard
            let data = dataFromBase64Encoded(bytes),
            let sealedBox = try? ChaChaPoly.SealedBox(combined: data)
        else { fatalError() }

        guard
            let decryptedData = try? ChaChaPoly.open(sealedBox, using: decryptKey),
            let clearText = String(data: decryptedData, encoding: .utf8)
        else {
            fatalError()
        }
        return clearText
    }

    private static func dataFromBase64Encoded(_ bytes: [UInt8]) -> Data? {
        guard let s = String(bytes: bytes, encoding: .utf8) else { return nil }
        return Data(base64Encoded: s)
    }

}
"""
}
