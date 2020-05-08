//
//  PopUpViewController.swift
//  CopriScopri
//
//  Created by Francesco Tito on 03/05/2020.
//  Copyright © 2020 Francesco Tito. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpConstraints()
        showAnimate()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        
    }
    
    func setUpConstraints(){
        view.addSubview(popUpView)
        popUpView.addSubview(suggestLabel)
        NSLayoutConstraint.activate([
            
            popUpView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            popUpView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popUpView.heightAnchor.constraint(equalToConstant: 100),
            popUpView.widthAnchor.constraint(equalToConstant: 200),
            
            suggestLabel.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor,constant: 16),
            suggestLabel.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor,constant: -16),
            suggestLabel.centerYAnchor.constraint(equalTo: popUpView.centerYAnchor, constant: 0),
            suggestLabel.heightAnchor.constraint(equalToConstant: 60)
            
        ])
    }
    
    func showAnimate(){
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0;
        UIView.animate(withDuration: 0.70, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1, y: 1)
        }) { (_) in
            UIView.animate(withDuration: 0.70, animations: {
                self.view.alpha = 0;
                self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            }) { (finished) in
                if finished {
                    self.view.removeFromSuperview()
                }
            }
        }
    }
    
    
    

}

