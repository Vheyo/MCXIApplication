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
    
    private var transition: CardTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "Type2CollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "Type2CollectionViewCell")
        
        let layout = (collectionView.collectionViewLayout as! UICollectionViewFlowLayout)
        let aspect: CGFloat = 1.272
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width:width, height: width * aspect)
        layout.minimumLineSpacing = 0
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
        customCell.titleLabel.text = "Nome dell'esercizio"
        customCell.subtitleLabel.text = "Descrizione"
        customCell.backgroundImage.image = UIImage(named: "pioggia")
        cell = customCell
        return cell
    }
    
}

extension ExcerciesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showType4(indexPath: indexPath, bottomDismiss: true)
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
        viewController.titleLabe = "Nome dell'esercizio"
        viewController.subtitle = "Descrizione"
        viewController.background = UIImage(named: "pioggia")
        
        // If `modalPresentationStyle` is not `.fullScreen`, this should be set to true to make status bar depends on presented vc.
        //viewController.modalPresentationCapturesStatusBarAppearance = true
        viewController.modalPresentationStyle = .custom
        
        presentExpansion(viewController, cell: cell, animated: true)
    }
    
}

extension ExcerciesViewController: CardsViewController {
    
}

