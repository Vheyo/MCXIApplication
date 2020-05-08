//
//  ShadowView.swift
//  MentalHealth
//
//  Created by Francesco Tito on 15/11/2019.
//  Copyright © 2019 Power Rangers. All rights reserved.
//

import UIKit

final class ShadowView: UIView {
    
    var shadowColor: UIColor = .black {
        didSet { update()}
    }
    var shadowRadius: CGFloat = 7 {
        didSet { update()}
    }
    var shadowOpacity: Float = 0.2 {
        didSet { update()}
    }
    var shadowOffset: CGSize = CGSize(width: 0, height: 3) {
        didSet { update()}
    }
    var isShadowPathEnabled: Bool = true {
        didSet {
            update()
            setNeedsLayout()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowPath = isShadowPathEnabled ? UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath : nil
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = false
        update()
    }
    
    private func update() {
        backgroundColor = isShadowPathEnabled ? .clear : UIColor.white //.withAlphaComponent(0.1)
        layer.shadowColor = shadowColor.cgColor
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffset
    }
}
