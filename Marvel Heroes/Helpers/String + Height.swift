//
//  String + Height.swift
//  Marvel Heroes
//
//  Created by Никита on 19.11.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func height(width: CGFloat, font: UIFont) -> CGFloat {
        let textSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        
        let size = self.boundingRect(with: textSize,
                                     options: .usesLineFragmentOrigin,
                                     attributes: [NSAttributedString.Key.font : font],
                                     context: nil)
        
        return ceil(size.height)
    }
    
}
