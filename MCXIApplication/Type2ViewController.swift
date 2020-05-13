//
//  Type2ViewController.swift
//  AppStoreTransitionAnimation
//
//  Created by Razvan Chelemen on 15/05/2019.
//  Copyright © 2019 appssemble. All rights reserved.
//

import UIKit
import AppstoreTransition
var numeroText = Int()
class Type2ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var descriptionExercise: UITextView!
    
    var subtitle: String? = nil
    var background: UIImage? = nil
    var titleLabe : String? = nil
    var tagButton : Int? = nil
    var descrip : String? = nil
    
    private var buttonPlay : UIButton = {
        let buttonPlay = UIButton()
        buttonPlay.setTitle("Play", for: .normal)
        buttonPlay.translatesAutoresizingMaskIntoConstraints = false
        buttonPlay.setTitleColor(.darkGray, for: .normal)
        buttonPlay.addTarget(self, action: #selector(showExcercise), for: .touchUpInside)
        return buttonPlay
    }()
    
    
    private var cardCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cardCollection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        cardCollection.showsVerticalScrollIndicator = false
        cardCollection.isScrollEnabled = false
        cardCollection.translatesAutoresizingMaskIntoConstraints = false
        cardCollection.backgroundColor = .clear
        return cardCollection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.clipsToBounds = true
        contentScrollView.delegate = self
        
        scrollView.contentInsetAdjustmentBehavior = .never
        
        let _ = dismissHandler
        if let subtitle = subtitle {
            subtitleLabel.text = subtitle
        }
        if let background = background {
            backgroundImage.image = background
        }
        if let titleLabe = titleLabe {
            titleLabel.text = titleLabe
        }
        if let tagButton = tagButton {
            buttonPlay.tag = tagButton
        }
        if let descrip = descrip {
            descriptionExercise.text = descrip
        }
        
        if tagButton == 2 {
            setUpConstraintsForThirdExcercise()
        }   else {
            setUpConstraintsForFirstSecondExcercise()
            setUpLayoutButtonPlay()
        }
            
        heightConstraint.constant = UIScreen.main.bounds.width * 1.272 - 16.0
    }
    
    func setUpConstraintsForFirstSecondExcercise(){
        contentView.addSubview(buttonPlay)
        
        NSLayoutConstraint.activate([
            descriptionExercise.heightAnchor.constraint(equalToConstant: 200),
            
            
            buttonPlay.topAnchor.constraint(equalTo: descriptionExercise.bottomAnchor, constant: 20),
            buttonPlay.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            buttonPlay.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            buttonPlay.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            buttonPlay.heightAnchor.constraint(equalToConstant: 80)
            
        ])
    }
    
    func setUpConstraintsForThirdExcercise(){
        cardCollection.delegate = self
        cardCollection.dataSource = self
        cardCollection.register(TextToAnswerCollectionViewCell.self, forCellWithReuseIdentifier: "CellId")
        contentView.addSubview(cardCollection)
        
        NSLayoutConstraint.activate([
            descriptionExercise.heightAnchor.constraint(equalToConstant: 200),
            
            
            cardCollection.topAnchor.constraint(equalTo: descriptionExercise.bottomAnchor, constant: 30),
            cardCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cardCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cardCollection.heightAnchor.constraint(equalToConstant: 3*80+3*10)
        ])
    }
    
    func setUpLayoutButtonPlay(){
        descriptionExercise.isEditable = false
        buttonPlay.layer.cornerRadius = 13
        buttonPlay.backgroundColor  = .white
        buttonPlay.addShadowView()
    }
    
    @objc func showExcercise(_ sender : UIButton){
        print(sender.tag)
        switch sender.tag{
        case 0:
            performSegue(withIdentifier: "CopriEScopri", sender: self);
        case 1:
            performSegue(withIdentifier: "Rombo", sender: self);
        default :
            print("Fatal error");
    }
    

    }
}

extension Type2ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // prevent bouncing when swiping down to close
        scrollView.bounces = scrollView.contentOffset.y > 100
        
        dismissHandler.scrollViewDidScroll(scrollView)
    }
    
}

extension Type2ViewController: CardDetailViewController {
   
    
    
    var scrollView: UIScrollView {
        return contentScrollView
    }
    
    
    var cardContentView: UIView {
        return headerView
    }

}

extension Type2ViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt
        indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath) as! TextToAnswerCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 340, height: 80)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 2, bottom: 3, right: 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            numeroText = indexPath.row
            print(numeroText)
            let vc = ExerciseWithFormViewController()
            vc.modalPresentationStyle = .fullScreen
            vc.view.backgroundColor = .white
            self.present(vc, animated: false)
        case 1:
            numeroText = indexPath.row
            print(numeroText)
            let vc = ExerciseWithFormViewController()
            vc.modalPresentationStyle = .fullScreen
            vc.view.backgroundColor = .white
            
            self.present(vc, animated: false)
        case 2:
             numeroText = indexPath.row
            print(numeroText)
            let vc = ExerciseWithFormViewController()
            vc.modalPresentationStyle = .fullScreen
            vc.view.backgroundColor = .white
           
            
            self.present(vc, animated: false)
            
        default:
            print("Altri casi poi li farò")
        }
    }
    
   
    
}

