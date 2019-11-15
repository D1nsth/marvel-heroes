//
//  CreatorsTableCell.swift
//  Marvel Heroes
//
//  Created by Никита on 15.11.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import UIKit

class CreatorsTableCell: UITableViewCell {
    
    @IBOutlet weak var fullNameLabel: UILabel!
    
    // MARK: - awakeFromNib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(creator: Creator) {
        fullNameLabel.text = creator.fullName
    }
}
