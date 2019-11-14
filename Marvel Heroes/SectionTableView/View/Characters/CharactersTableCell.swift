//
//  CharacterTableCell.swift
//  Marvel Heroes
//
//  Created by Никита on 14.11.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import UIKit

class CharactersTableCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    // MARK: - awakeFromNib
       
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(character: Character) {
        nameLabel.text = character.name
        descriptionLabel.text = character.description
    }
    
}
