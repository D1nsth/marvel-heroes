//
//  StateCell.swift
//  Marvel Heroes
//
//  Created by Никита on 11.11.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import Foundation

enum StateCell {
    case expanded
    case compressed
    
    var change: StateCell {
        switch self {
        case .expanded:
            return .compressed
        case .compressed:
            return .expanded
        }
    }
}
