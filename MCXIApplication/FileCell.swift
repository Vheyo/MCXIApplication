//
//  FileCell.swift
//  pagingProva
//
//  Created by Francesco Tito on 13/05/2020.
//  Copyright © 2020 Francesco Tito. All rights reserved.
//

import UIKit

class FileCell: UICollectionViewCell {
    
    private var containerView : UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .yellow
        containerView.layer.borderColor = UIColor.red.cgColor
        containerView.layer.cornerRadius = 12
        containerView.layer.borderWidth = 2
        return containerView
    }()
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.backgroundColor = .green
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraints(){
        self.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: self.frame.width-80),
            containerView.heightAnchor.constraint(equalToConstant: self.frame.height-60)
            
        ])
    }
}
