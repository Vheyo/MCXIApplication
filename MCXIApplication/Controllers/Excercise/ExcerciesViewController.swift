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
    let nameExcercises : [String] = ["Cover & Uncover", "Divergent Reading","WPM & CC"]
    let descriptionExcercises : [String] = ["The goal of this exercise is to increase your field of view and the speed of perception by looking in the middle of the screen highlighted by a line, a random customisable string will appear and you have to remember it. You can choose at least one of four options: Numbers, uppercase letters, lowercase letters and the number of characters. Selecting more than one option will make things harder! Set up the speed, in milliseconds, to which the string will appear. The default speed is 600ms. Either your answer right or wrong the exercise will be repeated until you decide to go back.", "Thanks to divergent reading you will be able to enlarge your field of view. As soon as you’ll click play, the screen will be in landscape mode, that’s because the goal is to have enough space to read every word on a single line. A random text will appear and, by looking to the center of the screen, you have to read all the words without moving your eyes. Clicking on “Increase” a string with an additional word will display and so on. ","Words Per Minute and comprehension coefficient calculator is the exercise which allows you to understand how many words per minute you can read and how much you understand while reading. You can choose between three different scripts, once you choose one you have to read the entire text, we calculate the wpm by multiplying the number of words for the time (in seconds) and then dividing per 60 seconds. Then you have to answer to 5 questions and the comprehension coefficient is the result of the percentage between correct and incorrect answers."]
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
        viewController.tagButton = indexPath.item
        viewController.descrip = descriptionExcercises[indexPath.item]
        
        // If `modalPresentationStyle` is not `.fullScreen`, this should be set to true to make status bar depends on presented vc.
        //viewController.modalPresentationCapturesStatusBarAppearance = true
        viewController.modalPresentationStyle = .custom
        
        presentExpansion(viewController, cell: cell, animated: true)
    }
    
}

extension ExcerciesViewController: CardsViewController {
    
}

extension UIView {

    func addShadowView(isShadowPathEnabled: Bool = true, shadowColor: UIColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6274509804, alpha: 1), shadowRadius: CGFloat = 7, shadowOpacity: Float = 0.5, shadowOffset: CGSize = CGSize(width: 0, height: 0)) -> ShadowView {
        let shadowView = ShadowView()
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.isShadowPathEnabled = isShadowPathEnabled
        shadowView.shadowColor = shadowColor
        shadowView.shadowRadius = shadowRadius
        shadowView.shadowOpacity = shadowOpacity
        shadowView.shadowOffset = shadowOffset
        shadowView.layer.compositingFilter = "multiplyBlendMode"
        shadowView.layer.cornerRadius = layer.cornerRadius
        superview?.insertSubview(shadowView, belowSubview: self)
        
        shadowView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        shadowView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1).isActive = true
        shadowView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        shadowView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 9.78).isActive = true
        
        return shadowView
    }
    
    func addShadowView2(isShadowPathEnabled: Bool = true, shadowColor: UIColor = .black, shadowRadius: CGFloat = 7, shadowOpacity: Float = 0.1, shadowOffset: CGSize = CGSize(width: 0, height: 0)) -> ShadowView {
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
        shadowView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 3.5).isActive = true
           
           return shadowView
       }
    
    
    func addShadowViewBest(isShadowPathEnabled: Bool = true, shadowColor: UIColor = .black, shadowRadius: CGFloat = 7, shadowOpacity: Float = 0.1, shadowOffset: CGSize = CGSize(width: 0, height: 0), offsetY : CGFloat, offsetX : CGFloat, heightOffset : CGFloat = 1, widthOffset : CGFloat = 1) -> ShadowView {
        let shadowView = ShadowView()
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.isShadowPathEnabled = isShadowPathEnabled
        shadowView.shadowColor = shadowColor
        shadowView.shadowRadius = shadowRadius
        shadowView.shadowOpacity = shadowOpacity
        shadowView.shadowOffset = shadowOffset
        shadowView.layer.cornerRadius = layer.cornerRadius
        shadowView.layer.compositingFilter = "multiplyBlendMode"
        superview?.insertSubview(shadowView, belowSubview: self)
        
        
        shadowView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: widthOffset).isActive = true
        shadowView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: heightOffset).isActive = true
        shadowView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: offsetX).isActive = true
        shadowView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: offsetY).isActive = true
        
        return shadowView
    }
    
    
}

