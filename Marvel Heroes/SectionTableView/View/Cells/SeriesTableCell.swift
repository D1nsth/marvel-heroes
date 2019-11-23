//
//  SeriesTableCell.swift
//  Marvel Heroes
//
//  Created by Никита on 15.11.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import UIKit

class SeriesTableCell: UITableViewCell {

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
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.extraLabelFont
        label.numberOfLines = 0
        
        return label
    }()
    
    let mainImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(mainImage)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(ratingLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        mainImage.image = nil
    }
    
    // MARK: - configure
    func configure(series: Series) {
        titleLabel.text = series.title
        descriptionLabel.text = series.description
        ratingLabel.text = "Rating: \(series.rating)"
        
        downloadImage(from: series.imageURL)
        
        setConstraints()
    }
    
    private func downloadImage(from stringURL: String) {
        guard let url = URL(string: stringURL) else { return }
        
        NetworkService.shared.getImage(url: url) { (data, response, error) in
            guard let data = data, error == nil else { return }
            
            DispatchQueue.main.async() {
                self.mainImage.image = UIImage(data: data)
            }
        }
    }
    
    private func setConstraints() {
        mainImage.anchor(top: self.topAnchor,
                         leading: self.leadingAnchor,
                         bottom: nil,
                         trailing: nil,
                         padding: Constants.imageInsets)
        mainImage.heightAnchor.constraint(equalToConstant: Constants.imageSize.height).isActive = true
        mainImage.widthAnchor.constraint(equalToConstant: Constants.imageSize.width).isActive = true
        
        titleLabel.anchor(top: self.topAnchor,
                          leading: mainImage.trailingAnchor,
                          bottom: nil,
                          trailing: self.trailingAnchor,
                          padding: Constants.titleLabelInsets)
        
        descriptionLabel.anchor(top: titleLabel.bottomAnchor,
                                leading: mainImage.trailingAnchor,
                                bottom: nil,
                                trailing: self.trailingAnchor,
                                padding: Constants.descLabelInsets)
        
        ratingLabel.anchor(top: descriptionLabel.bottomAnchor,
                           leading: mainImage.trailingAnchor,
                           bottom: self.bottomAnchor,
                           trailing: self.trailingAnchor,
                           padding: Constants.extraLabelInsets)
    }
}
