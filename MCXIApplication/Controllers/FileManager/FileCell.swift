//
//  FileCell.swift
//  Ready
//
//  Created by Astroworld on 04/05/2020.
//  Copyright © 2020 Valentino Palomba. All rights reserved.
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
        nameFileLabel.font = FontKit.roundedFont(ofSize: 22, weight: .semibold)
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
        
        containerView.addShadowViewBest(isShadowPathEnabled: true, shadowColor: #colorLiteral(red: 0.5568627451, green: 0.4156862745, blue: 1, alpha: 1), shadowRadius: 4, shadowOpacity: 0.3, offsetY: 4, offsetX: 0)
    }
}
