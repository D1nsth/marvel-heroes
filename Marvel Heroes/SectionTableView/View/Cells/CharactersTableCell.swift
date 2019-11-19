//
//  CharacterTableCell.swift
//  Marvel Heroes
//
//  Created by Никита on 14.11.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import UIKit

class CharactersTableCell: UITableViewCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.titleLabelFont
        label.numberOfLines = 0
        
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.descriptionFont
        label.numberOfLines = 0
        
        return label
    }()
    
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(nameLabel)
        addSubview(descriptionLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - configure
    func configure(character: Character) {
        nameLabel.text = character.name
        descriptionLabel.text = character.description
        
        setConstraints()
    }
    
    private func setConstraints() {
        nameLabel.anchor(top: self.topAnchor,
                         leading: self.leadingAnchor,
                         bottom: nil,
                         trailing: self.trailingAnchor,
                         padding: Constants.titleLabelInsets)
        
        descriptionLabel.anchor(top: self.nameLabel.bottomAnchor,
                                leading: self.leadingAnchor,
                                bottom: self.bottomAnchor,
                                trailing: self.trailingAnchor,
                                padding: Constants.descLabelInsets)
    }
}
