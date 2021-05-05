// ****
// this file was automatically generated. do not edit
//
// 
import Foundation
import CryptoKit

enum ProjectKeys {

    private static var keyData: [UInt8] { [85, 109, 49, 43, 54, 70, 107, 108, 97, 79, 67, 119, 79, 75, 81, 84, 108, 68, 43, 54, 99, 109, 51, 69, 70, 86, 89, 101, 102, 53, 85, 65, 122, 53, 57, 75, 87, 97, 120, 47, 70, 113, 85, 61] }

    private static var decryptKey: SymmetricKey? {
        guard let d = dataFromBase64Encoded(keyData) else { return nil }
        return SymmetricKey(data: d)
    }

    
    private static var key3value: [UInt8] { [57, 49, 100, 76, 116, 55, 48, 48, 49, 117, 122, 69, 98, 120, 115, 89, 47, 43, 84, 81, 101, 120, 84, 103, 102, 78, 116, 99, 57, 56, 121, 50, 81, 111, 73, 73, 84, 43, 109, 114, 77, 122, 108, 118, 88, 111, 115, 71, 81, 101, 75, 71, 103, 110, 71, 75, 110, 76, 109, 49, 66, 104, 110, 98, 106, 85, 69, 106, 111, 113, 112, 71, 109, 88, 115, 61] }
    
    private static var key2value: [UInt8] { [101, 100, 108, 100, 48, 68, 120, 54, 115, 115, 108, 67, 101, 113, 117, 109, 108, 53, 82, 75, 81, 115, 65, 74, 81, 107, 84, 43, 113, 105, 90, 105, 116, 79, 84, 77, 54, 100, 102, 57, 120, 83, 82, 76, 113, 82, 57, 77, 109, 120, 65, 87, 85, 80, 107, 52, 78, 83, 85, 61] }
    
    private static var key1value: [UInt8] { [110, 71, 116, 48, 51, 51, 71, 117, 121, 115, 97, 55, 98, 72, 52, 102, 73, 79, 54, 78, 108, 114, 120, 97, 119, 117, 120, 112, 52, 70, 116, 74, 104, 86, 51, 52, 65, 100, 113, 105, 105, 118, 67, 101, 49, 78, 78, 103, 114, 53, 47, 86, 82, 43, 74, 106, 52, 50, 103, 61] }
    

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