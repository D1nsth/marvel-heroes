//
//  CharacterNetworkService.swift
//  Marvel Heroes
//
//  Created by Никита on 13.11.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import Foundation
import CommonCrypto

class SectionsNetworkService {
    private init() { }
    
    // get hash parameter
    private static func MD5(string: String) -> Data {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = string.data(using:.utf8)!
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
        return digestData
    }
    
    static func getSectionData(_ nameSection: NameSections, completion: @escaping(GetSectionResponse) -> ()) {
        // параметры запроса
        let ts = 1
        let publicKey = Bundle.main.infoDictionary?["Public key"] ?? ""
        let privateKey = Bundle.main.infoDictionary?["Private key"] ?? ""
        let section = nameSection.getString().lowercased()
        
        let md5Data = MD5(string:"\(ts)\(privateKey)\(publicKey)")
        let hash =  md5Data.map { String(format: "%02hhx", $0) }.joined()
        
        guard let url = URL(string: "http://gateway.marvel.com/v1/public/\(section)?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)") else { return }
        
        NetworkService.shared.getData(url: url) { (json) in
            do {
                let repsonse = try GetSectionResponse(json: json, nameSection: nameSection)
                completion(repsonse)
                
            } catch {
                print("Sections network service error: \(error)")
            }
        }
        
    }
    
}
