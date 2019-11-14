//
//  ComicsTableCell.swift
//  Marvel Heroes
//
//  Created by Никита on 14.11.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import UIKit

class ComicsTableCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - awakeFromNib
       
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(comics: Comics) {
        titleLabel.text = comics.title
        descriptionLabel.text = comics.description
    }
    
}
