//
//  RadioButton.swift
//  Ready
//
//  Created by Astroworld on 04/05/2020.
//  Copyright © 2020 Valentino Palomba. All rights reserved.
//

import Foundation
import UIKit

protocol insertCheckInButton : class {
    func insertCheck()
}

class RadioButton: UIButton {
    var alternateButton:Array<RadioButton>?
    var onTap : (() -> Void)!
    var onTap2 : (() -> Void)!
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        self.layer.cornerRadius = 5
        self.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        self.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func unselectAlternateButtons() {
        if alternateButton != nil {
            self.isSelected = true

            for aButton:RadioButton in alternateButton! {
                aButton.isSelected = false
            }
        } else {
            toggleButton()
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        unselectAlternateButtons()
        super.touchesBegan(touches, with: event)
    }

    func toggleButton() {
        self.isSelected = !isSelected
    }

    override var isSelected: Bool {
        didSet {
            if isSelected {
                onTap?()
            } else {
                onTap2?()
            }
        }
    }
}

extension RadioButton {
    func oneSelected () -> (Bool,RadioButton) {
        if self.isSelected == true {
            return (true,self)
        }
        
        for aButton:RadioButton in alternateButton! {
            if aButton.isSelected == true {
                return (true,aButton)
            }
        }
        
        return (false,RadioButton())
    }
}
