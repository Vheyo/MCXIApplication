//
//  TextToAnswerCollectionViewCell.swift
//  MCXIApplication
//
//  Created by Francesco Tito on 08/05/2020.
//  Copyright © 2020 Valentino Palomba. All rights reserved.
//

import UIKit

class TextToAnswerCollectionViewCell: UICollectionViewCell {
    
    
    private var containerView : UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius =  15
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.borderColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        containerView.layer.borderWidth = 2
        return containerView
    }()
    
    private var titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Titolo del Testo"
        titleLabel.backgroundColor = .clear
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        return titleLabel
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                UIView.animate(withDuration: 0.5) {
                    self.transform = CGAffineTransform.identity
                    self.containerView.backgroundColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
                    self.titleLabel.textColor = .white
                }
            }
            else {
                UIView.animate(withDuration: 0.1) {
                    self.containerView.backgroundColor = .white
                    self.titleLabel.textColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraints(){
        self.addSubview(containerView)
        containerView.addShadowView2()
        containerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
        
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant:  10),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10)
        
        ])
        
        containerView.addShadowViewBest(isShadowPathEnabled: true, shadowColor: #colorLiteral(red: 0.5568627451, green: 0.4156862745, blue: 1, alpha: 1), shadowRadius: 4, shadowOpacity: 0.3,shadowOffset : CGSize(width: 0.8, height: 0.8),offsetY: 4, offsetX: 0)
        
        
    }
    
  

}
