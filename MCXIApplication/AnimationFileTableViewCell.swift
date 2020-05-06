//
//  AnimationFileTableViewCell.swift
//  CopriScopri
//
//  Created by Francesco Tito on 05/05/2020.
//  Copyright © 2020 Francesco Tito. All rights reserved.
//

import UIKit
import Lottie

class AnimationFileTableViewCell: UICollectionViewCell {

    private var animationView : AnimationView = {
        let animationView = AnimationView(name: "NoFile")
        animationView.alpha = 1
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        animationView.contentMode = .scaleAspectFit
        animationView.backgroundColor = .clear
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()
    
    private var labelDescription : UILabel = {
        let labelDescription = UILabel()
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        labelDescription.text = "Non ci sono file da leggere, inserisci file con il pulsante +"
        labelDescription.numberOfLines = 0
        labelDescription.font = UIFont(name :"Helvetica-Neue", size: 20)
        labelDescription.textColor = .darkGray
        labelDescription.textAlignment = .center
        return labelDescription
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        self.backgroundColor = .systemGray6
        setUpConstraint()
        animationView.play()
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraint(){
        addSubview(animationView)
        animationView.addSubview(labelDescription)
        NSLayoutConstraint.activate([
            
            animationView.centerXAnchor.constraint(equalTo: centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: centerYAnchor,constant: -100),

            labelDescription.bottomAnchor.constraint(equalTo: animationView.bottomAnchor, constant: -80),
            labelDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            labelDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            labelDescription.heightAnchor.constraint(equalToConstant: 80)
        
        ])
    }


}
