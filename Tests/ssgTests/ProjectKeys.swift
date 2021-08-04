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
    
    static var key3ScrambledValue: [UInt8] { [65, 119, 105, 79, 118, 86, 47, 122, 111, 101, 104, 103, 48, 85, 111, 66, 76, 77, 51, 108, 51, 65, 74, 84, 48, 72, 87, 112, 121, 84, 70, 69, 122, 51, 120, 72, 52, 75, 115, 118, 109, 71, 111, 100, 109, 50, 73, 82, 67, 103, 77, 51, 83, 108, 90, 57, 115, 90, 43, 52, 43, 114, 99, 83, 43, 119, 65, 120, 118, 87, 86, 88, 73, 112, 48, 61] }
    
    static var key1ScrambledValue: [UInt8] { [84, 101, 109, 109, 122, 50, 116, 120, 116, 107, 100, 105, 121, 49, 90, 75, 105, 102, 72, 68, 99, 121, 51, 75, 109, 115, 81, 48, 75, 53, 78, 55, 68, 52, 113, 118, 71, 105, 108, 51, 103, 87, 90, 77, 81, 100, 53, 78, 106, 119, 61, 61] }
    
    static var key2ScrambledValue: [UInt8] { [87, 77, 122, 101, 48, 114, 84, 87, 65, 79, 115, 52, 119, 100, 47, 76, 80, 48, 84, 109, 79, 114, 72, 115, 75, 80, 88, 120, 55, 43, 100, 52, 109, 48, 107, 86, 121, 74, 99, 103, 104, 90, 83, 118, 73, 102, 100, 71, 118, 66, 110, 110, 75, 97, 98, 118, 121, 72, 99, 52, 76, 105, 75, 67, 50, 47, 119, 101, 65, 105, 71, 104, 65, 84, 97, 50, 99, 56, 76, 110] }
    
}

private extension ProjectKeys {
    static var keyData: [UInt8] { [87, 73, 98, 79, 81, 48, 66, 76, 109, 76, 72, 65, 103, 73, 118, 104, 108, 99, 72, 114, 68, 57, 74, 86, 112, 55, 113, 74, 110, 87, 109, 65, 73, 97, 121, 80, 84, 112, 79, 108, 75, 113, 81, 61] }

    static var decryptKey: SymmetricKey? {
        dataFromBase64Encoded(keyData).flatMap { SymmetricKey(data: $0) }
    }

    static func dataFromBase64Encoded(_ bytes: [UInt8]) -> Data? {
        String(bytes: bytes, encoding: .utf8).flatMap { Data(base64Encoded: $0) }
    }
}