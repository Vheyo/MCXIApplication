//
//  CheckBox.swift
//  CopriScopri
//
//  Created by Francesco Tito on 03/05/2020.
//  Copyright © 2020 Francesco Tito. All rights reserved.
//

import UIKit

class CheckBox: UIButton {

    let checkedImage : UIColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
    let unCheckedImage : UIColor = .white
    var isChecked : Bool = false {
        didSet {
            if isChecked{
                self.backgroundColor = checkedImage
                self.setTitleColor(.white, for: .normal)
            }else{
                self.backgroundColor = unCheckedImage
                self.setTitleColor(#colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1), for: .normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.masksToBounds = true
        self.layer.borderWidth = 2
        self.layer.borderColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        self.layer.cornerRadius = 35
        self.backgroundColor = unCheckedImage
        self.setTitleColor(#colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1), for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func buttonClicked (_ sender : Any) {
        if isChecked {
            isChecked = false
        }else {
            isChecked = true
        }
    }
    
}
