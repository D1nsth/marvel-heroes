//
//  Creators.swift
//  Marvel Heroes
//
//  Created by Никита on 15.11.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import Foundation

struct Creator {
    var id: Int
    var fullName: String
    var imageURL: String
    
    init?(dist: [String: AnyObject]) {
        guard let id = dist["id"] as? Int,
              let fullName = dist["fullName"] as? String,
              let thumbnail = dist["thumbnail"] as? [String: Any] else { return nil }
        
        self.id = id
        self.fullName = fullName
        self.imageURL = ""
        
        guard let path = thumbnail["path"] as? String,
              let extensionImage = thumbnail["extension"] as? String else { return nil }
        
        self.imageURL = "\(path)/portrait_medium.\(extensionImage)"
    }
}
