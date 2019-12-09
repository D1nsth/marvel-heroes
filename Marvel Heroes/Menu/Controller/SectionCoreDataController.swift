//
//  SectionCoreDataController.swift
//  Marvel Heroes
//
//  Created by Никита on 08.12.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import UIKit
import CoreData

extension SectionCell {
    
    func loadFromNetwork() {
        SectionsNetworkService.getSectionData(nameSection, startIndex: 0) { (response) in
            self.dataArray = response.resultsArray as [AnyObject]
            self.sectionTableView.reloadData()
            self.footerView.setTitle("\(self.dataArray?.count ?? 0) записей")
            
            self.updateSectionData()
            
            self.activityIndicator.stopAnimating()
            self.animator.startAnimation()
        }
    }
    
    // загрузка данных с бд, если их нет, то с сайта
    func retrieveSectionData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SectionEntity")
        
        do {
            let result = try context.fetch(fetchRequest)
            let data = result[0] as! NSManagedObject
            
            switch nameSection! {
            case .characters:
                
                let stringCharacter = data.value(forKey: AttributesSectionEntity.characterJsonString.getString()) as! String
                if (stringCharacter != "") {
                    
                    let stringData = stringCharacter.data(using: .utf8)!
                    dataArray = try! JSONDecoder().decode([Character].self, from: stringData) as [AnyObject]
                    
                    openingSection()
                } else {
                    loadFromNetwork()
                }
                
            case .comics:
                
                let stringComics = data.value(forKey: AttributesSectionEntity.comicsJsonString.getString()) as! String
                if (stringComics != "") {
                    let stringData = stringComics.data(using: .utf8)!
                    dataArray = try! JSONDecoder().decode([Comics].self, from: stringData) as [AnyObject]
                    
                    openingSection()
                } else {
                    loadFromNetwork()
                }
                
            case .creators:
                
                let stringCreators = data.value(forKey: AttributesSectionEntity.creatorJsonString.getString()) as! String
                if (stringCreators != "") {
                    let stringData = stringCreators.data(using: .utf8)!
                    dataArray = try! JSONDecoder().decode([Creator].self, from: stringData) as [AnyObject]
                    
                    openingSection()
                } else {
                    loadFromNetwork()
                }
                
            case .events:
                
                let stringEvents = data.value(forKey: AttributesSectionEntity.eventJsonString.getString()) as! String
                if (stringEvents != "") {
                    let stringData = stringEvents.data(using: .utf8)!
                    dataArray = try! JSONDecoder().decode([Event].self, from: stringData) as [AnyObject]
                    
                    openingSection()
                } else {
                    loadFromNetwork()
                }
                
            case .series:
                
                let stringSeries = data.value(forKey: AttributesSectionEntity.seriesJsonString.getString()) as! String
                if (stringSeries != "") {
                    let stringData = stringSeries.data(using: .utf8)!
                    dataArray = try! JSONDecoder().decode([Series].self, from: stringData) as [AnyObject]
                    
                    openingSection()
                } else {
                    loadFromNetwork()
                }
                
            case .stories:
                
                let stringStories = data.value(forKey: AttributesSectionEntity.storyJsonString.getString()) as! String
                if (stringStories != "") {
                    let stringData = stringStories.data(using: .utf8)!
                    dataArray = try! JSONDecoder().decode([Story].self, from: stringData) as [AnyObject]
                    
                    openingSection()
                } else {
                    loadFromNetwork()
                }
                
            }
            
        } catch let error as NSError {
            print("\(error), \(error.userInfo)")
        }
    }
    
    func openingSection() {
        sectionTableView.reloadData()
        footerView.setTitle("\(dataArray?.count ?? 0) записей")
        activityIndicator.stopAnimating()
        animator.startAnimation()
    }
    
    // обновление данных в бд
    func updateSectionData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SectionEntity")
        
        do {
            let result = try context.fetch(fetchRequest)
            let data = result[0] as! NSManagedObject
            
            switch nameSection! {
                
            case .characters:
                
                let stringData = try! JSONEncoder().encode(dataArray as! [Character])
                let stringCharacter = String(data: stringData, encoding: .utf8)
                
                data.setValue(stringCharacter, forKey: AttributesSectionEntity.characterJsonString.getString())
                
            case .comics:
                
                let stringData = try! JSONEncoder().encode(dataArray as! [Comics])
                let stringComics = String(data: stringData, encoding: .utf8)
                
                data.setValue(stringComics, forKey: AttributesSectionEntity.comicsJsonString.getString())
                
            case .creators:
                
                let stringData = try! JSONEncoder().encode(dataArray as! [Creator])
                let stringCreators = String(data: stringData, encoding: .utf8)
                
                data.setValue(stringCreators, forKey: AttributesSectionEntity.creatorJsonString.getString())
                
            case .events:
                
                let stringData = try! JSONEncoder().encode(dataArray as! [Event])
                let stringEvents = String(data: stringData, encoding: .utf8)
                
                data.setValue(stringEvents, forKey: AttributesSectionEntity.eventJsonString.getString())
                
            case .series:
                
                let stringData = try! JSONEncoder().encode(dataArray as! [Series])
                let stringSeries = String(data: stringData, encoding: .utf8)
                
                data.setValue(stringSeries, forKey: AttributesSectionEntity.seriesJsonString.getString())
                
            case .stories:
                
                let stringData = try! JSONEncoder().encode(dataArray as! [Story])
                let stringStories = String(data: stringData, encoding: .utf8)
                
                data.setValue(stringStories, forKey: AttributesSectionEntity.storyJsonString.getString())

            }
            
            try context.save()
            
        } catch let error as NSError {
            print("\(error), \(error.userInfo)")
        }
    }
    
}
