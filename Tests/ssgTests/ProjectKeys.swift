// ****
// This file was automatically generated; do not edit.
//

import Foundation
import CryptoKit

public enum ProjectKeys: CaseIterable {
    
    case key2
    
    case key3
    
    case key1
    

    public var value: String { reconstitute }
}

private extension ProjectKeys {
    var bytes: [UInt8] {
        switch self {
        
        case .key2: return Self.key2ScrambledValue
        
        case .key3: return Self.key3ScrambledValue
        
        case .key1: return Self.key1ScrambledValue
        
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
    
    static var key2ScrambledValue: [UInt8] { [75, 117, 47, 84, 105, 101, 109, 113, 77, 118, 51, 106, 79, 47, 113, 82, 97, 120, 100, 67, 77, 56, 88, 75, 110, 90, 111, 103, 103, 84, 70, 97, 80, 78, 52, 84, 71, 73, 48, 87, 82, 79, 107, 70, 99, 70, 121, 109, 50, 72, 106, 72, 120, 72, 85, 71, 88, 83, 65, 61] }
    
    static var key3ScrambledValue: [UInt8] { [49, 66, 115, 84, 43, 119, 65, 116, 76, 54, 103, 80, 121, 119, 68, 106, 87, 107, 122, 57, 80, 102, 120, 117, 119, 111, 115, 56, 86, 90, 85, 121, 117, 86, 72, 118, 57, 50, 109, 47, 110, 71, 43, 67, 66, 53, 56, 99, 89, 66, 68, 49, 97, 81, 117, 52, 84, 100, 72, 74, 105, 78, 106, 50, 121, 88, 51, 117, 107, 83, 68, 65, 80, 100, 73, 61] }
    
    static var key1ScrambledValue: [UInt8] { [47, 77, 70, 107, 68, 116, 101, 113, 102, 108, 55, 105, 99, 97, 50, 114, 47, 102, 103, 97, 115, 117, 74, 119, 111, 121, 70, 112, 57, 86, 90, 122, 103, 106, 73, 67, 70, 51, 98, 80, 90, 55, 107, 116, 83, 112, 111, 85, 50, 49, 84, 106, 68, 69, 81, 111, 85, 90, 111, 61] }
    
}

private extension ProjectKeys {
    static var keyData: [UInt8] { [73, 83, 98, 90, 106, 70, 78, 89, 50, 50, 74, 113, 55, 98, 115, 89, 86, 98, 105, 99, 80, 114, 99, 110, 122, 48, 111, 85, 105, 101, 73, 108, 50, 88, 109, 80, 115, 73, 89, 53, 82, 50, 99, 61] }

    static var decryptKey: SymmetricKey? {
        dataFromBase64Encoded(keyData).flatMap { SymmetricKey(data: $0) }
    }

    static func dataFromBase64Encoded(_ bytes: [UInt8]) -> Data? {
        String(bytes: bytes, encoding: .utf8).flatMap { Data(base64Encoded: $0) }
    }
}