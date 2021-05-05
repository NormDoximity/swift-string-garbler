// ****
// this file was automatically generated. do not edit
//
// 
import Foundation
import CryptoKit

enum ProjectKeys {

    private static var keyData: [UInt8] { [81, 117, 99, 56, 100, 83, 67, 98, 101, 109, 119, 112, 82, 98, 54, 108, 114, 89, 71, 49, 102, 71, 72, 48, 82, 114, 117, 76, 121, 100, 76, 76, 115, 113, 53, 75, 109, 72, 106, 117, 109, 65, 103, 61] }

    private static var decryptKey: SymmetricKey? {
        guard let d = dataFromBase64Encoded(keyData) else { return nil }
        return SymmetricKey(data: d)
    }

    
    private static var key2value: [UInt8] { [71, 88, 111, 115, 113, 68, 114, 120, 51, 100, 77, 66, 54, 88, 47, 48, 78, 73, 116, 121, 86, 67, 57, 119, 120, 77, 52, 55, 115, 85, 53, 105, 115, 43, 119, 99, 67, 81, 89, 120, 102, 83, 79, 120, 98, 49, 118, 72, 103, 105, 118, 55, 70, 47, 55, 54, 69, 71, 99, 61] }
    
    private static var key3value: [UInt8] { [72, 100, 112, 118, 49, 81, 73, 90, 65, 73, 81, 56, 69, 102, 117, 113, 72, 90, 89, 118, 84, 108, 89, 121, 109, 83, 77, 54, 69, 116, 75, 83, 51, 77, 79, 121, 101, 73, 104, 101, 116, 101, 72, 112, 103, 106, 115, 76, 98, 107, 120, 51, 68, 69, 114, 108, 116, 71, 88, 81, 105, 83, 112, 56, 71, 78, 118, 108, 77, 112, 117, 79, 83, 104, 107, 61] }
    
    private static var key1value: [UInt8] { [77, 71, 76, 122, 78, 75, 82, 67, 51, 101, 81, 90, 53, 106, 52, 119, 79, 115, 111, 74, 51, 86, 49, 57, 103, 122, 120, 106, 102, 120, 53, 88, 71, 83, 76, 116, 66, 117, 67, 65, 48, 112, 79, 121, 82, 76, 53, 65, 110, 110, 53, 43, 66, 69, 109, 65, 53, 119, 85, 61] }
    

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