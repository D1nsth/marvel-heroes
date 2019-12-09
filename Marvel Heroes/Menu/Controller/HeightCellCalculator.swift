//
//  HeightCellCalculator.swift
//  Marvel Heroes
//
//  Created by Никита on 20.11.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import UIKit

final class HeightCellCalculator {
    
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = UIScreen.main.bounds.width) {
        self.screenWidth = screenWidth
    }
    
    func totalHeightCell(with data: AnyObject, nameSection: NameSections) -> CGFloat {
        var heigth: CGFloat = 0
        switch nameSection {
        case .characters:
            let cell = data as! Character
            heigth = heightTitleLabelCell(with: cell.name)
            heigth += heightDescLabelCell(with: cell.description ?? "")
            
        case .comics:
            let cell = data as! Comics
            heigth = heightTitleLabelCell(with: cell.title)
            heigth += heightDescLabelCell(with: cell.description ?? "")
            
        case .creators:
            let cell = data as! Creator
            heigth = heightTitleLabelCell(with: cell.fullName)
            
        case .events:
            let cell = data as! Event
            heigth = heightTitleLabelCell(with: cell.title)
            heigth += heightDescLabelCell(with: cell.description ?? "")
            
        case .series:
            let cell = data as! Series
            heigth = heightTitleLabelCell(with: cell.title)
            heigth += heightDescLabelCell(with: cell.description ?? "")
            heigth += heightExtraLabelCell(with: cell.rating ?? "")
            
        case .stories:
            let cell = data as! Story
            heigth = heightTitleLabelCell(with: cell.title)
            heigth += heightDescLabelCell(with: cell.description ?? "")
            heigth += heightExtraLabelCell(with: cell.type ?? "")
        }
        
        let imageHeigth = Constants.imageSize.height + Constants.imageInsets.top + Constants.imageInsets.bottom
        let result = (heigth > imageHeigth) ? heigth : imageHeigth
        return result
    }
    
    private func heightTitleLabelCell(with labelText: String) -> CGFloat {
        var height: CGFloat = Constants.titleLabelInsets.top
        
        if let text: String = labelText, !text.isEmpty {
            let width = screenWidth - Constants.imageInsets.left - Constants.imageSize.width - Constants.titleLabelInsets.left - Constants.titleLabelInsets.right
            let labelFont = Constants.titleLabelFont
            
            height += text.height(width: width, font: labelFont)
        }
        
        return height
    }
    
    private func heightDescLabelCell(with labelText: String) -> CGFloat {
        var height: CGFloat = Constants.descLabelInsets.top + Constants.descLabelInsets.bottom
        
        if let text: String = labelText, !text.isEmpty {
            let width = screenWidth - Constants.imageInsets.left - Constants.imageSize.width - Constants.descLabelInsets.left - Constants.descLabelInsets.right
            let labelFont = Constants.descriptionFont
            
            height += text.height(width: width, font: labelFont)
        }
        
        return height
    }
    
    private func heightExtraLabelCell(with labelText: String) -> CGFloat {
        var height: CGFloat = Constants.extraLabelInsets.top + Constants.extraLabelInsets.bottom
        
        if let text: String = labelText, !text.isEmpty {
            let width = screenWidth - Constants.imageInsets.left - Constants.imageSize.width - Constants.descLabelInsets.left - Constants.descLabelInsets.right
            let labelFont = Constants.extraLabelFont
            
            height += text.height(width: width, font: labelFont)
        }
        
        return height
    }
    
}
