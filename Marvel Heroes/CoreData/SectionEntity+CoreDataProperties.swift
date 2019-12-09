//
//  SectionEntity+CoreDataProperties.swift
//  Marvel Heroes
//
//  Created by Никита on 07.12.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//
//

import Foundation
import CoreData


extension SectionEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SectionEntity> {
        return NSFetchRequest<SectionEntity>(entityName: "SectionEntity")
    }

    @NSManaged public var characterJsonString: String?
    @NSManaged public var comicsJsonString: String?
    @NSManaged public var creatorJsonString: String?
    @NSManaged public var eventJsonString: String?
    @NSManaged public var seriesJsonString: String?
    @NSManaged public var storyJsonString: String?

}
