//
//  SectionCell.swift
//  Marvel Heroes
//
//  Created by Никита on 11.11.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import UIKit
import CoreData

class SectionCell: UICollectionViewCell {
    var context: NSManagedObjectContext!
    var dataArray: [AnyObject]?
    
    static let reuseId = "SectionCell"
    
    var index: Int?
    
    let heightCellCalculator = HeightCellCalculator()
    let cornerRadius: CGFloat = 10
    
    var heightAnchorConstraint: NSLayoutConstraint!
    var collectionView: UICollectionView?
    var nameSection: NameSections!
    var state: StateCell = .compressed
    var initialFrame: CGRect?
    
    lazy var animator: UIViewPropertyAnimator = {
        return UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut)
    }()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var previewLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var sectionTableView: UITableView!
    
    lazy var footerView = FooterView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 45))
    
    // MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupConstraints()
    }
    
    // MARK: - Setup configures
    
    func configure(section: Section, collectionView: UICollectionView, index: Int) {
        context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        
        dataArray = []
        nameSection = NameSections.getEnum(byString: section.nameSection)
        
        self.collectionView = collectionView
        self.index = index
        
        previewImage.image = UIImage(named: section.mainImageName)
        previewLabel.text = section.nameSection
        
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        setupTableView()
    }
    
    // Устанавливаем constraint для previewView
    private func setupConstraints() {
        previewView.translatesAutoresizingMaskIntoConstraints = false
        
        previewView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        previewView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        previewView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        heightAnchorConstraint = previewView.heightAnchor.constraint(equalToConstant: 200)
        
        heightAnchorConstraint.isActive = true
    }
    
    // настраиваем table view
    private func setupTableView() {
        let usedCellName = "\(nameSection.getString())TableCell"
        var usedClass: AnyClass
        
        switch nameSection! {
        case .characters:
            usedClass = CharactersTableCell.self
        case .comics:
            usedClass = ComicsTableCell.self
        case .creators:
            usedClass = CreatorsTableCell.self
        case .events:
            usedClass = EventsTableCell.self
        case .series:
            usedClass = SeriesTableCell.self
        case .stories:
            usedClass = StoriesTableCell.self
        }
        
        sectionTableView.register(usedClass, forCellReuseIdentifier: usedCellName)
        
        sectionTableView.delegate = self
        sectionTableView.dataSource = self
        
        sectionTableView.translatesAutoresizingMaskIntoConstraints = false
        
        sectionTableView.topAnchor.constraint(equalTo: previewView.bottomAnchor).isActive = true
        sectionTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        sectionTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        sectionTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        sectionTableView.tableFooterView = footerView
    }
    
    // close button action
    @IBAction func close() {
        switchState()
    }
    
}
