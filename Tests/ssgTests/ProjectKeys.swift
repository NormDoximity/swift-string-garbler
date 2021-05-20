// ****
// this file was automatically generated. do not edit
//
// 
import Foundation
import CryptoKit

enum ProjectKeys {

    private static var keyData: [UInt8] { [100, 75, 57, 102, 87, 117, 86, 72, 78, 85, 117, 112, 107, 81, 100, 104, 102, 81, 83, 66, 118, 49, 54, 79, 51, 85, 102, 86, 116, 122, 69, 57, 47, 111, 80, 84, 105, 53, 100, 98, 114, 107, 81, 61] }

    private static var decryptKey: SymmetricKey? {
        guard let d = dataFromBase64Encoded(keyData) else { return nil }
        return SymmetricKey(data: d)
    }

    
    private static var key3value: [UInt8] { [82, 88, 82, 57, 73, 76, 77, 53, 85, 105, 88, 85, 76, 101, 87, 57, 111, 121, 116, 51, 79, 99, 108, 70, 122, 98, 116, 66, 55, 88, 47, 97, 71, 75, 90, 87, 121, 106, 66, 69, 88, 102, 104, 83, 52, 98, 54, 49, 115, 120, 104, 50, 102, 90, 76, 73, 115, 78, 43, 71, 68, 74, 121, 70, 55, 98, 105, 54, 83, 81, 55, 115, 47, 49, 99, 61] }
    
    private static var key2value: [UInt8] { [66, 101, 51, 116, 81, 82, 112, 88, 97, 43, 113, 71, 108, 109, 57, 67, 55, 116, 53, 80, 117, 101, 111, 108, 99, 97, 75, 57, 78, 69, 51, 109, 115, 83, 97, 99, 97, 113, 104, 72, 53, 111, 119, 120, 53, 97, 119, 97, 65, 55, 106, 111, 51, 80, 80, 70, 121, 56, 107, 61] }
    
    private static var key1value: [UInt8] { [88, 49, 48, 100, 121, 49, 81, 75, 105, 67, 118, 118, 73, 77, 83, 90, 72, 68, 55, 57, 118, 72, 66, 55, 50, 76, 51, 103, 53, 43, 101, 98, 67, 85, 48, 54, 87, 76, 110, 86, 113, 118, 102, 117, 82, 54, 88, 52, 116, 66, 78, 75, 52, 105, 113, 119, 43, 79, 85, 61] }
    

    private enum Internal {
        
        case key3
        
        case key2
        
        case key1
        
    }

    
    public static var key3: String { reconstituteValue(key: Internal.key3) }
    
    public static var key2: String { reconstituteValue(key: Internal.key2) }
    
    public static var key1: String { reconstituteValue(key: Internal.key1) }
    

    private static func reconstituteValue(key: Internal) -> String {

        guard let decryptKey = decryptKey else { fatalError("No Decryption Key") }

        let bytes: [UInt8] = {
            switch key {
                
                case .key3:
                return key3value
                
                case .key2:
                return key2value
                
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