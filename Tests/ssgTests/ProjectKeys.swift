// ****
// this file was automatically generated. do not edit
//
// 
import Foundation
import CryptoKit

enum ProjectKeys {

    private static var keyData: [UInt8] { [114, 108, 102, 110, 52, 69, 69, 109, 51, 53, 109, 110, 71, 67, 52, 76, 73, 97, 112, 121, 112, 114, 83, 88, 117, 74, 73, 102, 109, 79, 89, 76, 81, 83, 97, 43, 107, 89, 56, 71, 84, 82, 107, 61] }

    private static var decryptKey: SymmetricKey? {
        guard let d = dataFromBase64Encoded(keyData) else { return nil }
        return SymmetricKey(data: d)
    }

    
    private static var key2value: [UInt8] { [108, 47, 97, 82, 120, 67, 105, 66, 110, 53, 100, 54, 77, 85, 109, 77, 106, 65, 97, 98, 116, 66, 82, 71, 121, 71, 43, 106, 116, 81, 54, 49, 53, 118, 121, 100, 119, 97, 98, 115, 76, 73, 87, 65, 121, 113, 48, 122, 98, 47, 121, 65, 104, 70, 122, 106, 77, 119, 65, 61] }
    
    private static var key3value: [UInt8] { [104, 105, 83, 108, 83, 104, 69, 118, 57, 85, 110, 87, 49, 81, 115, 71, 107, 106, 84, 65, 106, 80, 109, 68, 119, 52, 107, 47, 118, 72, 47, 88, 66, 88, 70, 57, 101, 83, 118, 65, 112, 117, 68, 67, 122, 48, 54, 88, 55, 90, 106, 74, 115, 68, 120, 74, 98, 108, 54, 85, 102, 67, 99, 122, 70, 57, 118, 121, 110, 120, 50, 87, 105, 74, 103, 61] }
    
    private static var key1value: [UInt8] { [122, 88, 43, 99, 112, 110, 90, 70, 83, 66, 106, 119, 43, 73, 79, 56, 112, 99, 74, 85, 118, 71, 49, 87, 86, 56, 74, 102, 80, 99, 49, 122, 107, 75, 80, 72, 106, 117, 72, 43, 56, 57, 72, 90, 72, 83, 73, 54, 112, 99, 101, 79, 67, 111, 73, 103, 88, 101, 115, 61] }
    

    private enum Internal {
        
        case key2
        
        case key3
        
        case key1
        
    }

    
    public static var key2: String { reconstituteValue(key: Internal.key2) }
    
    public static var key3: String { reconstituteValue(key: Internal.key3) }
    
    public static var key1: String { reconstituteValue(key: Internal.key1) }
    

    private static func reconstituteValue(key: Internal) -> String {

        guard let decryptKey = decryptKey else { fatalError("No Decryption Key") }

        let bytes: [UInt8] = {
            switch key {
                
                case .key2:
                return key2value
                
                case .key3:
                return key3value
                
                case .key1:
                return key1value
                
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