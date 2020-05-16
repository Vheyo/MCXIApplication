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
        guard let superview = superview else { return }
        superview.addSubview(dropView)
        superview.bringSubviewToFront(dropView)
        setUpConstraints()
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            dropView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            dropView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        
        switch self.tag {
        case 1:
            dropView.bottomAnchor.constraint(equalTo: self.topAnchor).isActive = true
        case 2:
            dropView.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        default:
            print("Caso di Default di Merda")
        }
        
        height = dropView.heightAnchor.constraint(equalToConstant: 0)
    }
    
    var isOpen = false
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        let start : CGFloat! = 100
        let fine : CGFloat! = 0
        var changeCenter : CGFloat!
        switch self.tag {
        case 1:
            changeCenter = self.dropView.frame.height/2
        case 2:
            changeCenter = -self.dropView.frame.height/2
        default:
            print("Caso di Default di Merda")
        }
        if !isOpen{
            isOpen = true
            NSLayoutConstraint.deactivate([self.height])
            self.height.constant = start
            NSLayoutConstraint.activate([self.height])
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.dropView.layoutIfNeeded()
                self.dropView.center.y -= changeCenter
            }, completion: nil)
        }else{
            isOpen = false
            
            NSLayoutConstraint.deactivate([self.height])
            self.height.constant = fine
            NSLayoutConstraint.activate([self.height])
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.dropView.center.y += changeCenter
                self.dropView.layoutIfNeeded()
            }, completion: nil)
            
        }
    }
    
    func dropDownAfterPressed(){
        let fine : CGFloat! = 0
        var changeCenter : CGFloat!
        switch self.tag {
        case 1:
            changeCenter = self.dropView.frame.height/2
        case 2:
            changeCenter = -self.dropView.frame.height/2
        default:
            print("Caso di Default di Merda")
        }
        isOpen = false
        
        NSLayoutConstraint.deactivate([self.height])
        self.height.constant = fine
        NSLayoutConstraint.activate([self.height])
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.dropView.center.y += changeCenter
            self.dropView.layoutIfNeeded()
        }, completion: nil)
    }
    
}
