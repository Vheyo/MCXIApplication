//
//  ExcerciesViewController.swift
//  MCXIApplication
//
//  Created by Valentino Palomba on 04/05/2020.
//  Copyright © 2020 Valentino Palomba. All rights reserved.
//

import Foundation
import UIKit
import AppstoreTransition

class ExcerciesViewController : UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let nameImage  : [String] = ["Copri","Divergente","Copri"]
    let nameExcercises : [String] = ["Copri e Scopri", "Lettura Divergente","PAM & CR"]
    private var transition: CardTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "Type2CollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "Type2CollectionViewCell")
        self.title = "Excercises"
        let layout = (collectionView.collectionViewLayout as! UICollectionViewFlowLayout)
        let aspect : CGFloat = 0.85
        let width : CGFloat =  400
        layout.itemSize = CGSize(width:width, height: width * aspect)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 0
    }
}

extension ExcerciesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell
        let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Type2CollectionViewCell", for: indexPath) as! Type2CollectionViewCell
        customCell.titleLabel.text = nameExcercises[indexPath.item]
        customCell.backgroundImage.image = UIImage(named: nameImage[indexPath.item])
        cell = customCell
        return cell
    }
    
}

extension ExcerciesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showType4(indexPath: indexPath, bottomDismiss: false)
    }
    
    
    private func showType4(indexPath: IndexPath, bottomDismiss: Bool = false) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "type2") as! Type2ViewController
        
        // Get tapped cell location
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        cell.settings.cardContainerInsets = UIEdgeInsets(top: 8.0, left: 16.0, bottom: 8.0, right: 16.0)
        cell.settings.isEnabledBottomClose = bottomDismiss
        
        transition = CardTransition(cell: cell, settings: cell.settings)
        viewController.settings = cell.settings
        viewController.transitioningDelegate = transition
        viewController.titleLabe = nameExcercises[indexPath.item]
        viewController.background = UIImage(named: nameImage[indexPath.item])
        viewController.tagButton = indexPath.row
        viewController.descrip = "fdfsdfasdfkndasfdskfbdskfbdsjkfbdsajkfbdsjfbdsfjkbdsjkfbdsjkfbdsjkfbdsjkfbdsjkfbdsjkfbdsjkfbdsjkfbdsjkfbdsjkfbdskjfbdsjkfbsdkjfbdsjkfbdsjkfbdsjkfbdsjkfbdsjkfbdsjkfbdsjfkbsdfjkdsbfjkdsbfjkdsfbdjksfbdsjkfbdsjkfbdsjkfbdsjkfbsdjkfbsdkjfbdsjkfbsdjkfbsdjfbdsfjkdsbfjkdsbfjakdsfbasdjkfbdskjfbdsjkfbsdjkfbsdjkfbadskjfbsdjkfbadsjkfbsdajkfbasdjkfbadsjkfbasdjkfbdsjkfjadksbfajksdfbjadksbfjkasdbfasjdkbfjkadsfbkdjsbfajksdfbdsjkfbdskjfbadsjkfbasdjkfbadskjfbasdkjfbasdkjfbasdkjfbsdkjfbasdjkfbasdjkfbaksdjfbasdkjfbasdjkfbadskjfbadsjkfbadskjfbasdjkfbasdjkfbadskjfbadskjfbasdjkfbadsjkfbdsakjfbasdkjfbdsajkfbjadskfbasdjkfbadsjkfbdsajkfbasdjkfbadsjkfbsdjkfasdbfjasdfbasdkfbadskjfbadsjkfbkjfbjkdsfbjkdfsbjkdfsbjkfdsbjkfdbjkdfsjbkfdsabjkdfsjbkdfsbjkdsbjdfsjbkjbkfdsjbkdfsbjkdfsjbkdsfbjkdfsjbkdfsjbkbjfdsjbkdfbjdfksjbdfsbjkdsfjbkdfsbjkdfbjkdfsbjkdfbjkdfsbjkdfsbjdfsbjkdfsjbkjkdfs"
        
        // If `modalPresentationStyle` is not `.fullScreen`, this should be set to true to make status bar depends on presented vc.
        //viewController.modalPresentationCapturesStatusBarAppearance = true
        viewController.modalPresentationStyle = .custom
        
        presentExpansion(viewController, cell: cell, animated: true)
    }
    
}

extension ExcerciesViewController: CardsViewController {
    
}

extension UIView {

    func addShadowView(isShadowPathEnabled: Bool = true, shadowColor: UIColor = .black, shadowRadius: CGFloat = 7, shadowOpacity: Float = 0.1, shadowOffset: CGSize = CGSize(width: 0.3, height: 0.3)) -> ShadowView {
        let shadowView = ShadowView()
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.isShadowPathEnabled = isShadowPathEnabled
        shadowView.shadowColor = shadowColor
        shadowView.shadowRadius = shadowRadius
        shadowView.shadowOpacity = shadowOpacity
        shadowView.shadowOffset = shadowOffset
        shadowView.layer.cornerRadius = layer.cornerRadius
        superview?.insertSubview(shadowView, belowSubview: self)
        
        shadowView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        shadowView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1).isActive = true
        shadowView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 10).isActive = true
        shadowView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 6).isActive = true
        
        return shadowView
    }
}

