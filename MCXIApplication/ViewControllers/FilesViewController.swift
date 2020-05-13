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
    
    var randtext : [[String]] = [["ciao bella","io","ti conosco","tu fumi cannella"],["ciao bella","io","ti conosco"],["ciao bella","io"]]
    fileprivate var currentPage: Int = 0 {
        didSet {
            tableView.reloadData()
        }
    }
    
    fileprivate var pageSize: CGSize {
        let layout = self.cardCollectionView.collectionViewLayout as! UPCarouselFlowLayout
        var pageSize = layout.itemSize
        if layout.scrollDirection == .horizontal {
            pageSize.width += layout.minimumLineSpacing
        } else {
            pageSize.height += layout.minimumLineSpacing
        }
        return pageSize
    }
    
    private var cardCollectionView : UICollectionView =  {
        let layout = UICollectionViewFlowLayout()
        let cardCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cardCollectionView.showsHorizontalScrollIndicator = false
        cardCollectionView.isScrollEnabled = true
        cardCollectionView.translatesAutoresizingMaskIntoConstraints = false
        cardCollectionView.backgroundColor = .red
        return cardCollectionView
    }()
    
    private var tableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardCollectionView.delegate = self
        cardCollectionView.dataSource = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellTable")
        cardCollectionView.register(FileCell.self, forCellWithReuseIdentifier: "CellId")
        setUpLayoutCardCollectionView()
        setUpConstraints()
        // Do any additional setup after loading the view.
    }
    
    func setUpLayoutCardCollectionView(){
        let layout = UPCarouselFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: view.frame.height/2)
        layout.scrollDirection = .horizontal
        layout.sideItemAlpha = 1
        layout.sideItemScale = 0.8
        layout.spacingMode = .fixed(spacing: 5)
        cardCollectionView.collectionViewLayout = layout
    }
    
    func setUpConstraints(){
        self.view.addSubview(cardCollectionView)
        self.view.addSubview(tableView)
        tableView.showsVerticalScrollIndicator = false
        NSLayoutConstraint.activate([
            
            cardCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            cardCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cardCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cardCollectionView.heightAnchor.constraint(equalToConstant: view.frame.height/2+150),
            
            tableView.topAnchor.constraint(equalTo: cardCollectionView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

extension FilesViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt
        indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath)
//        cell.backgroundColor = indexPath.item % 2 == 0 ? .red : .green
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width-120, height: view.frame.height/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
           let layout = self.cardCollectionView.collectionViewLayout as! UPCarouselFlowLayout
           let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
           let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
        currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
       }

}

extension FilesViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return randtext[currentPage].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTable", for: indexPath)
        cell.textLabel?.text = "\(randtext[currentPage][indexPath.row])"
        return cell
    }
}

extension FilesViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
