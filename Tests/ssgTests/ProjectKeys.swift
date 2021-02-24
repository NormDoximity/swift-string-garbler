// ****
// this file was automatically generated. do not edit
//
// 
import Foundation
import CryptoKit

enum ProjectKeys {

    private static var keyData: [UInt8] { [118, 112, 49, 50, 43, 106, 71, 99, 105, 47, 53, 119, 112, 103, 103, 56, 87, 110, 65, 108, 99, 67, 83, 80, 56, 115, 111, 48, 89, 53, 113, 90, 73, 116, 49, 48, 101, 111, 43, 97, 52, 102, 89, 61] }

    private static var decryptKey: SymmetricKey? {
        guard let d = dataFromBase64Encoded(keyData) else { return nil }
        return SymmetricKey(data: d)
    }

    
    private static var key1value: [UInt8] { [87, 51, 56, 50, 112, 97, 111, 117, 116, 52, 97, 110, 65, 50, 97, 66, 90, 87, 111, 112, 50, 108, 75, 89, 100, 77, 74, 105, 85, 83, 117, 78, 110, 97, 89, 53, 78, 84, 51, 71, 78, 98, 99, 87, 57, 111, 98, 109, 118, 51, 87, 52, 47, 103, 76, 56, 114, 98, 99, 61] }
    
    private static var key2value: [UInt8] { [110, 83, 101, 47, 72, 120, 89, 75, 48, 71, 111, 83, 87, 100, 122, 86, 121, 50, 103, 66, 74, 119, 77, 77, 98, 85, 115, 90, 106, 49, 47, 118, 105, 113, 80, 47, 82, 56, 71, 83, 111, 115, 55, 56, 85, 105, 79, 114, 117, 53, 48, 48, 52, 113, 52, 68, 104, 71, 69, 61] }
    
    private static var key3value: [UInt8] { [115, 78, 43, 121, 106, 99, 49, 109, 104, 79, 47, 47, 78, 106, 75, 69, 108, 49, 108, 78, 86, 81, 112, 100, 113, 99, 117, 57, 102, 79, 50, 49, 89, 56, 120, 57, 117, 47, 74, 114, 70, 112, 102, 81, 56, 83, 106, 71, 51, 56, 115, 107, 54, 120, 47, 66, 84, 97, 121, 101, 82, 110, 85, 120, 71, 71, 49, 76, 119, 87, 109, 54, 114, 89, 65, 61] }
    

    private enum Internal {
        
        case key1
        
        case key2
        
        case key3
        
    }

    
    public static var key1: String { reconstituteValue(key: Internal.key1) }
    
    public static var key2: String { reconstituteValue(key: Internal.key2) }
    
    public static var key3: String { reconstituteValue(key: Internal.key3) }
    

    private static func reconstituteValue(key: Internal) -> String {

        guard let decryptKey = decryptKey else { fatalError("No Decryption Key") }

        let bytes: [UInt8] = {
            switch key {
                
                case .key1:
                return key1value
                
                case .key2:
                return key2value
                
                case .key3:
                return key3value
                
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