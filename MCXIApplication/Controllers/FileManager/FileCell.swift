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
        containerView.layer.cornerRadius = 30
        return containerView
    }()
    
    private var imageBackground : UIImageView = {
        let imageBackground = UIImageView()
        imageBackground.translatesAutoresizingMaskIntoConstraints = false
        imageBackground.image = UIImage(named: "CollectionFile")
        imageBackground.layer.masksToBounds = true
        imageBackground.layer.cornerRadius = 30
        return imageBackground
    }()
    
    var nameFileLabel : UILabel = {
        let nameFileLabel = UILabel()
        nameFileLabel.text = "Name File.pdf"
        nameFileLabel.textColor = .white
        nameFileLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameFileLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameFileLabel
    }()
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.backgroundColor = .clear
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraints(){
        self.addSubview(containerView)
        containerView.addSubview(imageBackground)
        containerView.addSubview(nameFileLabel)
        containerView.addShadowView()
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 310),
            containerView.heightAnchor.constraint(equalToConstant: 200),
            imageBackground.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageBackground.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageBackground.widthAnchor.constraint(equalToConstant: 310),
            imageBackground.heightAnchor.constraint(equalToConstant: 200),
            
            nameFileLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            nameFileLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            
        ])
    }
}