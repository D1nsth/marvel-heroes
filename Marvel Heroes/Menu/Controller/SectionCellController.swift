//
//  SectionCellController.swift
//  Marvel Heroes
//
//  Created by Никита on 14.11.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import UIKit

extension SectionCell {
    
    func switchState() {
        switch state {
        case .compressed:
            compressed()
        case .expanded:
            expanded()
        }
    }
        
    // MARK: - Animations cell
    
    func compressed() {
        guard let collectionView = self.collectionView else { return }
        
        animator.addAnimations {
            self.initialFrame = self.frame
            
            self.layer.cornerRadius = 0
            self.closeButton.alpha = 1
            self.sectionTableView.alpha = 1
            
            self.heightAnchorConstraint.constant = 120
            
            // скрываем видимые ячейки
            for visibleCell in collectionView.visibleCells {
                let cell = visibleCell as! SectionCell
                
                if cell.index != self.index {
                    cell.alpha = 0
                }
            }
            
            // задаём место для выбранной ячейки
            self.frame = CGRect(x: collectionView.contentOffset.x, y: collectionView.contentOffset.y, width: collectionView.frame.width, height: collectionView.frame.height)
            
            self.layoutIfNeeded()
        }
        
        animator.addCompletion { (position) in
            switch position {
            case .end:
                // подгружаем данные с сайта
                SectionsNetworkService.getSectionData(self.nameSection) { (response) in
                    self.dataArray = response.resultsArray as [AnyObject]
                    self.sectionTableView.reloadData()
                }
                
                self.state = self.state.change
                collectionView.isScrollEnabled = false
                collectionView.allowsSelection = false
            default:
                ()
            }
        }
        
        animator.startAnimation()
    }
    
    func expanded() {
        guard let collectionView = self.collectionView else { return }
        
        animator.addAnimations {
            self.layer.cornerRadius = self.cornerRadius
            self.closeButton.alpha = 0
            self.sectionTableView.alpha = 0
            
            self.heightAnchorConstraint.constant = 200
            
            // выбранной ячейке задётся первоначальная позиция
            self.frame = self.initialFrame!
            
            // делаем ячейки видимыми
            for visibleCell in collectionView.visibleCells {
                let cell = visibleCell as! SectionCell
                
                if cell.index != self.index {
                    cell.alpha = 1
                }
            }
            
            self.layoutIfNeeded()
        }
        
        animator.addCompletion { (position) in
            switch position {
            case .end:
                self.dataArray = []
                self.sectionTableView.reloadData()
                
                self.state = self.state.change
                collectionView.isScrollEnabled = true
                collectionView.allowsSelection = true
            default:
                ()
            }
        }
        
        animator.startAnimation()
    }
    
}

// MARK: - UITableViewDataSource

extension SectionCell: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "\(nameSection.getString())TableCell"
        
        switch nameSection! {
        case .CHARACTERS:
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? CharactersTableCell
            cell?.configure(character: dataArray![indexPath.row] as! Character)
            return cell!
            
        case .COMICS:
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? ComicsTableCell
            cell?.configure(comics: dataArray![indexPath.row] as! Comics)
            return cell!
            
        }
    }
    
}

// MARK: - UITableViewDelegate

extension SectionCell: UITableViewDelegate {
}

