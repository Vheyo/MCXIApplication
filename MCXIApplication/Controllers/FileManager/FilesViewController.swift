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
    
    private var currentPage: Int = 0 {
        didSet {
            cardCollectionKeywords.reloadData()
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
        cardCollectionView.backgroundColor = .white
        return cardCollectionView
    }()
    
    private var notesLabel : UILabel = {
        let notesLabel = UILabel()
        notesLabel.translatesAutoresizingMaskIntoConstraints = false
        notesLabel.textColor =  #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        notesLabel.text = "Notes"
        notesLabel.font = UIFont.boldSystemFont(ofSize: 18)
        return notesLabel
    }()
    
    
    private var keyWordsLabel : UILabel = {
        let keyWordsLabel = UILabel()
        keyWordsLabel.translatesAutoresizingMaskIntoConstraints = false
        keyWordsLabel.textColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        keyWordsLabel.text = "Keywords"
        keyWordsLabel.font = UIFont.boldSystemFont(ofSize: 18)
        return keyWordsLabel
    }()
    
    
    
    //Ho aggiunto questo
    private var noFileImageView: UIImageView = {
        let image =  #imageLiteral(resourceName: "MissingFile")
        let noFileImageView = UIImageView(image: image)
        noFileImageView.translatesAutoresizingMaskIntoConstraints = false
        return noFileImageView
    }()
    
    private var noFileLabel: UILabel = {
        let noFileLabel = UILabel()
        noFileLabel.translatesAutoresizingMaskIntoConstraints = false
        noFileLabel.textColor =  #colorLiteral(red: 0.6979846954, green: 0.6980700493, blue: 0.6979557276, alpha: 1)
        noFileLabel.text = "There are no\nfiles Yet!"
        noFileLabel.font = FontKit.roundedFont(ofSize: CGFloat(30), weight: .bold)
        noFileLabel.textAlignment = .center
        noFileLabel.numberOfLines = 0
        return noFileLabel
    }()
    //--------------------------
    
    private var cardCollectionKeywords : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        let cardCollectionKeywords = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        cardCollectionKeywords.showsHorizontalScrollIndicator = false
        cardCollectionKeywords.isScrollEnabled = true
        cardCollectionKeywords.translatesAutoresizingMaskIntoConstraints = false
        cardCollectionKeywords.backgroundColor = .white
        return cardCollectionKeywords
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        self.title = "File Manager"
        view.backgroundColor = .white
        cardCollectionView.delegate = self
        cardCollectionView.dataSource = self
        cardCollectionView.register(FileCell.self, forCellWithReuseIdentifier: "CellId")
        cardCollectionKeywords.delegate = self
        cardCollectionKeywords.dataSource = self
        cardCollectionKeywords.register(KeywordsCollectionViewCell.self, forCellWithReuseIdentifier: "CellId2")
        setUpLayoutCardCollectionView()
        setUpConstraints()
        
       
       
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        var ListaFile = [String]()
        var ListaFileTxt = [String]()
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
               let url = NSURL(fileURLWithPath: path)
               let filePath = url.path
               let fileManager = FileManager.default
        ListaFile.append(contentsOf: try! fileManager.contentsOfDirectory(atPath: filePath!))
        for element in ListaFile {
            if element.contains("txt") == true{
                ListaFileTxt.append(element)
            }
        }
        print(ListaFileTxt.count)
        
        //Tito ho modificato qui
        if(ListaFile.count == 0){
            cardCollectionKeywords.removeFromSuperview()
            keyWordsLabel.removeFromSuperview()
            notesLabel.removeFromSuperview()
            cardCollectionView.removeFromSuperview()

            view.addSubview(noFileImageView)
            view.addSubview(noFileLabel)
            setUpConstraintInit()
        }else{
            noFileLabel.removeFromSuperview()
            noFileImageView.removeFromSuperview()
            self.viewDidLoad()
            
        }
        //-------------------------
        UserDefaults.standard.set(ListaFileTxt.count, forKey: "numFile")
        cardCollectionView.reloadData()
        cardCollectionKeywords.reloadData()
        AppUtility.lockOrientation(.portrait)
    }
    
    func setUpConstraintInit(){
        NSLayoutConstraint.activate([
            noFileImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            noFileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noFileImageView.heightAnchor.constraint(equalToConstant: 230),
            noFileImageView.widthAnchor.constraint(equalToConstant: 180),
        
            noFileLabel.topAnchor.constraint(equalTo: noFileImageView.bottomAnchor,constant: 20),
            noFileLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 80),
            noFileLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            noFileLabel.heightAnchor.constraint(equalToConstant: 100)
        
        ])
    }
    
    func setUpLayoutCardCollectionView(){
        let layout = UPCarouselFlowLayout()
        layout.itemSize = CGSize(width: 310, height: 220)
        layout.scrollDirection = .horizontal
        layout.sideItemAlpha = 0.8
        layout.sideItemScale = 0.8
        layout.spacingMode = .fixed(spacing: 5)
        cardCollectionView.collectionViewLayout = layout
    }
    
    func setUpConstraints(){
        self.view.addSubview(cardCollectionView)
        self.view.addSubview(notesLabel)
        self.view.addSubview(keyWordsLabel)
        self.view.addSubview(cardCollectionKeywords)
        NSLayoutConstraint.activate([
            
            notesLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 60),
            notesLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 20),
            notesLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            cardCollectionView.topAnchor.constraint(equalTo: notesLabel.bottomAnchor,constant: 10),
            cardCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cardCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cardCollectionView.heightAnchor.constraint(equalToConstant: 220),
            
            keyWordsLabel.topAnchor.constraint(equalTo: cardCollectionView.bottomAnchor, constant: 10),
            keyWordsLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 20),
            keyWordsLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            
            cardCollectionKeywords.topAnchor.constraint(equalTo: keyWordsLabel.bottomAnchor,constant: 10),
            cardCollectionKeywords.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cardCollectionKeywords.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cardCollectionKeywords.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

extension FilesViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var numberOfreturn : Int = 0
        if collectionView == cardCollectionView {
            numberOfreturn = UserDefaults.standard.integer(forKey: "numFile")
        }else {
            let arrayString = UserDefaults.standard.stringArray(forKey: "File \(currentPage)")
            numberOfreturn = arrayString?.count ?? 1
        }
        return numberOfreturn
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt
        indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == cardCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath)
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId2", for: indexPath) as! KeywordsCollectionViewCell
            cell.backgroundColor = .gray
            let arrayString = UserDefaults.standard.stringArray(forKey: "File \(currentPage)")
            cell.labelTitle.text = arrayString?[indexPath.item] ?? "No Keywords Inserted"
            return cell
            
        }
        return UICollectionViewCell()
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == cardCollectionView {
            loadReadingDeskFile(Item: indexPath.item)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size : CGSize = CGSize()
        if collectionView == cardCollectionKeywords{
            let arrayString = UserDefaults.standard.stringArray(forKey: "File \(currentPage)")
            let element = arrayString?[indexPath.item] ?? ("No Keywords Inserted" as NSString) as String
            let stringSize = element.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.0)])
            size = CGSize(width: stringSize.width+20, height: 30)
        }
        else {
            size = CGSize(width: 310, height: 220)
        }
        return size
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func loadReadingDeskFile(Item : Int){
        let vc = IntermediateReadingViewController()
        vc.textToRead.text = obtainTextFromFile(indexPath: Item+1)
        vc.modalPresentationStyle = .fullScreen
        present(vc,animated: true)
    }
    
    func obtainTextFromFile(indexPath: Int) -> String {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            let file = ("File\(indexPath).txt")
            let fileURL = dir.appendingPathComponent(file)
            
            do{
                let text = try String(contentsOf: fileURL, encoding: .utf8)
                print(text)
                return text
                
            }catch{
                print("cant read...")
            }
        }
        return "no text"
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        var spacing : CGFloat = 0
        if collectionView == cardCollectionView {
            spacing = 0
        }else {
            spacing = 10
        }
        return spacing
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout = self.cardCollectionView.collectionViewLayout as! UPCarouselFlowLayout
        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
        currentPage = Int(ceil((offset*(CGFloat(UserDefaults.standard.integer(forKey: "numFile"))))/(scrollView.contentSize.width)))
    }

}
