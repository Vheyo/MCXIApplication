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
    let nameImage  : [String] = ["Copri","Divergente","PameCR"]
    let nameExcercises : [String] = ["Copri e Scopri", "Lettura Divergente","PAM & CR"]
    private var transition: CardTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.navigationBar.shadowImage = UIImage()
        overrideUserInterfaceStyle = .light
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        view.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "Type2CollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "Type2CollectionViewCell")
//        self.title = "Excercises"
        let layout = (collectionView.collectionViewLayout as! UICollectionViewFlowLayout)
        let aspect : CGFloat = 1.2305
        let width : CGFloat =  400
        layout.itemSize = CGSize(width:width, height: width * aspect)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    override func viewWillDisappear(_ animated: Bool) {
        AppUtility.lockOrientation(.all)
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
        viewController.descrip = "The goal of this exercise is to increase your field of view and the speed of perception by looking in the middle of the screen highlighted by a line, a random customisable string will appear and you have to remember it. You can choose at least one of four options: Numbers, uppercase letters, lowercase letters and the number of characters. Selecting more than one option will make things harder! Set up the speed, in milliseconds, to which the string will appear. The default speed is 600ms. Either your answer right or wrong the exercise will be repeated until you decide to go back."
        
        // If `modalPresentationStyle` is not `.fullScreen`, this should be set to true to make status bar depends on presented vc.
        //viewController.modalPresentationCapturesStatusBarAppearance = true
        viewController.modalPresentationStyle = .custom
        
        presentExpansion(viewController, cell: cell, animated: true)
    }
    
}

extension ExcerciesViewController: CardsViewController {
    
}

extension UIView {

    func addShadowView(isShadowPathEnabled: Bool = true, shadowColor: UIColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6274509804, alpha: 1), shadowRadius: CGFloat = 7, shadowOpacity: Float = 0.5, shadowOffset: CGSize = CGSize(width: 0.3, height: 0.3)) -> ShadowView {
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
        shadowView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        shadowView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 9.78).isActive = true
        
        return shadowView
    }
    
    func addShadowView2(isShadowPathEnabled: Bool = true, shadowColor: UIColor = .black, shadowRadius: CGFloat = 7, shadowOpacity: Float = 0.1, shadowOffset: CGSize = CGSize(width: 0.3, height: 0.3)) -> ShadowView {
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
           shadowView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
           shadowView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 6).isActive = true
           
           return shadowView
       }
    
    func addShadowView3(isShadowPathEnabled: Bool = true, shadowColor: UIColor = .white, shadowRadius: CGFloat = 7, shadowOpacity: Float = 0.3, shadowOffset: CGSize = CGSize(width: 0.3, height: 0.5)) -> ShadowView {
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
        shadowView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 10).isActive = true
        
        return shadowView
    }
}

