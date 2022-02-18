// ****
// This file was automatically generated; do not edit.
//

import Foundation
import CryptoKit

public enum ProjectKeys: CaseIterable {
    
    case key3
    
    case key1
    
    case key2
    

    public var value: String { reconstitute }
}

private extension ProjectKeys {
    var bytes: [UInt8] {
        switch self {
        
        case .key3: return Self.key3ScrambledValue
        
        case .key1: return Self.key1ScrambledValue
        
        case .key2: return Self.key2ScrambledValue
        
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
    
    static var key3ScrambledValue: [UInt8] { [112, 82, 78, 56, 65, 86, 117, 103, 80, 69, 99, 50, 108, 104, 86, 53, 103, 77, 106, 90, 122, 84, 110, 100, 116, 69, 100, 52, 118, 90, 57, 78, 111, 50, 104, 120, 84, 119, 74, 52, 48, 90, 68, 109, 117, 65, 79, 103, 71, 90, 104, 104, 51, 55, 72, 102, 74, 105, 75, 49, 88, 114, 110, 100, 87, 83, 55, 110, 121, 87, 68, 43, 102, 110, 119, 61] }
    
    static var key1ScrambledValue: [UInt8] { [107, 67, 99, 48, 81, 57, 108, 83, 101, 107, 111, 83, 54, 120, 100, 110, 87, 88, 104, 114, 106, 114, 118, 48, 72, 90, 99, 87, 113, 122, 72, 110, 73, 70, 68, 82, 87, 71, 115, 56, 72, 70, 83, 50, 52, 48, 76, 56, 57, 122, 84, 49, 76, 49, 99, 69, 98, 79, 111, 61] }
    
    static var key2ScrambledValue: [UInt8] { [82, 51, 51, 56, 71, 84, 101, 122, 83, 67, 103, 117, 47, 103, 54, 101, 82, 111, 118, 79, 77, 100, 101, 108, 43, 118, 83, 97, 109, 67, 56, 102, 99, 55, 109, 87, 122, 69, 86, 108, 109, 48, 84, 79, 66, 83, 75, 88, 122, 88, 107, 80, 54, 52, 43, 81, 75, 101, 56, 61] }
    
}

private extension ProjectKeys {
    static var keyData: [UInt8] { [108, 74, 72, 73, 69, 89, 81, 99, 67, 53, 51, 116, 88, 115, 102, 112, 116, 50, 75, 56, 47, 117, 102, 74, 75, 84, 117, 111, 86, 70, 80, 47, 103, 88, 112, 69, 104, 113, 106, 117, 112, 122, 77, 61] }

    static var decryptKey: SymmetricKey? {
        dataFromBase64Encoded(keyData).flatMap { SymmetricKey(data: $0) }
    }

    static func dataFromBase64Encoded(_ bytes: [UInt8]) -> Data? {
        String(bytes: bytes, encoding: .utf8).flatMap { Data(base64Encoded: $0) }
    }
}