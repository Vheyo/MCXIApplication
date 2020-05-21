//
//  KeywordsCollectionViewCell.swift
//  provaCelleDinamiche
//
//  Created by Francesco Tito on 21/05/2020.
//  Copyright © 2020 Francesco Tito. All rights reserved.
//

import UIKit

class KeywordsCollectionViewCell: UICollectionViewCell {
    
    var labelTitle : UILabel = {
        let labelTitle = UILabel()
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.textAlignment = .center
        return labelTitle
    }()
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        self.layer.cornerRadius = 15
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpConstraints(){
        self.contentView.addSubview(labelTitle)
        
        NSLayoutConstraint.activate([
        
            labelTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            labelTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            labelTitle.topAnchor.constraint(equalTo: contentView.topAnchor),
            labelTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        
        
        ])
        
    }
    
}

