//
//  timerPickerView.swift
//  MCXIApplication
//
//  Created by Francesco Tito on 12/05/2020.
//  Copyright © 2020 Valentino Palomba. All rights reserved.
//

import UIKit

class timerPickerView: UIView{
    
    private var pickerTimer : UIPickerView = {
        let pickerTimer = UIPickerView()
        pickerTimer.translatesAutoresizingMaskIntoConstraints = false
        return pickerTimer
    }()
    
    var hour:Int = 0
    var minutes:Int = 0
    var seconds:Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        pickerTimer.delegate = self
        setUpConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraint(){
        self.addSubview(pickerTimer)
        
        pickerTimer.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        pickerTimer.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        pickerTimer.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        pickerTimer.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

    
}

extension timerPickerView:UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 25
        case 1,2:
            return 60
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.frame.size.width/3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(row) ore"
        case 1:
            return "\(row) min"
        case 2:
            return "\(row) sec"
        default:
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            hour = row
        case 1:
            minutes = row
        case 2:
            seconds = row
        default:
            break;
        }
    }
}
