//
//  DropUpViewCollectionViewCell.swift
//  MCXIApplication
//
//  Created by Francesco Tito on 13/05/2020.
//  Copyright © 2020 Valentino Palomba. All rights reserved.
//

import UIKit

class DropUpViewCollectionViewCell: UICollectionViewCell {
    
    private var textLabel : UILabel = {
        let textLabel = UILabel()
        textLabel.textColor = .black
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textAlignment = .center
        return textLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        self.backgroundColor = .gray
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        setUpConstraints()
    }
    
    func setUpConstraints(){
        self.addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text : String){
        textLabel.text = text
    }
}
