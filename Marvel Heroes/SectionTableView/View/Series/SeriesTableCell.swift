//
//  SeriesTableCell.swift
//  Marvel Heroes
//
//  Created by Никита on 15.11.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import UIKit

class SeriesTableCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    // MARK: - awakeFromNib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(series: Series) {
        titleLabel.text = series.title
        descriptionLabel.text = series.description
        ratingLabel.text = "Rating: \(series.rating)"
    }
}
