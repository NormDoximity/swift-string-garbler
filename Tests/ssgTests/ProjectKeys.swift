// ****
// This file was automatically generated; do not edit.
//

import Foundation
import CryptoKit

public enum ProjectKeys: CaseIterable {
    
    case key2
    
    case key1
    
    case key3
    

    public var value: String { reconstitute }
}

private extension ProjectKeys {
    var bytes: [UInt8] {
        switch self {
        
        case .key2: return Self.key2ScrambledValue
        
        case .key1: return Self.key1ScrambledValue
        
        case .key3: return Self.key3ScrambledValue
        
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
    
    static var key2ScrambledValue: [UInt8] { [80, 80, 65, 116, 57, 80, 78, 77, 57, 85, 47, 89, 88, 74, 98, 80, 75, 80, 112, 100, 70, 52, 108, 121, 70, 109, 98, 102, 119, 47, 74, 65, 86, 85, 82, 89, 48, 57, 99, 47, 116, 83, 50, 73, 106, 65, 86, 109, 82, 110, 80, 75, 90, 73, 114, 69, 87, 65, 99, 61] }
    
    static var key1ScrambledValue: [UInt8] { [87, 55, 115, 112, 114, 99, 76, 88, 112, 83, 119, 54, 53, 71, 86, 117, 112, 121, 111, 122, 69, 99, 52, 70, 88, 52, 100, 100, 112, 102, 106, 80, 98, 72, 109, 114, 73, 73, 73, 78, 109, 119, 81, 114, 83, 87, 54, 87, 84, 109, 75, 88, 104, 70, 50, 55, 83, 82, 89, 61] }
    
    static var key3ScrambledValue: [UInt8] { [110, 112, 110, 85, 77, 101, 72, 97, 111, 78, 103, 115, 72, 116, 48, 97, 66, 76, 109, 101, 114, 112, 56, 74, 99, 71, 75, 121, 97, 50, 65, 43, 101, 79, 52, 104, 88, 68, 52, 84, 109, 89, 43, 81, 109, 82, 83, 118, 81, 117, 102, 53, 80, 87, 56, 69, 66, 117, 73, 104, 70, 114, 75, 88, 114, 66, 90, 83, 107, 105, 100, 47, 117, 69, 111, 61] }
    
}

private extension ProjectKeys {
    static var keyData: [UInt8] { [79, 53, 110, 70, 70, 98, 49, 90, 87, 115, 111, 104, 121, 90, 121, 103, 47, 97, 79, 82, 115, 68, 89, 117, 118, 111, 100, 119, 101, 87, 118, 82, 118, 114, 81, 57, 104, 110, 109, 104, 69, 48, 119, 61] }

    static var decryptKey: SymmetricKey? {
        dataFromBase64Encoded(keyData).flatMap { SymmetricKey(data: $0) }
    }

    static func dataFromBase64Encoded(_ bytes: [UInt8]) -> Data? {
        String(bytes: bytes, encoding: .utf8).flatMap { Data(base64Encoded: $0) }
    }
}