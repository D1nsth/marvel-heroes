//
//  TypeSectionEnum.swift
//  Marvel Heroes
//
//  Created by Никита on 14.11.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import Foundation

enum NameSections: String {
    case CHARACTERS = "Characters"
    case COMICS = "Comics"
//    case CREATORS = "Creators"
//    case EVENTS = "Events"
//    case SERIES = "Series"
//    case STORIES = "Stories"
    
    func getString() -> String {
        return self.rawValue
    }
    
    static func getEnum(byString section: String) -> NameSections {
        switch section {
        case "Characters":       return .CHARACTERS
        case "Comics":           return .COMICS
        
        default:
            print("Error get enum NameSections")
            return .CHARACTERS
        }
    }
}
