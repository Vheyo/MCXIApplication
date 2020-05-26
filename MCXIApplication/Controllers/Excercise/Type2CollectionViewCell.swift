//
//  Type2CollectionViewCell.swift
//  AppStoreTransitionAnimation
//
//  Created by Razvan Chelemen on 15/05/2019.
//  Copyright © 2019 appssemble. All rights reserved.
//

import UIKit
import AppstoreTransition

class Type2CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 8
        containerView.clipsToBounds = true
        setUpLayout()
    }
    
    func setUpLayout(){
        titleLabel.textColor = .white
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        titleLabel.font = FontKit.roundedFont(ofSize: 28, weight: .bold)
        containerView.addShadowViewBest(isShadowPathEnabled: true, shadowColor: #colorLiteral(red: 0.5529411765, green: 0.4156862745, blue: 1, alpha: 1) , shadowRadius: 6.5, shadowOpacity: 0.3, offsetY: 6, offsetX: 0, widthOffset : 0.9)
        
    }

    // Make it appears very responsive to touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        animate(isHighlighted: true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        animate(isHighlighted: false)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        animate(isHighlighted: false)
    }
}

extension Type2CollectionViewCell: CardCollectionViewCell {
    
    var cardContentView: UIView {
        get {
            return containerView
        }
    }
    
}
