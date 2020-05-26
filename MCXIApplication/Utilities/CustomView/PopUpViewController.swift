//
//  PopUpViewController.swift
//  Ready
//
//  Created by Astroworld on 04/05/2020.
//  Copyright © 2020 Valentino Palomba. All rights reserved.
//

import UIKit

class PopUpViewController: UIView {
    
    let popUpView : UIView = {
        let popUpView = UIView()
        popUpView.backgroundColor = .white
        popUpView.layer.cornerRadius = 12
        popUpView.layer.borderColor = UIColor.gray.cgColor
        popUpView.layer.borderWidth = 1
        popUpView.translatesAutoresizingMaskIntoConstraints = false
        return popUpView
    }()
    
    let suggestLabel : UILabel = {
        let suggestLabel = UILabel()
        suggestLabel.textColor = .darkGray
        suggestLabel.adjustsFontForContentSizeCategory = true
        suggestLabel.translatesAutoresizingMaskIntoConstraints = false
        suggestLabel.textAlignment = .center
        return suggestLabel
    }()

    override init(frame: CGRect) {
        super.init(frame : frame)
        self.frame = UIScreen.main.bounds
        setUpConstraints()
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateOut)))
        animateIn()
        self.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpConstraints(){
        addSubview(popUpView)
        popUpView.addSubview(suggestLabel)
        NSLayoutConstraint.activate([
            
            popUpView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            popUpView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            popUpView.heightAnchor.constraint(equalToConstant: 100),
            popUpView.widthAnchor.constraint(equalToConstant: 200),
            
            suggestLabel.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor,constant: 16),
            suggestLabel.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor,constant: -16),
            suggestLabel.centerYAnchor.constraint(equalTo: popUpView.centerYAnchor, constant: 0),
            suggestLabel.heightAnchor.constraint(equalToConstant: 60)
            
        ])
    }
        
    @objc func animateOut() {
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.popUpView.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
        }) { (complete) in
            if complete {
                self.removeFromSuperview()
            }
        }
    }
    
    func animateIn(){
        self.popUpView.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
        self.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.popUpView.transform = .identity
            self.alpha = 1
        })
        
    }
    
    
    

}

