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
        
        var resultsArray = [Any]()
        
        // заполняем resultArray
        for dictionary in resultsJSON {
            switch nameSection {
            case .CHARACTERS:
                guard let character = Character(dist: dictionary) else { continue }
                resultsArray.append(character)
                
            case .COMICS:
                guard let comics = Comics(dist: dictionary) else { continue }
                resultsArray.append(comics)
                
            case .CREATORS:
                guard let creator = Creator(dist: dictionary) else { continue }
                resultsArray.append(creator)
             
            case .EVENTS:
                guard let event = Event(dist: dictionary) else { continue }
                resultsArray.append(event)
                
            case .SERIES:
                guard let series = Series(dist: dictionary) else { continue }
                resultsArray.append(series)
                
            case .STORIES:
                guard let stories = Story(dist: dictionary) else { continue }
                resultsArray.append(stories)
                
            }
            
        }
        
        self.resultsArray = resultsArray as [AnyObject]
    }
    
}
