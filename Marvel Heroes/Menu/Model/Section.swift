//
//  Section.swift
//  Marvel Heroes
//
//  Created by Никита on 11.11.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import Foundation

struct Section {
    var mainImageName: String
    var nameSection: String
    
    init(_ nameSection: NameSections, mainImageName: String) {
        self.mainImageName = mainImageName
        self.nameSection = nameSection.getString()
    }
}
