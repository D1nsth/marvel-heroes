//
//  GetSectionResponse.swift
//  Marvel Heroes
//
//  Created by Никита on 13.11.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import Foundation

struct GetSectionResponse {
    
    typealias JSON = [String: AnyObject]
    let resultsArray: [Any]
    
    init(json: Any, nameSection: NameSections) throws {
        guard let json = json as? JSON else { throw NetworkError.failGetJSON }
        guard let dataJSON = json["data"] as? JSON else { throw NetworkError.failParseJSON }
        guard let resultsJSON = dataJSON["results"] as? [JSON] else { throw NetworkError.failParseJSON }
        
        let dataResults = try! JSONSerialization.data(withJSONObject: resultsJSON, options: [])
        let stringJSON = String(data: dataResults, encoding: .utf8)
        
        var resultsArray = [Any]()
        
        switch nameSection {
            
        case .characters:
            resultsArray = try! JSONDecoder().decode([Character].self, from: stringJSON!.data(using: .utf8)!)
        case .comics:
            resultsArray = try! JSONDecoder().decode([Comics].self, from: stringJSON!.data(using: .utf8)!)
        case .creators:
            resultsArray = try! JSONDecoder().decode([Creator].self, from: stringJSON!.data(using: .utf8)!)
        case .events:
            resultsArray = try! JSONDecoder().decode([Event].self, from: stringJSON!.data(using: .utf8)!)
        case .series:
            resultsArray = try! JSONDecoder().decode([Series].self, from: stringJSON!.data(using: .utf8)!)
        case .stories:
            resultsArray = try! JSONDecoder().decode([Story].self, from: stringJSON!.data(using: .utf8)!)
            
        }
        
        self.resultsArray = resultsArray as [AnyObject]
    }
    
}
