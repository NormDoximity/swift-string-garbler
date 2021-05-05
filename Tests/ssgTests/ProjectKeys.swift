// ****
// this file was automatically generated. do not edit
//
// 
import Foundation
import CryptoKit

enum ProjectKeys {

    private static var keyData: [UInt8] { [78, 90, 67, 84, 108, 83, 116, 83, 106, 55, 87, 80, 67, 43, 97, 104, 111, 74, 86, 73, 66, 49, 116, 68, 116, 111, 88, 115, 107, 52, 89, 43, 90, 80, 108, 90, 119, 78, 112, 71, 105, 114, 69, 61] }

    private static var decryptKey: SymmetricKey? {
        guard let d = dataFromBase64Encoded(keyData) else { return nil }
        return SymmetricKey(data: d)
    }

    
    private static var key3value: [UInt8] { [104, 120, 114, 82, 101, 119, 89, 75, 107, 48, 122, 77, 102, 82, 87, 83, 107, 70, 122, 109, 69, 119, 117, 88, 101, 76, 68, 66, 53, 65, 73, 97, 110, 71, 82, 120, 57, 116, 106, 70, 105, 73, 99, 108, 83, 117, 66, 108, 65, 83, 113, 122, 88, 100, 43, 55, 81, 72, 43, 53, 108, 108, 102, 118, 121, 81, 86, 116, 102, 120, 51, 119, 81, 77, 65, 61] }
    
    private static var key2value: [UInt8] { [43, 85, 81, 70, 68, 97, 102, 90, 53, 108, 86, 114, 48, 83, 104, 66, 85, 90, 121, 78, 77, 54, 66, 52, 84, 119, 114, 83, 49, 110, 121, 52, 103, 50, 121, 115, 88, 116, 80, 84, 47, 51, 105, 77, 109, 65, 118, 115, 115, 89, 112, 54, 47, 51, 89, 50, 54, 55, 73, 61] }
    
    private static var key1value: [UInt8] { [101, 99, 56, 80, 76, 98, 67, 105, 77, 83, 101, 102, 110, 69, 70, 57, 69, 104, 68, 81, 86, 55, 66, 111, 53, 120, 115, 114, 112, 116, 66, 84, 113, 56, 87, 65, 103, 51, 114, 51, 110, 74, 87, 102, 103, 52, 55, 103, 85, 86, 99, 73, 82, 103, 71, 48, 43, 108, 115, 61] }
    

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