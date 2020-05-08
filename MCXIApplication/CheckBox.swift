//
//  CheckBox.swift
//  CopriScopri
//
//  Created by Francesco Tito on 03/05/2020.
//  Copyright © 2020 Francesco Tito. All rights reserved.
//

import UIKit

class CheckBox: UIButton {

    let checkedImage : UIColor = .red
    let unCheckedImage : UIColor = .white
    var isChecked : Bool = false {
        didSet {
            if isChecked{
                self.backgroundColor = checkedImage
            }else{
                self.backgroundColor = unCheckedImage
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
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
