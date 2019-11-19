//
//  CreatorsTableCell.swift
//  Marvel Heroes
//
//  Created by Никита on 15.11.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import UIKit

class CreatorsTableCell: UITableViewCell {
    
    let fullNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.titleLabelFont
        label.numberOfLines = 0
        
        return label
    }()
    
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(fullNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - configure
    func configure(creator: Creator) {
        fullNameLabel.text = creator.fullName
        
        setConstraints()
    }
    
    private func setConstraints() {
        fullNameLabel.anchor(top: self.topAnchor,
                             leading: self.leadingAnchor,
                             bottom: self.bottomAnchor,
                             trailing: self.trailingAnchor,
                             padding: Constants.titleLabelInsets)
    }
}
