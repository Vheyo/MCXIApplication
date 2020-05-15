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
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var descriptionExercise: UITextView!
    
    var background: UIImage? = nil
    var titleLabe : String? = nil
    var tagButton : Int? = nil
    var descrip : String? = nil
    
    private var buttonPlay : UIButton = {
        let buttonPlay = UIButton()
        buttonPlay.setTitle("Play", for: .normal)
        buttonPlay.setTitleColor(.white, for: .normal)
        buttonPlay.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        buttonPlay.backgroundColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        buttonPlay.translatesAutoresizingMaskIntoConstraints = false
        buttonPlay.addTarget(self, action: #selector(showExcercise), for: .touchUpInside)
        return buttonPlay
    }()
    
    
    private var backButton : UIButton = {
        let backButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.backgroundColor = .white
        backButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        backButton.layer.cornerRadius = 0.5 * backButton.bounds.size.width
        backButton.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        return backButton
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.clipsToBounds = true
        contentScrollView.delegate = self
        scrollView.contentInsetAdjustmentBehavior = .never
        contentScrollView.backgroundColor = .white
        contentView.backgroundColor = .white
        
        let _ = dismissHandler
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
        
        
        setUpConstraints()
        setUpLayoutButtonPlay()

            
        heightConstraint.constant = 400 * 0.85 - 16.0
        setUpLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        arrived99 = false
    }
    
    func setUpLayout(){
        titleLabel.textColor = .black
        descriptionExercise.textAlignment = .center
    }
    
    func setUpConstraints(){
        contentView.addSubview(buttonPlay)
        headerView.addSubview(backButton)
        NSLayoutConstraint.activate([
            
            backButton.topAnchor.constraint(equalTo: headerView.topAnchor,constant: 20),
            backButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            backButton.widthAnchor.constraint(equalToConstant: 40),

            buttonPlay.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            buttonPlay.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 70),
            buttonPlay.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -70),
            buttonPlay.heightAnchor.constraint(equalToConstant: 60),


            descriptionExercise.topAnchor.constraint(equalTo: buttonPlay.bottomAnchor,constant: 30),


        ])
    }
    

    
    func setUpLayoutButtonPlay(){
        descriptionExercise.isEditable = false
        buttonPlay.layer.cornerRadius = 30
        buttonPlay.addShadowView()
    }
    
    @objc func showExcercise(_ sender : UIButton){
        print(sender.tag)
        switch sender.tag{
        case 0:
            let formCopriEScopri = FormCopriScopriViewController()
            formCopriEScopri.modalPresentationStyle = .fullScreen
            formCopriEScopri.view.backgroundColor = .white
            self.present(formCopriEScopri,animated: true, completion: nil)
        case 1:
            performSegue(withIdentifier: "Rombo", sender: self);
        default :
            print("Fatal error");
        }
    
    }
    
    @objc func closeView(){
        self.dismiss(animated: true, completion: nil)
    }
}
var arrived99 : Bool = false

extension Type2ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // prevent bouncing when swiping down to close
        if scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y <= 50 && !arrived99 {
            backButton.alpha = 1
        }
        else if arrived99{
            backButton.alpha = 0
        }
        if scrollView.contentOffset.y == 98 {
            backButton.alpha = 0
            arrived99 = true
        }
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

//extension Type2ViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
//
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 3
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt
//        indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath) as! TextToAnswerCollectionViewCell
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 340, height: 80)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 2, bottom: 3, right: 2)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 5
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        switch indexPath.row {
//        case 0:
//            numeroText = indexPath.row
//            print(numeroText)
//            let vc = ExerciseWithFormViewController()
//            vc.modalPresentationStyle = .fullScreen
//            vc.view.backgroundColor = .white
//            self.present(vc, animated: false)
//        case 1:
//            numeroText = indexPath.row
//            print(numeroText)
//            let vc = ExerciseWithFormViewController()
//            vc.modalPresentationStyle = .fullScreen
//            vc.view.backgroundColor = .white
//
//            self.present(vc, animated: false)
//        case 2:
//             numeroText = indexPath.row
//            print(numeroText)
//            let vc = ExerciseWithFormViewController()
//            vc.modalPresentationStyle = .fullScreen
//            vc.view.backgroundColor = .white
//
//
//            self.present(vc, animated: false)
//
//        default:
//            print("Altri casi poi li farò")
//        }
//    }
//
//
//
//}

