//
//  MainCollectionView.swift
//  Marvel Heroes
//
//  Created by Никита on 11.11.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import UIKit

class MainCollectionView: UIViewController {
    
    private var collectionView: UICollectionView!
    
    // разделы в меню
    private let data: [Section] = [Section(.CHARACTERS, mainImageName: "\(NameSections.CHARACTERS.getString()).png"),
                           Section(.COMICS, mainImageName: "\(NameSections.COMICS.getString()).png")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
    }
    
    func setupCollectionView() {
        print("setupCollectionView")
        let flowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        
        // устанавливаем cell
        let nib = UINib(nibName: "SectionCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: SectionCell.reuseId)
        
        view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        collectionView.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 0)
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        // устанавливаем constraints
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension MainCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SectionCell.reuseId, for: indexPath) as! SectionCell
        
        cell.configure(section: data[indexPath.row], collectionView: collectionView, index: indexPath.row)
        
        return cell
    }
    
    // размеры cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width - 50, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.cellForItem(at: indexPath) as! SectionCell
        
        selectedCell.switchState()
    }
    
}
