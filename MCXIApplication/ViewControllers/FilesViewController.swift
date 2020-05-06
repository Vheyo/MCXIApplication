//
//  FilesViewController.swift
//  MCXIApplication
//
//  Created by Valentino Palomba on 04/05/2020.
//  Copyright © 2020 Valentino Palomba. All rights reserved.
//

import Foundation
import UIKit

class FilesViewController : UIViewController{
    
    
    private var noFile : Bool = true
    private var nameFile : [String] = []
    private var cardCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cardCollection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        cardCollection.showsVerticalScrollIndicator = false
        cardCollection.isScrollEnabled = true
        cardCollection.translatesAutoresizingMaskIntoConstraints = false
        cardCollection.backgroundColor = .white
        return cardCollection
    }()
    
    private var addButton : UIButton = {
        let addButton = UIButton()
        addButton.backgroundColor = .red
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.addTarget(self, action: #selector(addFileRecent), for: .touchUpInside)
        return addButton
    }()
    
    override func viewDidLoad() {
        cardCollection.delegate = self
        cardCollection.dataSource = self
        cardCollection.register(AnimationFileTableViewCell.self, forCellWithReuseIdentifier: "NoRecentFile")
        setUpConstraints()
    }
    
    func setUpConstraints(){
        view.addSubview(cardCollection)
        view.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addButton.widthAnchor.constraint(equalToConstant: 100),
            addButton.heightAnchor.constraint(equalToConstant: 100),
            addButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            
            cardCollection.topAnchor.constraint(equalTo: view.topAnchor),
            cardCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cardCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cardCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        
    }
    
    @objc func addFileRecent(_ sender : Any){
        noFile = false
        nameFile.append("ciao")
        cardCollection.reloadData()
    }
    
    
}

extension FilesViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var numberOfItem : Int = 0
        
        if noFile {
            numberOfItem = 1
        } else {
            numberOfItem = nameFile.count
        }
        
        return numberOfItem
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if noFile {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoRecentFile", for: indexPath) as! AnimationFileTableViewCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoRecentFile", for: indexPath) as! AnimationFileTableViewCell
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if noFile {
            return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        } else {
            return CGSize(width: 300, height: 300)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if noFile {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        } else {
            return UIEdgeInsets(top: 0, left: 2, bottom: 3, right: 2)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}

