//
//  String+CrytorExt.swift
//  FinstroPay
//
//  Created by sondang on 7/6/18.
//  Copyright © 2018 sondang. All rights reserved.
//

import UIKit
import CryptoSwift

extension String {
    
    func aesEncrypt(key: String, iv: String) -> String? {
        do {
            let aes = try AES(key: key, iv: iv, padding: .pkcs7) // aes128
            let ciphertext = try aes.encrypt(Array(self.utf8))
            return ciphertext.toBase64()
        }
        catch {
            return nil
        }
    }
    
    func aesDecrypt(key: String, iv: String) -> String? {
        let data = Data(base64Encoded: self)!
        do {
            let aes = try AES(key: key, iv: iv, padding: .pkcs7)
            let ciphertext = try aes.decrypt([UInt8](data))
            return String(bytes: ciphertext, encoding: .utf8)
        }
        catch {
            return nil
        }
    }
    
}
