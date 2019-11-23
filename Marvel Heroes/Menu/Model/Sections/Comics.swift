//
//  Comics.swift
//  Marvel Heroes
//
//  Created by Никита on 14.11.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import Foundation

struct Comics {
    var id: Int
    var title: String
    var description: String
    var imageURL: String
    
    init?(dist: [String: AnyObject]) {
        guard let id = dist["id"] as? Int,
              let title = dist["title"] as? String,
              let description = dist["description"] as? String,
              let thumbnail = dist["thumbnail"] as? [String: Any] else { return nil }
        
        self.id = id
        self.title = title
        self.description = description
        self.imageURL = ""
        
        guard let path = thumbnail["path"] as? String,
              let extensionImage = thumbnail["extension"] as? String else { return nil }
        
        self.imageURL = "\(path)/portrait_medium.\(extensionImage)"
    }
}
