// ****
// This file was automatically generated; do not edit.
//

import Foundation
import CryptoKit

public enum ProjectKeys: CaseIterable {
    
    case key1
    
    case key2
    
    case key3
    

    public var value: String { reconstitute }
}

private extension ProjectKeys {
    var bytes: [UInt8] {
        switch self {
        
        case .key1: return Self.key1ScrambledValue
        
        case .key2: return Self.key2ScrambledValue
        
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
    
    static var key1ScrambledValue: [UInt8] { [102, 53, 43, 101, 99, 49, 103, 68, 74, 122, 76, 84, 76, 56, 72, 105, 101, 99, 99, 116, 114, 81, 70, 47, 114, 75, 107, 105, 101, 87, 48, 106, 106, 97, 122, 113, 113, 86, 102, 51, 112, 85, 53, 122, 48, 83, 101, 50, 88, 86, 121, 102, 73, 43, 47, 113, 86, 83, 48, 61] }
    
    static var key2ScrambledValue: [UInt8] { [107, 54, 48, 73, 114, 118, 99, 50, 57, 75, 67, 76, 114, 106, 88, 119, 114, 121, 117, 114, 97, 115, 109, 112, 76, 66, 107, 69, 65, 104, 102, 84, 119, 71, 109, 121, 54, 80, 50, 120, 109, 67, 120, 88, 80, 73, 57, 119, 90, 57, 89, 82, 68, 109, 105, 88, 102, 105, 111, 61] }
    
    static var key3ScrambledValue: [UInt8] { [97, 97, 80, 86, 52, 89, 90, 113, 120, 105, 101, 83, 80, 121, 84, 77, 104, 79, 118, 80, 73, 86, 104, 88, 76, 67, 79, 115, 118, 112, 114, 47, 72, 117, 78, 70, 47, 68, 89, 78, 85, 106, 88, 68, 49, 72, 74, 122, 89, 75, 108, 88, 76, 102, 118, 49, 51, 88, 57, 73, 102, 81, 90, 108, 114, 73, 55, 72, 81, 122, 115, 97, 99, 55, 81, 61] }
    
}

private extension ProjectKeys {
    static var keyData: [UInt8] { [86, 82, 74, 98, 111, 114, 107, 83, 53, 106, 81, 87, 86, 77, 120, 68, 57, 112, 51, 54, 50, 80, 76, 119, 88, 78, 48, 111, 49, 98, 112, 65, 103, 78, 43, 111, 108, 71, 72, 51, 100, 78, 103, 61] }

    static var decryptKey: SymmetricKey? {
        dataFromBase64Encoded(keyData).flatMap { SymmetricKey(data: $0) }
    }

    static func dataFromBase64Encoded(_ bytes: [UInt8]) -> Data? {
        String(bytes: bytes, encoding: .utf8).flatMap { Data(base64Encoded: $0) }
    }
}