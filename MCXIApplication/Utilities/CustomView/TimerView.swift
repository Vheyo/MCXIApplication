//
//  TimerView.swift
//  MCXIApplication
//
//  Created by Francesco Tito on 16/05/2020.
//  Copyright © 2020 Valentino Palomba. All rights reserved.
//

import UIKit

class TimerView: UIView{

    var labelTime : UILabel = {
        let labelTime = UILabel()
        labelTime.translatesAutoresizingMaskIntoConstraints = false
        labelTime.text = "5"
        labelTime.font = UIFont.boldSystemFont(ofSize: 70)
        labelTime.textColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        return labelTime
    }()
    
    var onTap : (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        self.backgroundColor = .white
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView(){
        self.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        self.addSubview(labelTime)
        
        NSLayoutConstraint.activate([
        
            labelTime.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            labelTime.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        
        ])
    }
    
    func goTimer(){
        var initialTimer = 2
        self.labelTime.text = "\(initialTimer)"
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {timer in
            initialTimer -= 1
            self.labelTime.text = "\(initialTimer)"
            if initialTimer == -1 {
                self.onTap?()
                timer.invalidate()
            }
        })

    }
    
    
}
