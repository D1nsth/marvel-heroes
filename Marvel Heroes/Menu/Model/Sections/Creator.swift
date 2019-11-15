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
    
    init?(dist: [String: AnyObject]) {
        guard let id = dist["id"] as? Int,
              let fullName = dist["fullName"] as? String else { return nil }
        
        self.id = id
        self.fullName = fullName
    }
}
