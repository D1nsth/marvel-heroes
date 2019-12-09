//
//  TypeSectionEnum.swift
//  Marvel Heroes
//
//  Created by Никита on 14.11.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import Foundation

enum NameSections: String {
    case characters = "Characters"
    case comics = "Comics"
    case creators = "Creators"
    case events = "Events"
    case series = "Series"
    case stories = "Stories"
    
    func getString() -> String {
        return self.rawValue
    }
    
    static func getEnum(byString section: String) -> NameSections {
        switch section {
        case "Characters":  return .characters
        case "Comics":      return .comics
        case "Creators":    return .creators
        case "Events":      return .events
        case "Series":      return .series
        case "Stories":     return .stories
            
        default:
            print("Error get enum NameSections")
            return .characters
        }
    }
}
