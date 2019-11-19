//
//  StoriesTableCell.swift
//  Marvel Heroes
//
//  Created by Никита on 15.11.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import UIKit

class StoriesTableCell: UITableViewCell {

    let titleLabel: UILabel = {
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
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.extraLabelFont
        label.numberOfLines = 0
        
        return label
    }()
    
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(typeLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - configure
    func configure(story: Story) {
        titleLabel.text = story.title
        descriptionLabel.text = story.description
        typeLabel.text = "Type: \(story.type)"
        
        setConstraints()
    }
    
    private func setConstraints() {
        titleLabel.anchor(top: self.topAnchor,
                          leading: self.leadingAnchor,
                          bottom: nil,
                          trailing: self.trailingAnchor,
                          padding: Constants.titleLabelInsets)
        
        descriptionLabel.anchor(top: titleLabel.bottomAnchor,
                                leading: self.leadingAnchor,
                                bottom: nil,
                                trailing: self.trailingAnchor,
                                padding: Constants.descLabelInsets)
        
        typeLabel.anchor(top: descriptionLabel.bottomAnchor,
                           leading: self.leadingAnchor,
                           bottom: self.bottomAnchor,
                           trailing: self.trailingAnchor,
                           padding: Constants.extraLabelInsets)
    }
    
}
