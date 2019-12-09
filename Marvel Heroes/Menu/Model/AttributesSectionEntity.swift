//
//  AttributesSectionEntity.swift
//  Marvel Heroes
//
//  Created by Никита on 08.12.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import Foundation

enum AttributesSectionEntity: String {
    case  characterJsonString
    case  comicsJsonString
    case  creatorJsonString
    case  eventJsonString
    case  seriesJsonString
    case  storyJsonString
    
    func getString() -> String {
        return self.rawValue
    }
}
