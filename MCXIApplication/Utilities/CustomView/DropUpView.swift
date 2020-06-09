//
//  DropUpView.swift
//  Ready
//
//  Created by Astroworld on 04/05/2020.
//  Copyright © 2020 Valentino Palomba. All rights reserved.
//

import UIKit

protocol dropUpProtocol : class {
    func dropUpPressed(string : String, isAltro : Bool)
}

class DropUpView : UIView{
    
    var timeToStart : [String] = ["1","2","3","4","5"]
    var WPM : [String] = ["250","500","750","1250","1500","1750","Altro"]
    weak var delegate : dropUpProtocol?
    
    var cardCollectionView : UICollectionView =  {
        let layout = UICollectionViewFlowLayout()
        let cardCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cardCollectionView.showsVerticalScrollIndicator = false
        cardCollectionView.isScrollEnabled = true
        cardCollectionView.translatesAutoresizingMaskIntoConstraints = false
        cardCollectionView.backgroundColor = .clear
        return cardCollectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setUpCardCollectionView()
        setUpLayoutCardCollectionView()
        setUpConstraints()
    }
    
    func setUpCardCollectionView(){
        cardCollectionView.delegate = self
        cardCollectionView.dataSource = self
        cardCollectionView.register(DropUpViewCollectionViewCell.self, forCellWithReuseIdentifier: "CellId")
    }
    
    func setUpLayoutCardCollectionView(){
        let layout = UPCarouselFlowLayout()
        layout.itemSize = CGSize(width: 70, height: 70)
        layout.scrollDirection = .vertical
        layout.sideItemAlpha = 0
        layout.sideItemScale = 0.6
        layout.spacingMode = .fixed(spacing: 3)
        cardCollectionView.collectionViewLayout = layout
    }
    
    func setUpConstraints(){
        self.addSubview(cardCollectionView)
        NSLayoutConstraint.activate([
            
            cardCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            cardCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cardCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            cardCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            
        ])
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension DropUpView : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var numberOfItem = 0;
        switch self.tag {
        case 1:
            numberOfItem = timeToStart.count
        case 2:
            numberOfItem = WPM.count
        default :
            print("Case Default")
        }
        return numberOfItem
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt
        indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath) as! DropUpViewCollectionViewCell
        
        switch self.tag {
        case 1:
            cell.configure(text: timeToStart[indexPath.item])
        case 2:
            cell.configure(text: WPM[indexPath.item])
        default :
            print("Case Default")
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        switch self.tag {
              case 1:
                self.delegate?.dropUpPressed(string: timeToStart[indexPath.item],isAltro: false)
              case 2:
                if WPM[indexPath.item] == "Altro"{
                    self.delegate?.dropUpPressed(string: WPM[indexPath.item],isAltro: true)
                }else {
                    self.delegate?.dropUpPressed(string: WPM[indexPath.item],isAltro: false)
                }
              default :
                  print("Case Default")
              }
        
    }
    
}
