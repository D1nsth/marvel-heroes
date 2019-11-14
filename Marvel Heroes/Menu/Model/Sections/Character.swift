//
//  Character.swift
//  Marvel Heroes
//
//  Created by Никита on 13.11.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import Foundation

struct Character {
    var id: Int
    var name: String
    var description: String
    
    init?(dist: [String: AnyObject]) {
        guard let id = dist["id"] as? Int,
              let name = dist["name"] as? String,
              let description = dist["description"] as? String else { return nil }
        
        self.id = id
        self.name = name
        self.description = description
    }
}
