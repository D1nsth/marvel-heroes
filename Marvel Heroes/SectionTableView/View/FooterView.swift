//
//  FooterView.swift
//  Marvel Heroes
//
//  Created by Никита on 16.11.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import UIKit

class FooterView: UIView {
    
    private var myLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        loader.color = .red
        return loader
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(myLabel)
        addSubview(loader)
        
        myLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        myLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        //myLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        myLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        loader.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loader.topAnchor.constraint(equalTo: myLabel.bottomAnchor, constant: 5).isActive = true
    }
    
    func showLoader() {
        loader.startAnimating()
    }
    
    func setTitle(_ title: String?) {
        loader.stopAnimating()
        myLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
