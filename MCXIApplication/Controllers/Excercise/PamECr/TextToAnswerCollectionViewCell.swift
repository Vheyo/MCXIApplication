//
//  TextToAnswerCollectionViewCell.swift
//  MCXIApplication
//
//  Created by Francesco Tito on 08/05/2020.
//  Copyright © 2020 Valentino Palomba. All rights reserved.
//

import UIKit

class TextToAnswerCollectionViewCell: UICollectionViewCell {
    var nameImage : [String] = ["PamCrRomaV","PamCrMedic","PamCrAmerica"]
    var nameImageBianche : [String] = ["PamCrRomaW","PamCrMedicBianca","PamCrAmericaBianca"]
    private var containerView : UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius =  15
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.masksToBounds = true
        return containerView
    }()
    
    var containerImage : UIImageView = {
        let containerImage = UIImageView()
        containerImage.translatesAutoresizingMaskIntoConstraints = false
        containerImage.layer.masksToBounds = true
        containerImage.contentMode = .scaleAspectFill
        return containerImage
    }()
    
    private var titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Titolo del Testo"
        titleLabel.backgroundColor = .clear
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.font = FontKit.roundedFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = #colorLiteral(red: 0.5568627451, green: 0.4156862745, blue: 1, alpha: 1)
        return titleLabel
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                UIView.animate(withDuration: 0.5) {
                    self.transform = CGAffineTransform.identity
                    self.titleLabel.textColor = .white
                    self.containerImage.image = UIImage(named: self.nameImage[self.containerImage.tag])
                }
            }
            else {
                UIView.animate(withDuration: 0.1) {
                    self.titleLabel.textColor = #colorLiteral(red: 0.5568627451, green: 0.4156862745, blue: 1, alpha: 1)
                    self.containerImage.image = UIImage(named: self.nameImageBianche[self.containerImage.tag])
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
        

        containerView.addSubview(containerImage)
        containerImage.addSubview(titleLabel)
        containerView.addShadowViewBest(isShadowPathEnabled: true, shadowColor: #colorLiteral(red: 0.5529411765, green: 0.4156862745, blue: 1, alpha: 1) , shadowRadius: 6.5, shadowOpacity: 0.3, offsetY: 5, offsetX: 0, widthOffset : 0.9)
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: self.topAnchor,  constant: 10),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            containerImage.topAnchor.constraint(equalTo: containerView.topAnchor),
            containerImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            containerImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            containerImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            
            titleLabel.centerYAnchor.constraint(equalTo: containerImage.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: containerImage.leadingAnchor,constant:  10),
            titleLabel.trailingAnchor.constraint(equalTo: containerImage.trailingAnchor, constant: -10)
        
        ])
        
        
    }
    
  
  

}
