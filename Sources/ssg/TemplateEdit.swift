//
//  File.swift
//  
//
//  Created by Norman Barnard on 2/20/21.
//

import Foundation
import CryptoKit

// Use this file for editing the template.

enum ProjectKeys {

    private static var keyData: [UInt8] { [] }

    private static var decryptKey: SymmetricKey? {
        guard let d = dataFromBase64Encoded(keyData) else { return nil }
        return SymmetricKey(data: d)
    }

    private static var keyNameValue: [UInt8] { [] }

    private enum Internal {
        case keyName
    }

    public static var keyName: String { reconstituteValue(key: Internal.keyName) }

    private static func reconstituteValue(key: Internal) -> String {

        guard let decryptKey = decryptKey else { fatalError("Missing decryption key!") }

        let bytes: [UInt8] = {
            switch key {
            case .keyName:
                return keyNameValue
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

