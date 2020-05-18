//
//  containerOfRadioButton.swift
//  MCXIApplication
//
//  Created by Francesco Tito on 18/05/2020.
//  Copyright © 2020 Valentino Palomba. All rights reserved.
//

import UIKit

class containerOfRadioButton: UIView {
    
    var onTap : (() -> Void)!
    var radioButton : RadioButton = {
        let radioButton = RadioButton()
        radioButton.isSelected = false
        radioButton.translatesAutoresizingMaskIntoConstraints = false
        return radioButton
    }()
    
    private var imageCheck : UIImageView = {
        let imageCheck = UIImageView()
        imageCheck.translatesAutoresizingMaskIntoConstraints = false
        imageCheck.image = UIImage(named: "Spunta_1")
        return imageCheck
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpConstraints()
        radioButton.onTap = {
            self.onTap?()
            self.imageCheck.transform = CGAffineTransform(scaleX: 0, y: 0)
            UIView.animate(withDuration: 0.2) {
                self.imageCheck.transform = .identity
            }
        }
        radioButton.onTap2 = {
            UIView.animate(withDuration: 0.2) {
                self.imageCheck.transform = CGAffineTransform(scaleX: 0, y: 0)
            }
        }
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraints(){
        self.addSubview(radioButton)
        self.addSubview(imageCheck)
        
        NSLayoutConstraint.activate([
        
            imageCheck.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10),
            imageCheck.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageCheck.topAnchor.constraint(equalTo: self.topAnchor),
            imageCheck.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -10),
            
            radioButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10),
            radioButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -10),
            radioButton.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            radioButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            
        
        ])
        
    }
    
}
