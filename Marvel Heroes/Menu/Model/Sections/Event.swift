//
//  Event.swift
//  Marvel Heroes
//
//  Created by Никита on 15.11.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import Foundation

struct Event: Codable {
    var id: Int
    var title: String
    var description: String?
    var imageURL: String
//    var start: Date
//    var end: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case thumbnail
    }
    
    enum ThumbnailCodingKeys: String, CodingKey {
        case path
        case extensionImage = "extension"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
        
        var thumbnailContainer = container.nestedContainer(keyedBy: ThumbnailCodingKeys.self, forKey: .thumbnail)
        try thumbnailContainer.encode(imageURL, forKey: .path)
        try thumbnailContainer.encode("", forKey: .extensionImage)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        description = try? container.decode(String.self, forKey: .description)
        
        let thumbnailContainer = try container.nestedContainer(keyedBy: ThumbnailCodingKeys.self, forKey: .thumbnail)
        let path = try thumbnailContainer.decode(String.self, forKey: .path)
        let extensionImage = try thumbnailContainer.decode(String.self, forKey: .extensionImage)
        
        if (extensionImage != "") {
            imageURL = "\(path)/portrait_medium.\(extensionImage)"
        } else {
            imageURL = path
        }
    }
    
}
