//
//  Story.swift
//  Marvel Heroes
//
//  Created by Никита on 15.11.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import Foundation

struct Story {
    var id: Int
    var title: String
    var description: String
    var type: String
    
    init?(dist: [String: AnyObject]) {
        guard let id = dist["id"] as? Int,
              let title = dist["title"] as? String,
              let description = dist["description"] as? String,
              let type = dist["type"] as? String else { return nil }
        
        self.id = id
        self.title = title
        self.description = description
        self.type = type
    }
}
