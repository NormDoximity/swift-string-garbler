// ****
// this file was automatically generated. do not edit
//
// 
import Foundation
import CryptoKit

enum ProjectKeys {

    private static var keyData: [UInt8] { [82, 83, 75, 81, 114, 73, 53, 66, 49, 72, 43, 51, 73, 117, 75, 71, 81, 121, 75, 52, 122, 89, 71, 53, 85, 115, 71, 106, 89, 110, 43, 106, 103, 87, 71, 83, 49, 112, 108, 120, 75, 74, 99, 61] }

    private static var decryptKey: SymmetricKey? {
        guard let d = dataFromBase64Encoded(keyData) else { return nil }
        return SymmetricKey(data: d)
    }

    
    private static var key3value: [UInt8] { [51, 112, 110, 114, 97, 71, 84, 52, 100, 117, 74, 108, 102, 84, 120, 101, 87, 115, 116, 109, 81, 117, 55, 120, 47, 68, 49, 82, 81, 82, 84, 43, 97, 43, 99, 43, 84, 118, 47, 49, 81, 116, 105, 65, 55, 79, 115, 107, 115, 116, 72, 87, 99, 57, 77, 102, 122, 84, 48, 71, 65, 76, 122, 120, 51, 97, 72, 111, 99, 87, 120, 56, 55, 90, 65, 61] }
    
    private static var key1value: [UInt8] { [77, 68, 50, 110, 117, 85, 111, 83, 69, 112, 53, 122, 117, 54, 100, 77, 83, 73, 99, 105, 53, 89, 68, 70, 51, 75, 90, 83, 115, 112, 82, 110, 86, 68, 73, 90, 89, 74, 86, 52, 76, 103, 74, 89, 85, 69, 76, 50, 118, 103, 61, 61] }
    
    private static var key2value: [UInt8] { [104, 55, 118, 82, 75, 105, 43, 102, 84, 53, 70, 100, 50, 72, 115, 121, 109, 88, 84, 49, 56, 66, 48, 87, 53, 51, 113, 65, 49, 52, 100, 70, 50, 89, 90, 101, 84, 84, 54, 108, 109, 57, 75, 50, 83, 57, 122, 119, 90, 50, 102, 97, 114, 48, 111, 68, 81, 98, 76, 97, 89, 73, 73, 103, 89, 122, 50, 69, 67, 87, 105, 103, 72, 54, 70, 55, 52, 119, 78, 66] }
    

    private enum Internal {
        
        case key3
        
        case key1
        
        case key2
        
    }

    
    public static var key3: String { reconstituteValue(key: Internal.key3) }
    
    public static var key1: String { reconstituteValue(key: Internal.key1) }
    
    public static var key2: String { reconstituteValue(key: Internal.key2) }
    

    private static func reconstituteValue(key: Internal) -> String {

        guard let decryptKey = decryptKey else { fatalError("No Decryption Key") }

        let bytes: [UInt8] = {
            switch key {
                
                case .key3:
                return key3value
                
                case .key1:
                return key1value
                
                case .key2:
                return key2value
                
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