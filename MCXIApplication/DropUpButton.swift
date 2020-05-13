//
//  DropUpButton.swift
//  MCXIApplication
//
//  Created by Francesco Tito on 13/05/2020.
//  Copyright © 2020 Valentino Palomba. All rights reserved.
//

import UIKit

class DropUpButton: UIButton, dropUpProtocol{
    
    
    func dropUpPressed(string: String) {
        self.setTitle(string, for: .normal)
        self.dropDownAfterPressed()
    }
    
    
    private var dropView : DropUpView = {
        let dropView = DropUpView()
        dropView.backgroundColor = .clear
        dropView.translatesAutoresizingMaskIntoConstraints = false
        return dropView
    }()
    
    var height = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        dropView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        self.superview?.addSubview(dropView)
        self.superview?.bringSubviewToFront(dropView)
        setUpConstraints()
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            dropView.bottomAnchor.constraint(equalTo: self.topAnchor),
            dropView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            dropView.widthAnchor.constraint(equalTo: self.widthAnchor)
            
        ])
        
        height = dropView.heightAnchor.constraint(equalToConstant: 0)
    }
    
    var isOpen = false
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        if !isOpen{
            isOpen = true
            NSLayoutConstraint.deactivate([self.height])
            self.height.constant = 150
            NSLayoutConstraint.activate([self.height])
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.dropView.layoutIfNeeded()
                self.dropView.center.y -= self.dropView.frame.height/2
            }, completion: nil)
        }else{
            isOpen = false
            
            NSLayoutConstraint.deactivate([self.height])
            self.height.constant = 0
            NSLayoutConstraint.activate([self.height])
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.dropView.center.y += self.dropView.frame.height/2
                self.dropView.layoutIfNeeded()
            }, completion: nil)
            
        }
    }
    
    func dropDownAfterPressed(){
        isOpen = false
        
        NSLayoutConstraint.deactivate([self.height])
        self.height.constant = 0
        NSLayoutConstraint.activate([self.height])
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.dropView.center.y += self.dropView.frame.height/2
            self.dropView.layoutIfNeeded()
        }, completion: nil)
    }
    
}
