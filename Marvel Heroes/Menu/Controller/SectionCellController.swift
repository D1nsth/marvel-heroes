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
                self.sectionTableView.alpha = 1
                
                self.state = self.state.change
                collectionView.isScrollEnabled = false
                collectionView.allowsSelection = false
            default:
                ()
            }
        }
        
        activityIndicator.startAnimating()
        
        // подгружаем данные с сайта
        SectionsNetworkService.getSectionData(self.nameSection, startIndex: 0) { (response) in
            self.dataArray = response.resultsArray as [AnyObject]
            self.sectionTableView.reloadData()
            self.footerView.setTitle("\(self.dataArray?.count ?? 0) записей")
            
            self.activityIndicator.stopAnimating()
            self.animator.startAnimation()
        }
        
    }
    
    func expanded() {
        guard let collectionView = self.collectionView else { return }
        
        animator.addAnimations {
            self.layer.cornerRadius = self.cornerRadius
            self.closeButton.alpha = 0
            
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
                self.sectionTableView.alpha = 0
                self.dataArray = []
                self.sectionTableView.reloadData()
                self.footerView.setTitle("0 записей")
                
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

// MARK: - UITableViewDataSource, UITableViewDelegate

extension SectionCell: UITableViewDataSource, UITableViewDelegate {
    
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
            
        case .CREATORS:
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? CreatorsTableCell
            cell?.configure(creator: dataArray![indexPath.row] as! Creator)
            return cell!
            
        case .EVENTS:
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? EventsTableCell
            cell?.configure(event: dataArray![indexPath.row] as! Event)
            return cell!
            
        case .SERIES:
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? SeriesTableCell
            cell?.configure(series: dataArray![indexPath.row] as! Series)
            return cell!
            
        case .STORIES:
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? StoriesTableCell
            cell?.configure(story: dataArray![indexPath.row] as! Story)
            return cell!
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return heightCellCalculator.totalHeightCell(with: dataArray![indexPath.row], nameSection: nameSection!)
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return heightCellCalculator.totalHeightCell(with: dataArray![indexPath.row], nameSection: nameSection!)
    }
    
    // MARK: - Scroll View Did End Dragging
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if scrollView.contentOffset.y > (scrollView.contentSize.height - 400) {
            footerView.showLoader()
            
            SectionsNetworkService.getSectionData(nameSection!, startIndex: dataArray!.count) { (response) in
                for obj in response.resultsArray as [AnyObject] {
                    self.dataArray?.append(obj)
                }
                
                self.sectionTableView.reloadData()
                self.footerView.setTitle("\(self.dataArray?.count ?? 0) записей")
            }
        }
        
    }
    
}
