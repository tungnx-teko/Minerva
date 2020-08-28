//
//  MD5Encryptor.swift
//  Teko
//
//  Created by Tung Nguyen on 5/20/20.
//

import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

public class MD5Encryptor {
    
    public static func md5(text: String, secretKey: String) -> String {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = "\(secretKey)\(text)".data(using:.utf8) ?? Data()
        var digestData = Data(count: length)
        
        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        return digestData.map { String(format: "%02hhx", $0) }.joined()
    }
    
}
